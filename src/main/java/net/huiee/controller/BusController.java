package net.huiee.controller;

import net.huiee.entity.*;
import net.huiee.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.apache.tomcat.jni.Stdlib.memset;

@Controller
public class BusController {
    @Resource
    BusService busService;
    @Resource
    BusMesService busMesService;
    @Resource
    SearchBusService searchBusService;
    @Resource
    HistoryService historyService;
    @Resource
    NoteService noteService;

    //首页
    @RequestMapping("/showCover")
    public String showCover(Model model,HttpSession httpSession){
        List<String> bus_number=busService.getAllRoad();
        graph(bus_number);
        return "cover";
    }
    //根据线路号码查询页面
    @RequestMapping("showBusNumber")
    public String showbusNumber(){return "busNumber";}

    //检查换乘查询输入结果是否存在多种情况
    @RequestMapping("checkBusStationName")
    public String checkBusStationName(HttpSession session,Model model, String start, String end){
        List<String> busList_start = busService.searchStationNameByLikeStationName(start);
        List<String> busList_end = busService.searchStationNameByLikeStationName(end);
        System.out.println(busList_start.size()+"--size--"+busList_end.size());
        if(busList_start.size()>1||busList_end.size()>1){
            model.addAttribute("busList_start",busList_start);
            model.addAttribute("busList_end",busList_end);
            return "selectBus";
        }
        else {
            session.setAttribute("start",start);
            session.setAttribute("end",end);
        return "searchBusChange.do";
        }
    }

    //换乘查询
    @RequestMapping("searchBusChange.do")
    public String searchBusChange(HttpSession httpSession,Model model, String start, String end,String search_type){
       //检查空值
        if(start==null||end==null){
            start= (String)httpSession.getAttribute("start");
            end =(String)httpSession.getAttribute("end");
        }else {
            httpSession.setAttribute("start",start);
            httpSession.setAttribute("end",end);
        }

        //直达情况
        List<BusMes> BusMes = busMesService.searchBusMesAll();
        String user_id =(String) httpSession.getAttribute("user_id");
        //查询历史记录 如果有更新时间 没有则添加
        if (user_id != null && (!user_id.isEmpty())) {
            Date date=new Date();
            SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String new_hisotry_time = sim.format(date);
            //查询历史记录有没有重复
            List<History> histories = historyService.searchHistory(user_id);
            int flag=0;
            for(int i=0;i<histories.size();i++){
                if(histories.get(i).getStart()!=null&&histories.get(i).getStart().equals(start)&&histories.get(i).getDestination().equals(end)){
                    historyService.updateHistoryTime(user_id,histories.get(i).getHistory_time(),new_hisotry_time);
                    flag=1;
                    break;
                }
            }
            //没有历史记录
            if(flag==0) {
                historyService.addHistory(user_id,start,end,new_hisotry_time,"线路查询");
            }
        }

        //直达查询 go方向
        if(busService.searchBus(start, end)!=null){
            List<Bus> buses = busService.searchBus(start, end);
            model.addAttribute("buses",buses);
            httpSession.setAttribute("buses",buses);
            httpSession.setAttribute("busMes_Change",BusMes);
            System.out.println("go:"+buses);
        }
        //直达查询back方向
        if(busService.searchBusBack(start, end)!=null){
            List<Bus> buses_back = busService.searchBusBack(start, end);
            model.addAttribute("buses_back",buses_back);
            httpSession.setAttribute("buses_back",buses_back);
            httpSession.setAttribute("busMes_Change",BusMes);
            System.out.println("back"+buses_back);
        }
        //go和back方向都没直达公交---进入一次换乘查询
         if(busService.searchBus(start, end).isEmpty() && busService.searchBusBack(start, end).isEmpty()) {
            System.out.println("---找不到直达路线---进入一次查询---");
             //一次换乘
             if ((!busService.searchBusChange(start, end).isEmpty()) && (!busService.searchBusChange(end, start).isEmpty())) {
                 httpSession.removeAttribute("busMes_Change");
                 List<SearchBus> searchBusesFaster=null;
                 System.out.println("type"+search_type);
                 //如果有选择查看类型
                 if(search_type!=null){
                     if(search_type.equals("站点优先")){
                         searchBusesFaster =searchBusService.searchBusFaster(start,end);
                         System.out.println("站点优先");
                         System.out.println(searchBusesFaster);
                     }
                     if(search_type.equals("价格优先")){
                         searchBusesFaster =searchBusService.searchBusFasterByPrice(start,end);
                         System.out.println("价格优先");
                         System.out.println(searchBusesFaster);
                     }
                 }else{
                     //没有选择查询类型--默认查询顺序--快表
                     searchBusesFaster = searchBusService.searchBusFaster(start, end);
                     System.out.println("默认");
                 }
            //如果快表没有--查询数据库
                 if(searchBusesFaster.isEmpty()){
                     System.out.println("--一次换乘查询--");
                     searchOneChange(start, end);
                     searchBusesFaster=searchBusService.searchBusFaster(start,end);
                     if(!searchBusesFaster.isEmpty()){
                     System.out.println("一次换乘有结果");
                     model.addAttribute("changeOneResult",searchBusesFaster);}
                 }else{
                     //快表有结果--区分一次还是二次
                     if(searchBusesFaster.get(0).change_station_C2==null){
                     model.addAttribute("changeOneResult",searchBusesFaster);
                     }else {
                         searchBusesFaster=searchBusService.searchBusFasterTwo(start,end);
                         model.addAttribute("changeTwoResult",searchBusesFaster);
                         ArrayList<SearchBus> searchBusesC1=new ArrayList<SearchBus>();
                         ArrayList<SearchBus> searchBusesC2=new ArrayList<SearchBus>();
                         searchBusesC1=searchChangeStation(1,searchBusesC1,searchBusesFaster);
                         searchBusesC2=searchChangeStation(2,searchBusesC2,searchBusesFaster);
//                         for (int i = 0; i < searchBusesFaster.size() ; i++) {
//                             String change_C1=searchBusesFaster.get(i).change_station_C;
//                             String change_C2=searchBusesFaster.get(i).change_station_C2;
//                             String bus_A =searchBusesFaster.get(i).bus_number_A;
//                             String bus_B =searchBusesFaster.get(i).bus_number_B;
//                             String bus_D =searchBusesFaster.get(i).bus_number_D;
//                             int flag=0;
//                             int flag2=0;
//                             if(searchBusesC1==null){
//                                 searchBusesC1.add(searchBusesFaster.get(i));}
//                             if (searchBusesC2==null){
//                                 searchBusesC2.add(searchBusesFaster.get(i));
//                             }
//                             for (int j = 0; j <searchBusesC1.size() ; j++) {
//                                 if (searchBusesC1.get(j).change_station_C.equals(change_C1)&&
//                                         searchBusesC1.get(j).bus_number_A.equals(bus_A)&&
//                                         searchBusesC1.get(j).bus_number_B.equals(bus_B)&&
//                                         searchBusesC1.get(j).bus_number_D.equals(bus_D)){
//                                     flag=1;
//                                 }
//                             }
//                             for (int j = 0; j <searchBusesC2.size() ; j++) {
//                                 if (searchBusesC2.get(j).change_station_C2.equals(change_C2)&&
//                                         searchBusesC2.get(j).bus_number_A.equals(bus_A)&&
//                                         searchBusesC2.get(j).bus_number_B.equals(bus_B)&&
//                                         searchBusesC2.get(j).bus_number_D.equals(bus_D)){
//                                     flag2=1;
//                                 }
//                             }
//
//                             if(flag==0){
//                                 searchBusesC1.add(searchBusesFaster.get(i));
//                             }
//                             if(flag2==0){
//                                 searchBusesC2.add(searchBusesFaster.get(i));
//                             }
//                         }
//                         for (int i = 0; i <searchBusesFaster.size() ; i++) {
//                             System.out.println(searchBusesFaster);
//                         }
                        model.addAttribute("changeStationC1",searchBusesC1);
                         model.addAttribute("changeStationC2",searchBusesC2);
                     }
                 }
//                快表没有结果--查询数据库
                 if(searchBusesFaster.isEmpty()||searchBusesFaster==null) {
                     System.out.println("--二次换乘--");
                     searchTwoChange(start, end);
                     searchBusesFaster = searchBusService.searchBusFasterTwo(start, end);
                     if (searchBusesFaster.isEmpty() || searchBusesFaster == null) {
                         model.addAttribute("bus_null","找不到推荐路线");
                     }
                         model.addAttribute("changeTwoResult", searchBusesFaster);
                         ArrayList<SearchBus> searchBusesC1 = new ArrayList<SearchBus>();
                         ArrayList<SearchBus> searchBusesC2 = new ArrayList<SearchBus>();
                     searchBusesC1=searchChangeStation(1,searchBusesC1,searchBusesFaster);
                     searchBusesC2=searchChangeStation(2,searchBusesC2,searchBusesFaster);
                         model.addAttribute("changeStationC1", searchBusesC1);
                         model.addAttribute("changeStationC2", searchBusesC2);


                 }
             }
        }
        //收藏查询情况
        List<Note> notes=noteService.searchNote(user_id);
        model.addAttribute("notes",notes);
        return "cover";
    }

    //直达情况--详细站点go方向
    @RequestMapping("showBusMes")
    public String showBusMes(HttpSession httpSession,Model model,String bus_number,Integer start_num,Integer end_num){
        List<Bus> bus_mes = busService.searchBusByNumber(bus_number);
        model.addAttribute("bus_mes",bus_mes);
        model.addAttribute("start_num",start_num);
        model.addAttribute("end_num",end_num);
        System.out.println("---直达--详细站点--");
        return "cover";
    }
    //直达情况--详细站点back方向
    @RequestMapping("showBusMesBack")
    public String showBusMesBack(HttpSession httpSession,Model model,String bus_number,Integer start_num,Integer end_num){
        List<Bus> bus_mes = busService.searchBusByBackNumber(bus_number);
        model.addAttribute("bus_mes_back",bus_mes);
        model.addAttribute("start_num",start_num);
        model.addAttribute("end_num",end_num);
        return "cover";
    }
    //一次换乘---详细站点--不知道方向
    @RequestMapping("showBusMesAll")
    public String showBusMesAll(HttpSession httpSession,Model model,String bus_number_A,String bus_number_B,Integer num_A,Integer num_A_C,Integer num_C_B,Integer num_B,String start,String change,String end){
        List<Bus> bus_mes_A = busService.searchBusByNumber(bus_number_A);
        List<Bus> bus_mes_B = busService.searchBusByNumber(bus_number_B);
       //第一辆go方向(编号不会超过总长度)
        if(bus_mes_A.size()>=num_A) {
            System.out.println(bus_mes_A.get(num_A - 1).station_name + "--" + start + "--" + bus_mes_A.get(num_A_C - 1).station_name + "--" + change);
            if (bus_mes_A.get(num_A - 1).station_name.equals(start)) {
                if (bus_mes_A.get(num_A_C - 1).station_name.equals(change)) {
                    model.addAttribute("bus_A", bus_mes_A);
                    model.addAttribute("direction_A","go");
                } else {
                    List<Bus> bus_mes_A_back = busService.searchBusByBackNumber(bus_number_A);
                    model.addAttribute("bus_A", bus_mes_A_back);
                    model.addAttribute("direction_A","back");
                }
            } else {
                List<Bus> bus_mes_A_back = busService.searchBusByBackNumber(bus_number_A);
                model.addAttribute("bus_A", bus_mes_A_back);
                model.addAttribute("direction_A","back");
            }
        }

        //第二辆go方向
        if(bus_mes_B.size()>=num_B) {
            if (bus_mes_B.get(num_B - 1).station_name.equals(end)) {
                if (bus_mes_B.get(num_C_B - 1).station_name.equals(change)) {
                    model.addAttribute("bus_B", bus_mes_B);
                    model.addAttribute("direction_B","go");
                } else {
                    List<Bus> bus_mes_B_back = busService.searchBusByBackNumber(bus_number_B);
                    model.addAttribute("bus_B", bus_mes_B_back);
                    model.addAttribute("direction_B","back");
                }
            } else {
                List<Bus> bus_mes_B_back = busService.searchBusByBackNumber(bus_number_B);
                model.addAttribute("bus_B", bus_mes_B_back);
                model.addAttribute("direction_B","back");
            }
        }

        model.addAttribute("showBusChangeStation","true");
        model.addAttribute("num_A",num_A);
        model.addAttribute("num_A_C",num_A_C);
        model.addAttribute("num_C_B",num_C_B);
        model.addAttribute("num_B",num_B);
        System.out.println(num_A+"=="+num_A_C+"=="+num_C_B+"=="+num_B);
        return "cover";
    }
    //根据站点名称查询线路
    @RequestMapping("searchBusByStationName")
    public String searchBusByStationName(Model model,HttpSession session,String station_name){
        String user_id =(String) session.getAttribute("user_id");

        if (user_id != null && (!user_id.isEmpty())) {
            Date date=new Date();
            SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String new_hisotry_time = sim.format(date);
            //查询历史记录有没有重复
            List<History> histories = historyService.searchHistory(user_id);
            int flag=0;
            for(int i=0;i<histories.size();i++){
                if(histories.get(i).getStation_name()!=null&&histories.get(i).getStation_name().equals(station_name)){
                    historyService.updateHistoryTime(user_id,histories.get(i).getHistory_time(),new_hisotry_time);
                flag=1;
                break;
                }
            }
            if(flag==0) {
                historyService.addHistoryStation(user_id, station_name, new_hisotry_time, "站点查询");
            }
            }
        List<History> histories = historyService.searchHistoryByType(user_id,"站点查询");
        session.removeAttribute("user_show_hisotry");
        session.setAttribute("user_show_hisotry",histories);
        System.out.println("--站点查询--");
        System.out.println("站点名:"+station_name+"--"+session.getAttribute("new_station_name"));
        if(session.getAttribute("new_station_name")!=null){
            station_name=(String)session.getAttribute("new_station_name");
            session.removeAttribute("new_station_name");
        }
        List<Bus> bus = busService.searchBusByStationName(station_name);
        List<BusMes> busMes=busMesService.searchBusMesAll();
        model.addAttribute("busStation",bus);
        model.addAttribute("busMes",busMes);
        model.addAttribute("station_name",station_name);
        return "station";
    }

    //根据公交号码查询线路
    @RequestMapping("searchBusByNumber")
    public String searchBusByNumber(HttpServletRequest request,HttpSession session,Model model, String bus_number){
        String user_id =(String) session.getAttribute("user_id");
        if (user_id != null && (!user_id.isEmpty())) {
            Date date=new Date();
            SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String new_hisotry_time = sim.format(date);
            //查询历史记录有没有重复
            List<History> histories = historyService.searchHistory(user_id);
            int flag=0;
            for(int i=0;i<histories.size();i++){
                if(histories.get(i).getBus_number()!=null){
                    if(histories.get(i).getBus_number().equals(bus_number)){
                    historyService.updateHistoryTime(user_id,histories.get(i).getHistory_time(),new_hisotry_time);
                    flag=1;
                    break;}
                }
            }
            if(flag==0) {
                historyService.addHistoryBusNumber(user_id,bus_number,new_hisotry_time,"公交查询");
            }
        }

        System.out.println("--查询线路--");
        if(session.getAttribute("bus_number")!=null){
           bus_number=(String)session.getAttribute("bus_number");
            System.out.println(bus_number+"--");
            session.removeAttribute("bus_number");
        }

        System.out.println("线路号码："+bus_number);
        List<Bus> bus = busService.searchBusByNumber(bus_number);
        List<Bus> busBack = busService.searchBusByBackNumber(bus_number);
        List<BusMes> busMes = busMesService.searchBusMesByNumber(bus_number);

        if(!bus.isEmpty()){
            for(int i=0;i<busMes.size();i++){
                if(busMes.get(i).direction.equals("go")){
                    model.addAttribute("busMes",busMes.get(i));
                    model.addAttribute("bus_one",bus);
                    break;
                }
            }
        }
        if (!busBack.isEmpty()){
            for(int i=0;i<busMes.size();i++){
                if(busMes.get(i).direction.equals("back")){
                    model.addAttribute("busMes_two",busMes.get(i));
                    model.addAttribute("bus_two",busBack);
                    break;
                }
            }
        }
        model.addAttribute("bus_number" ,bus_number);

        return "busNumber";
    }


    //一次换乘
public ArrayList<SearchBus> searchOneChange(String start,String end) {
    ArrayList<SearchBus> searchBuses = new ArrayList<SearchBus>();
    System.out.println("---一次换乘查询---");
    //只经过出发地或目的地的公交号码
    List<Bus> bus_have_start = busService.searchBusChange(start, end);
    List<Bus> bus_have_end = busService.searchBusChange(end, start);
    //获取站点信息找中间站点
    ArrayList<List<Bus>> bus_s_all_go   = new ArrayList<List<Bus>>();
    ArrayList<List<Bus>> bus_s_all_back = new ArrayList<List<Bus>>();
    ArrayList<List<Bus>> bus_e_all_go   = new ArrayList<List<Bus>>();
    ArrayList<List<Bus>> bus_e_all_back = new ArrayList<List<Bus>>();

    ArrayList<Integer> s_go   = new ArrayList<Integer>();
    ArrayList<Integer> s_back = new ArrayList<Integer>();
    ArrayList<Integer> e_go   = new ArrayList<Integer>();
    ArrayList<Integer> e_back = new ArrayList<Integer>();

    //根据号码查询所有经过始发站站点
    setBusListPlus(bus_s_all_go,bus_s_all_back,bus_have_start,s_go,s_back);
    //  根据号码查询所有经过终点站站点
    setBusListPlus(bus_e_all_go,bus_e_all_back,bus_have_end,e_go,e_back);
    //找共同站点  要求：A< C <B  （注意：c的方向go/back与A、B一致）
    System.out.println("--找共同站点--");
    //go方向
    if (bus_s_all_go != null) {
        System.out.println("--经过始发站·go方向--总数：" + s_go.size());
        //遍历第一层：bus_s_all_go存放公交号码、s_go始发站站点数字
        searchBuses=setSearchBusPlus(searchBuses, bus_s_all_go,bus_e_all_go,bus_e_all_back,s_go,e_go,e_back,"go");
    }

    //--2.back方向 A< c <B --
    if (bus_s_all_back != null) {
        System.out.println("--经过始发站·back方向--");
        searchBuses=setSearchBusPlus(searchBuses, bus_s_all_back,bus_e_all_go,bus_e_all_back,s_back,e_go,e_back,"back");
    }
    System.out.println("---全部--");
    //排序
    searchBuses=Sort(searchBuses);
    System.out.println("sort");
    for (int i = 0; i <searchBuses.size() ; i++) {
        System.out.println(i+":"+searchBuses.get(i).bus_number_A+searchBuses.get(i).num_A+"-"+searchBuses.get(i).change_station_C+searchBuses.get(i).num_A_C+"--"+searchBuses.get(i).num_C_B+searchBuses.get(i).bus_number_B+searchBuses.get(i).num_B);
        //存快表
        if(i<15){
         searchBusService.addsearchBusFaster(start,end,searchBuses.get(i).bus_number_A ,searchBuses.get(i).change_station_C ,searchBuses.get(i).bus_number_B ,searchBuses.get(i).num,searchBuses.get(i).num_A,searchBuses.get(i).num_A_C,searchBuses.get(i).num_C_B,searchBuses.get(i).num_B,searchBuses.get(i).price,searchBuses.get(i).bus_time);
        }
    }
    return searchBuses;
}
//二次换乘中间站点
    public ArrayList<SearchBus> searchChangeStation(Integer o,ArrayList<SearchBus> changeStation, List<SearchBus> searchBusesFaster){
        String change_C=null;
        for (int i = 0; i < searchBusesFaster.size(); i++) {
            if(o==1){
                change_C= searchBusesFaster.get(i).change_station_C;}
            if (o==2){
                change_C= searchBusesFaster.get(i).change_station_C2; }
            String bus_A = searchBusesFaster.get(i).bus_number_A;
            String bus_B = searchBusesFaster.get(i).bus_number_B;
            String bus_D = searchBusesFaster.get(i).bus_number_D;
            int flag = 0;

            if (changeStation == null) {
                changeStation.add(searchBusesFaster.get(i));
            }

            for (int j = 0; j < changeStation.size(); j++) {
                if (changeStation.get(j).change_station_C.equals(change_C) &&
                        changeStation.get(j).bus_number_A.equals(bus_A) &&
                        changeStation.get(j).bus_number_B.equals(bus_B) &&
                        changeStation.get(j).bus_number_D.equals(bus_D)) {
                    flag = 1;
                }
            }

            if (flag == 0) {
                changeStation.add(searchBusesFaster.get(i));
            }
        }
        return changeStation;
    }
    //二次换乘
    public ArrayList<SearchBus> searchTwoChange(String start,String end) {
        ArrayList<SearchBus> searchBusesTwo = new ArrayList<SearchBus>();
        System.out.println("---二次换乘查询---");
        //只经过出发地或目的地的公交号码
        List<Bus> bus_have_start = busService.searchBusChange(start, end);
        List<Bus> bus_have_end = busService.searchBusChange(end, start);
        System.out.println("s：" + bus_have_start);
        System.out.println("e:" + bus_have_end);
        //获取站点信息找中间站点

        ArrayList<List<Bus>> bus_s_all_go = new ArrayList<List<Bus>>();
        ArrayList<List<Bus>> bus_s_all_back = new ArrayList<List<Bus>>();
        ArrayList<List<Bus>> bus_e_all_go = new ArrayList<List<Bus>>();
        ArrayList<List<Bus>> bus_e_all_back = new ArrayList<List<Bus>>();

        ArrayList<Integer> s_go = new ArrayList<Integer>();
        ArrayList<Integer> s_back = new ArrayList<Integer>();
        ArrayList<Integer> e_go = new ArrayList<Integer>();
        ArrayList<Integer> e_back = new ArrayList<Integer>();

        //根据号码查询所有经过始发站站点
        setBusListPlus(bus_s_all_go,bus_s_all_back,bus_have_start,s_go,s_back);

        //  根据号码查询所有经过终点站站点
        setBusListPlus(bus_e_all_go,bus_e_all_back,bus_have_end,e_go,e_back);

        System.out.println("找符合中转的公交即C1-C2");
        if(bus_s_all_go!=null){
            searchBusesTwo=setSearchBusTwoPlusEnd( searchBusesTwo, bus_s_all_go,bus_e_all_go, bus_e_all_back,s_go,e_go,e_back,start,end,"go");
        }
        if(bus_s_all_back!=null){
            searchBusesTwo=setSearchBusTwoPlusEnd( searchBusesTwo, bus_s_all_back,bus_e_all_go, bus_e_all_back,s_back,e_go,e_back,start,end,"back");
        }
        System.out.println("---全部符合结果--");
        //排序
        searchBusesTwo=Sort(searchBusesTwo);
        for(int n=0;n<searchBusesTwo.size();n++){
            System.out.println(searchBusesTwo.get(n).num+"c"+searchBusesTwo.get(n).bus_number_A+searchBusesTwo.get(n).change_station_C+searchBusesTwo.get(n).bus_number_D+searchBusesTwo.get(n).change_station_C2+searchBusesTwo.get(n).bus_number_B);
            //存快表
            if(n<15){
                searchBusService.addsearchBusFasterTwo(start,end,searchBusesTwo.get(n).change_station_C,searchBusesTwo.get(n).change_station_C2,searchBusesTwo.get(n).bus_number_A ,searchBusesTwo.get(n).bus_number_B ,searchBusesTwo.get(n).bus_number_D,searchBusesTwo.get(n).num,searchBusesTwo.get(n).num_A,searchBusesTwo.get(n).num_A_C,searchBusesTwo.get(n).num_C1,searchBusesTwo.get(n).num_C2,searchBusesTwo.get(n).num_C_B,searchBusesTwo.get(n).num_B,searchBusesTwo.get(n).price,searchBusesTwo.get(n).bus_time);
            }
        }
        //存快表
        return searchBusesTwo;
    }
//冒泡排序
    public ArrayList<SearchBus> Sort(ArrayList<SearchBus> searchBuses){
        //冒泡排序
        for (int i = 0; i < searchBuses.size(); i++) {
            for (int j = i + 1; j < searchBuses.size() ; j++) {
                if (searchBuses.get(i).getNum() > searchBuses.get(j).getNum()) {
                    SearchBus min_searchBus = searchBuses.get(j);
                    searchBuses.set(j, searchBuses.get(i));
                    searchBuses.set(i, min_searchBus);
                }
            }
        }
        return searchBuses;
    }

    //一次换乘——遍历所有线路划分方向1-1
    public void setBusListPlus(ArrayList<List<Bus>> bus_x_all_go,ArrayList<List<Bus>> bus_x_all_back,List<Bus> bus_have_y,ArrayList<Integer> x_go,ArrayList<Integer> x_back) {
        for (int i = 0; i < bus_have_y.size(); i++) {
            System.out.println("过始发站站点公交：" + bus_have_y.get(i).bus_number);
            //go方向 始发站
            Integer go_num = bus_have_y.get(i).go_number;
            if (go_num != null) {
                setBusList(bus_x_all_go,bus_have_y,"go",i,x_go);
            }

            // back方向 始发站
            Integer back_num = bus_have_y.get(i).back_number;
            if (back_num != null) {
                setBusList(bus_x_all_back,bus_have_y,"back",i,x_back);
            }
        }
    }
    //1-2.划分方向细节
    public void setBusList(ArrayList<List<Bus>> bus_x_all_y,List<Bus> bus_have_y,String y,int i,ArrayList<Integer> x_y){
        Integer bus_have_y_number =null;
        List<Bus> buses = null;
        if(y.equals("go")){
            bus_have_y_number = bus_have_y.get(i).go_number;
            buses = busService.searchBusByNumber(bus_have_y.get(i).bus_number);
        }
        if(y.equals("back")){
            bus_have_y_number = bus_have_y.get(i).back_number;
            buses = busService.searchBusByBackNumber(bus_have_y.get(i).bus_number);
        }
        bus_x_all_y.add(buses);
        x_y.add(bus_have_y_number);
    }
//一次换乘2-1终点站双方向
    public ArrayList<SearchBus> setSearchBusPlus(ArrayList<SearchBus> searchBuses,ArrayList<List<Bus>> bus_s_all_y,ArrayList<List<Bus>> bus_e_all_go, ArrayList<List<Bus>> bus_e_all_back,ArrayList<Integer> s_y,ArrayList<Integer> e_go,ArrayList<Integer> e_back,String s){
        for (int i = 0; i < bus_s_all_y.size(); i++) {
//            System.out.println("back:第" + i + ". "  + "站点号码 A:" + s_back.get(i));
            int num = 0;
//遍历第二层具体线路的每个站点(从起始站号码开始)A<C
            for (int k = s_y.get(i); k < bus_s_all_y.get(i).size(); k++) {
// 2-2-1.经过终点站·go方向--
                if (bus_e_all_go != null) {
                    //获取符合条件中间站点
                    searchBuses=setSearchBus(searchBuses,bus_s_all_y,bus_e_all_go,s_y,e_go,s,"go",i,k,num);
                }

//2-2-2.经过终点站·back方向--
                if (bus_e_all_back != null) {
                    //获取符合条件中间站点
                    searchBuses=setSearchBus(searchBuses,bus_s_all_y,bus_e_all_back,s_y,e_back,s,"back",i,k,num);
                }
            }
        }
        return searchBuses;
    }

    //一次换乘——2-2.找到符合条件的中间站点for(始发站for(终点站))searchBuses存放中间站点，bus_s_all_y只经过始发站（某方向）bus_e_all_y只经过终点站（某方向）S方向E方向
    public ArrayList<SearchBus> setSearchBus(ArrayList<SearchBus> searchBuses,ArrayList<List<Bus>> bus_s_all_y, ArrayList<List<Bus>> bus_e_all_y,ArrayList<Integer> s_y,ArrayList<Integer> e_y,String s,String e,int i, int k, int num){
        Integer bus_s_all_y_number=0;
        Integer bus_e_all_y_number=0;
        //1.区分方向获取始发站站点序号
        //途经出发站点公交为go方向
        if(s.equals("go")){
            bus_s_all_y_number =bus_s_all_y.get(i).get(k).go_number;
       }
        //途经出发站点公交为back方向
        if(s.equals("back")){
            bus_s_all_y_number =bus_s_all_y.get(i).get(k).back_number;
        }
         if(bus_s_all_y_number!=null) {
        for (int o = 0; o < bus_e_all_y.size(); o++) {
            for (int l = 0; l < e_y.get(o); l++) {
                //如果站点名相同
                if (bus_s_all_y.get(i).get(k).station_name.equals(bus_e_all_y.get(o).get(l).station_name)) {

        if (e.equals("go")) {
            bus_e_all_y_number = bus_e_all_y.get(o).get(l).go_number;
        }
        if (e.equals("back")) {
            bus_e_all_y_number = bus_e_all_y.get(o).get(l).back_number;
        }
        //该站点小于终点站站点序号C<B
        if (bus_e_all_y_number != null&&bus_e_all_y_number<e_y.get(o)) {
            String start_bus_number = bus_s_all_y.get(i).get(k).bus_number;
            String change_station = bus_s_all_y.get(i).get(k).station_name;
            String end_bus_number = bus_e_all_y.get(o).get(l).bus_number;
            //查询公交信息第一趟 start_bus_number 第二趟 end_bus_number 获取时间
            BusMes busOne =busMesService.searchBusMesByNumberAndDirection(start_bus_number,s);
            BusMes busTwo =busMesService.searchBusMesByNumberAndDirection(end_bus_number,e);
            //确保在同一时间段
            if(busOne.bus_time.equals(busTwo.bus_time)) {
                //价格
                Integer price = busOne.price+busTwo.price;
                //总共经过站点数
                Integer all_station_number = 1 + (bus_s_all_y_number - s_y.get(i)) + (e_y.get(o) - bus_e_all_y_number);
                System.out.println(num + ".经过总站点数(C-A)+(B-C)：" + all_station_number + "乘坐" + start_bus_number + "到" + change_station + "换乘" + end_bus_number);
                SearchBus searchBus = new SearchBus(start_bus_number, change_station, end_bus_number, s_y.get(i), bus_s_all_y_number, bus_e_all_y_number, e_y.get(o), all_station_number,price,busOne.bus_time);
                searchBuses.add(searchBus);
                System.out.println("-----");
                num++;
            }
        }
                    }
                }
            }
        }
        return searchBuses;
    }

    //二次换乘 end——go和back
    public ArrayList<SearchBus> setSearchBusTwoPlusEnd( ArrayList<SearchBus> searchBusesTwo, ArrayList<List<Bus>> bus_s_all_y,ArrayList<List<Bus>> bus_e_all_go,ArrayList<List<Bus>> bus_e_all_back,ArrayList<Integer> s_y,ArrayList<Integer> e_go,ArrayList<Integer> e_back,String start,String end,String s){
        for (int i=0;i<bus_s_all_y.size();i++) {
            for(int k = s_y.get(i)+1; k < bus_s_all_y.get(i).size(); k++) {
                //1-1.遍历经过终点站go方向
                System.out.println("二次换乘，A后"+k+bus_s_all_y.get(i).size()+bus_s_all_y.get(i).get(k));
                //s-go-c
                if (bus_e_all_go != null) {
                    //遍历第1-1-1层：bus_e_all_go存放公交号码、e_go终点站站点数字B、e_go_name公交线路
                    searchBusesTwo= setSearchBusTwoPlus(searchBusesTwo,bus_s_all_y,bus_e_all_go,s_y,e_go,start,end,s,"go",i,k);
                }
                //s-back-c
                if (bus_e_all_back != null) {
                    //遍历第1-1-1层：bus_e_all_go存放公交号码、e_go终点站站点数字B、e_go_name公交线路
                    searchBusesTwo= setSearchBusTwoPlus(searchBusesTwo,bus_s_all_y,bus_e_all_back,s_y,e_back,start,end,s,"back",i,k);
                }
            }
        }
        return searchBusesTwo;
    }
    //二次换乘 change——go和back
    public  ArrayList<SearchBus> setSearchBusTwoPlus( ArrayList<SearchBus> searchBusesTwo,ArrayList<List<Bus>> bus_s_all_y,ArrayList<List<Bus>> bus_e_all_y,ArrayList<Integer> s_y, ArrayList<Integer> e_y,String start,String end,String s,String e,int i,int k){
        for (int o = 0; o < bus_e_all_y.size(); o++) {
            for (int l = 0; l < e_y.get(o); l++) {
                String Station_C1=bus_s_all_y.get(i).get(k).station_name;
                String Station_C2 = bus_e_all_y.get(o).get(l).station_name;
                List<Bus> busList_change_go= busService.searchBus(Station_C1,Station_C2);
                List<Bus> busList_change_back= busService.searchBusBack(Station_C1,Station_C2);
                //s-e-go
                if(!busList_change_go.isEmpty()){
                    setSearchBusTwo( searchBusesTwo,bus_s_all_y,bus_e_all_y, busList_change_go,s_y, e_y,start,end,Station_C1, Station_C2,s,e,"go", o,l,i,k);
                }

                //s-e-back
                if(!busList_change_back.isEmpty()){
                    setSearchBusTwo( searchBusesTwo,bus_s_all_y,bus_e_all_y, busList_change_back,s_y, e_y,start,end,Station_C1, Station_C2,s,e,"back", o,l,i,k);
                }
            }
        }
        return searchBusesTwo;
    }

        //二次换乘——找中间线路 busList_change_go
    public  ArrayList<SearchBus> setSearchBusTwo(ArrayList<SearchBus> searchBusesTwo,ArrayList<List<Bus>> bus_s_all_y,ArrayList<List<Bus>> bus_e_all_y,List<Bus> busList_change_y, ArrayList<Integer> s_y, ArrayList<Integer> e_y,String start,String end,String Station_C1, String Station_C2,String s,String e,String c,int o,int l,int i,int k){
        Integer C1_num=null;
        Integer C2_num=null;
        Integer bus_s_all_y_number = null;
        Integer bus_e_all_y_number = null;
        //查询该线路始发站站点序号
        for(int n=0;n<busList_change_y.size();n++){
            if (busList_change_y.get(n).station_name.equals(Station_C1)){
                if(c.equals("go")){
                    C1_num=busList_change_y.get(n).go_number;
                }
                if(c.equals("back")){
                    C1_num=busList_change_y.get(n).back_number;
                }
            }
            if (busList_change_y.get(n).station_name.equals(Station_C2)){
                if(c.equals("go")){
                    C2_num=busList_change_y.get(n).go_number;
                }
                if(c.equals("back")){
                    C2_num=busList_change_y.get(n).back_number;
                }
                break;
            }
        }
        if(s.equals("go")){
            bus_s_all_y_number=bus_s_all_y.get(i).get(k).go_number;
        }
        if(s.equals("back")){
            bus_s_all_y_number=bus_s_all_y.get(i).get(k).back_number;
        }
        if(e.equals("go")){
            bus_e_all_y_number=bus_e_all_y.get(o).get(l).go_number;
        }
        if(e.equals("back")){
            bus_e_all_y_number=bus_e_all_y.get(o).get(l).back_number;
        }
        //查询公交信息第一趟 start_bus_number 第二趟 end_bus_number
        BusMes busOne =busMesService.searchBusMesByNumberAndDirection(bus_s_all_y.get(i).get(k).bus_number,s);
        BusMes busTwo =busMesService.searchBusMesByNumberAndDirection(busList_change_y.get(0).bus_number,c);
        BusMes busThree =busMesService.searchBusMesByNumberAndDirection(bus_e_all_y.get(o).get(l).bus_number,e);
        //确保在同一时间段
        if(busOne.bus_time.equals(busTwo.bus_time)&&busOne.bus_time.equals(busThree.bus_time)) {
            //价格
            Integer price = busOne.price+busTwo.price+busThree.price;
            Integer num =(bus_s_all_y_number- s_y.get(i))+(C2_num-C1_num)+(e_y.get(o)-bus_e_all_y_number)+3;
            SearchBus searchBuses = new SearchBus(start,end,Station_C1,Station_C2,bus_s_all_y.get(i).get(k).bus_number,busList_change_y.get(0).bus_number,bus_e_all_y.get(o).get(l).bus_number,s_y.get(i),bus_s_all_y_number,C1_num,C2_num,bus_e_all_y_number,e_y.get(o),num,price,busOne.bus_time);
            System.out.println("a"+s_y.get(i)+"A-c:"+bus_s_all_y_number+"c1"+C1_num+"c2"+C2_num+"cb"+bus_e_all_y_number+bus_e_all_y.get(o).get(l).station_name+"b"+e_y.get(o));
            //        System.out.println("----go-go-go--");
        searchBusesTwo.add(searchBuses);
        }
        return searchBusesTwo;
    }

    public ArrayList<String> changeBus(int[][] graph,List<String> bus_number,String busNumber_A,String busNumber_B){
        ArrayList<String> changeBus =null;
        //顶点数组
        int num =bus_number.size();
        String[] graph_station_name = new String[num];
        for (int i = 0; i <num ; i++) {
            graph_station_name[i]=bus_number.get(i);
        }
        int v1=0;
        int v2=0;
        for (int i = 0; i < num; i++) {
            graph_station_name[i]=bus_number.get(i);
            if(bus_number.get(i).equals(busNumber_A)){
                v1=i;
            }
            if(bus_number.get(i).equals(busNumber_B)){
                v2=i;
            }
        }
        //查看
        System.out.println("是否有"+graph[v1][v2]);
        for (int i = 0; i <num ; i++) {
            if(graph[v1][i]==1&&graph[i][v2]==1){
                System.out.println("换乘"+graph_station_name[i]);
                changeBus.add(graph_station_name[i]);
            }
        }
        return changeBus;
    }


    //构建线路交点二维数组
    public int[][] graph(List<String> bus_number){
        //获取所有公交线路号码

        Integer num = bus_number.size();
        //定义二维数组边
        int[][] graph = new int[num][num];
        System.out.println("初始化");
        //顶点数组
        String[] graph_station_name = new String[num];
        for (int i = 0; i <num ; i++) {
            graph_station_name[i]=bus_number.get(i);
        }
//


        //获取边
        //获取交点线路
        List<String> bus_change = busService.getRoadChange();
        for (int i = 0; i < bus_change.size(); i++) {
            String s =bus_change.get(i);
            System.out.println(bus_change.get(i));
            String[] as = s.split(",");
//            System.out.print(as[j]);
            //遍历某一条数据
            for (int j = 0; j < as.length; j++) {
                System.out.print(as[j]+" ");
                for (int k = j+1; k <as.length ; k++) {
                    int v1=0;
                    int v2=0;
                    for (int l = 0; l < num; l++) {
                       if(graph_station_name[l].equals(as[j])){
                            v1=l;
                        }
                        if(graph_station_name[l].equals(as[k])){
                            v2=l;
                        }
                    }
                    System.out.println("=="+as[j]+"--"+as[k]+v1+"--"+v2);
                    graph[v1][v2]=1;
                    graph[v2][v1]=1;
                }

            }

        }




        return graph;
    }

    //存边
//    public int[][] setV(int[][] graph,String[] graph_station_name , List<Bus> buses,Integer num){
//        for (int j = 0; j < buses.size()-1; j++) {
//            String station = buses.get(j).station_name;
//            String station_next = buses.get(j+1).station_name;
//            int v1=0;
//            int v2=0;
//            //找到二维数组对应位置
//            for (int k = 0; k < num; k++) {
//                if(graph_station_name[k].equals(station)){
//                    v1=k;
//                }
//                if(graph_station_name[k].equals(station_next)){
//                    v2=k;
//                }
//            }
//            graph[v1][v2]=1;
//        }
//        return graph;
//    }

    //                for (int j = 0; j < buses_go.size()-1; j++) {
//                    String station = buses_go.get(j).station_name;
//                    String station_next = buses_go.get(j+1).station_name;
//                    int v1=0;
//                    int v2=0;
//                    //找到二维数组对应位置
//                    for (int k = 0; k < num; k++) {
//                        if(graph_station_name[k].equals(station)){
//                            v1=k;
//                        }
//                        if(graph_station_name[k].equals(station_next)){
//                            v2=k;
//                        }
//                    }
//                    graph[v1][v2]=1;
//                }



}