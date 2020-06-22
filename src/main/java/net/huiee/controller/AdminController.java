package net.huiee.controller;

import net.huiee.entity.Admin;
import net.huiee.entity.Bus;
import net.huiee.entity.BusMes;
import net.huiee.entity.User;
import net.huiee.service.AdminService;
import net.huiee.service.BusMesService;
import net.huiee.service.BusService;
import net.huiee.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class AdminController {
    @Resource
    BusService busService;
    @Resource
    BusMesService busMesService;
    @Resource
    AdminService adminService;
    @Resource
    UserService userService;
    //
    @RequestMapping("adminLogin")
    public String adminLogin(){
        return "adminLogin";
    }
    @RequestMapping("exitAdmin")
    public String exitAdmin(HttpSession session){
        session.removeAttribute("admin_id");
        session.removeAttribute("user_name");

        return "cover";
    }
    //显示首页
    @RequestMapping("showAdminCover")
    public String showAdminCover(HttpSession session,String user_id,String user_password){
        List<Admin> admin = adminService.checkAdmin(user_id,user_password);
        System.out.println(user_id+"="+user_password);

        if(!admin.isEmpty()){
            if(session.getAttribute("user_id")!=null){
                session.removeAttribute("user_id");
                session.removeAttribute("user_name");
            }

            session.setAttribute("admin_id",user_id);
            session.setAttribute("user_name",user_id);

            return "cover";
        }
        else {
            return "adminLogin";
        }
    }

    //显示增加公交页面
    @RequestMapping("showAddBus")
    public String showAddBus(){
        return "addBus";
    }
    @RequestMapping("showAddTable.do")
    public String showAddTable(HttpSession session, String add_number){
        session.setAttribute("addNumber", Integer.valueOf(add_number));
        return "addBus";
    }

    //显示删除公交页面
    @RequestMapping("showDeleteBus")
    public String showDeleteBus(Model model){
        model.addAttribute("allBusMes",busMesService.searchBusMesAll());
        return "deleteBus";
    }

    //显示修改公交页面
    @RequestMapping("showUpdateBus")
    public String showUpdateBus(){
        return "updateBus";
    }

    //显示修改页面--输入公交号码后
    @RequestMapping("ShowUpdateBus.do")
    public String showUpdateBus(Model model,HttpSession session,String direction,String bus_number){

        model.addAttribute("updateBusMes",busMesService.searchBusMesByNumber(bus_number));
        //获取之前选择的方向
        if(session.getAttribute("direction")!=null){
            direction = (String)session.getAttribute("direction");
            session.removeAttribute("direction");
        }
        //显示修改线路所有信息——go方向一
        if(direction==null||direction.equals("go")){
            model.addAttribute("updateBus",busService.searchBusByNumberNull(bus_number));
        }
        //显示修改线路所有信息——back方向二
        if(direction!=null&&direction.equals("back")){
            session.setAttribute("direction",direction);
            model.addAttribute("updateBus",busService.searchBusByBackNumberNull(bus_number));

        }
        model.addAttribute("bus_number",bus_number);
        return "updateBus";
    }

    //修改站点名称（全部的）
    @RequestMapping("UpdateBusStationName.do")
    public String showUpdateBusStationName(Model model,HttpSession session,String station_name,String new_station_name){
       //修改Bus表中
        busService.updateBusStationNameAll(station_name,new_station_name);
        //修改bus_mes表中
        List<BusMes> busMes = busMesService.searchBusMesAll();
        for(int i = 0; i<busMes.size();i++){
            if(busMes.get(i).getStart_station().equals(station_name)){
                busMesService.updateBusMesStartStation(station_name,new_station_name);
            }
            if(busMes.get(i).getEnd_station().equals(station_name)){
                busMesService.updateBusMesEndStation(station_name,new_station_name);
            }
        }
//        model.addAttribute("new_station_name",new_station_name);
        session.setAttribute("new_station_name",new_station_name);

        return "searchBusByStationName";
    }

    //修改公交线路号码
    @RequestMapping("updateBusNumber.do")
    public String updateBusNumber(HttpSession session,String bus_number,String new_bus_number){
        busService.updateBusNumber(bus_number, new_bus_number);
        busMesService.updateBusMesBusNumber(bus_number, new_bus_number);
        session.setAttribute("bus_number",new_bus_number);
        return "searchBusByNumber";
    }
    //修改公交信息表
    @RequestMapping("updateBusMes.do")
    public String updateBusMes(String bus_number,String start_time,String end_time,String price,String length,String bus_time,String direction){
        List<BusMes> busMes = busMesService.searchBusMesByNumber(bus_number);
        for(int i=0;i<busMes.size();i++){
            if(busMes.get(i).direction.equals(direction)){
                System.out.println(!busMes.get(i).start_station.equals(start_time));
                if(!busMes.get(i).start_station.equals(start_time)){
                    busMesService.updateOneBusMesStartTime(bus_number, direction, start_time);
                }
                System.out.println(!busMes.get(i).end_time.equals(end_time));
                if(!busMes.get(i).end_time.equals(end_time)){
                    busMesService.updateOneBusMesEndTime(bus_number, direction, end_time);
                }
                System.out.println(!busMes.get(i).price.equals(Integer.valueOf(price)));

                if(!busMes.get(i).price.equals(Integer.valueOf(price))){
                    Integer new_price = Integer.valueOf(price);
                    busMesService.updateOneBusMesPrice(bus_number,direction,new_price);
                }
                if(!busMes.get(i).length.equals(length)){
                    busMesService.updateOneBusMesLength(bus_number, direction, length);
                }
                if(!busMes.get(i).bus_time.equals(bus_time)){
                    busMesService.updateOneBusMesBusTime(bus_number,direction,bus_time);
                }
                System.out.println("--修改BusMes完毕--");
            }
        }
        return "ShowUpdateBus.do";
    }
    //修改公交线路信息
    @RequestMapping("updateBus.do")
    public String updateBus(String bus_number,String station_name, String is_brt,String subway,String go_number,String back_number){
        List<Bus> buses = busService.searchBusByNumberNull(bus_number);
        String old_station_name = null;
        Boolean old_is_brt = null;
        String old_subway = null;
        Integer go = 0;
        Integer back = 0;
        System.out.println(bus_number+"--"+station_name+"--"+go_number);
        if(go_number!=null&&go_number!=""){
            go = Integer.valueOf(go_number);
            for(int i=0;i<buses.size();i++){
                if(buses.get(i).go_number==go){
                    old_station_name = buses.get(i).station_name;
                    old_is_brt = buses.get(i).is_brt;
                    old_subway = buses.get(i).subway;
                    break;
                }
            }
        }

        if(back_number!=null&&back_number!=""){
            back = Integer.valueOf(back_number);
            for (int i = 0; i < buses.size(); i++) {
                if (buses.get(i).back_number == back) {
                    old_station_name = buses.get(i).station_name;
                    old_is_brt = buses.get(i).is_brt;
                    old_subway = buses.get(i).subway;
                    break;
                }
            }
        }
        System.out.println(old_station_name+"=="+station_name+"--"+!old_station_name.equals(station_name));
        //修改站名
        if((!old_station_name.equals(station_name))&&old_station_name!=null){
            busService.updateBusStationName(bus_number,old_station_name,station_name);
            //特殊情况如始发站和终点站名修改
            if(go==1||back==1) {
                busMesService.updateOneBusMesStartStation(old_station_name, station_name, bus_number);
                System.out.println("--修改Mes结束--");
            }
            //特殊情况终点站名修改
            System.out.println(go+"--"+back+"--"+buses.size()+"!");
            if((buses.size()+1==go&&go!=1&&go!=0)||(buses.size()+1==back&&back!=1&&back!=0)){
                busMesService. updateOneBusMesEndStation(old_station_name, station_name, bus_number);
            }
            int go_size=0;
            int back_size= 0;
            if(!busService.searchBusByNumber(bus_number).isEmpty()) {
                go_size = busService.searchBusByNumber(bus_number).size();
            }
            if(!busService.searchBusByBackNumber(bus_number).isEmpty()) {
                back_size = busService.searchBusByBackNumber(bus_number).size();
            }
            System.out.println(go_number+"--"+go_size+"--"+back_number+"--"+back_size);
            if((go==go_size&&go_size!=0)||(back==back_size&&back_size!=0)){
                busMesService.updateOneBusMesEndStation(old_station_name,station_name,bus_number);
            }
        }
        System.out.println(old_is_brt+"old"+old_subway+"--"+is_brt+"--"+subway);
        if((old_is_brt==null&&is_brt.equals("true"))||(old_is_brt!=null&&is_brt.equals("false"))){
            if(is_brt.equals("false")){
                busService.updateBusIsBrt(bus_number,station_name,null);
            }
            else {
                busService.updateBusIsBrt(bus_number,station_name,true);
            }
        }

        if((old_subway==null&&subway!=null)||((old_subway!=null)&&(subway!=null)&&(!old_subway.equals(subway)))||(old_subway!=null&&station_name==null)){
           if(subway==null){
               busService.updateBusSubway(bus_number,station_name,null);

           }
           else {
               busService.updateBusSubway(bus_number, station_name, subway);
           }
        }

        return "ShowUpdateBus.do";
    }
    //修改公交线路你信息———— 增加站点
    @RequestMapping("updateAddBusStation.do")
    public String updateAddBusStation(Model model,HttpSession session,String bus_number,String go_number,String station_name,String back_number,String is_brt,String subway){

        System.out.println(go_number+"----test--"+bus_number+"--"+station_name+"--"+back_number);
        //新站点存入数据库
        busService.addBus(bus_number,station_name);
        //特殊情况如始发站和终点站名修改
        List<BusMes> busMes = busMesService.searchBusMesByNumber(bus_number);
        //go方向增加 中间站点
        if(go_number!=null&&go_number!=""){
            System.out.println("go:"+go_number);
            //获取go_number,因此修改都应该+1，
            Integer go = Integer.valueOf(go_number);
            //先修改后面number
            int bus_size = busService.searchBusByNumber(bus_number).size();
            System.out.println("size"+bus_size+"go"+go);
            for(int i=bus_size;i>=go;i--){
                int new_i = i+1;
                System.out.println("old_go"+i+"new"+new_i);
               int upd=busService.updateBusGoNumberByGoNumber(bus_number,i,new_i);
                System.out.println(i+"--"+upd);
            }
            //再插入
            busService.updateBusGoNumber(bus_number,station_name,go);

            //判断是否为首发 修改信息表
            if(go==1){
                for(int i=0;i<busMes.size();i++){
                    if(busMes.get(i).direction.equals("go")){
                        busMesService.updateOneBusMesStartStation(busMes.get(i).start_station,station_name,bus_number);
                    }
                }
            }
            System.out.println(go+"--go--"+bus_size);

            //是否为终点
            if(go==(bus_size+1)&&go!=0&&go!=1){
                System.out.println(go);
                for(int i=0;i<busMes.size();i++){
                    if(busMes.get(i).direction.equals("go")){
                        System.out.println(busMes.get(i).end_station+""+i);
                        busMesService.updateOneBusMesEndStation(busMes.get(i).end_station,station_name,bus_number);
                    }
                }
            }
        }
        //back方向  中间站点增加
        if(back_number!=null&back_number!=""&(!back_number.isEmpty())){
            System.out.println("back:"+back_number);
            Integer back = Integer.valueOf(back_number);
            //先修改后面number
            int bus_size = busService.searchBusByBackNumber(bus_number).size();
            for(int i=bus_size;i>=back;i--){
                int new_i = i+1;
                System.out.println("i:"+i+"back"+new_i);
               busService.updateBusBackNumberByBackNumber(bus_number,i,new_i);
            }
            busService.updateBusBackNumber(bus_number,station_name,back);
            //判断是否为首发 修改信息表
            if(back==1){
                for(int i=0;i<busMes.size();i++){
                    if(busMes.get(i).direction.equals("back")){
                        busMesService.updateOneBusMesStartStation(busMes.get(i).start_station,station_name,bus_number);
                    }
                }
            }
            //是否为终点
            System.out.println(back+"--back--"+bus_size);
            if(back==(bus_size+1)&&back!=0&&back!=1){
                System.out.println(back);
                for(int i=0;i<busMes.size();i++){
                    if(busMes.get(i).direction.equals("back")){
                        busMesService.updateOneBusMesEndStation(busMes.get(i).end_station,station_name,bus_number);
                    }
                }
            }
        }

        if(is_brt!=null&is_brt!=""){
            System.out.println("brt:"+is_brt);
            busService.updateBusIsBrt(bus_number,station_name,true);
        }
        if(subway!=null&subway!=""){
            System.out.println("subway:"+subway);
            busService.updateBusSubway(bus_number,station_name,subway);
        }
        System.out.println("----结束---");

        session.setAttribute("bus_number",bus_number);
        session.setAttribute("updateBusMes",busMesService.searchBusMesByNumber(bus_number));
        session.setAttribute("updateBus",busService.searchBusByNumberNull(bus_number));
        System.out.println(busService.searchBusByNumberNull(bus_number));
        return "updateBus";
    }

    @RequestMapping("refreshUpdate")
    public String refreshUpdate(HttpSession session){
        session.getAttribute("bus_number");
        session.getAttribute("updateBusMes");
        session.getAttribute("updateBus");
        return "updateBus";
    }

    //修改公交线路你信息———— 删除站点

    @RequestMapping("deleteBusStation.do")
    public String deleteBusStation(Model model,String bus_number,String station_name){
 //中间站点删除
//        go方向
        List<Bus> go_buses = busService.searchBusByNumber(bus_number);
//        back方向
        List<Bus> back_buses = busService.searchBusByBackNumber(bus_number);
        //go方向有则获取go_number
        int go = 0;
        for(int i =0;i<go_buses.size();i++){
            if(go_buses.get(i).station_name.equals(station_name)){
                go=go_buses.get(i).go_number;
                break;
            }
        }
        int back = 0;
        //back方向有获取back_number
        for(int i =0;i<back_buses.size();i++){
            if(back_buses.get(i).station_name.equals(station_name)){
                back = back_buses.get(i).back_number;
            break;
            }
        }
        //获取完先删除
        busService.deleteBusStation(bus_number,station_name);
        //修改go方向顺序
        if(go!=0){
            for(int o =go;o<go_buses.size();o++){
                int old_o = o+1;
                busService.updateBusGoNumberByGoNumber(bus_number,old_o,o);
            }
        }
        //修改back方向顺序
        if(back!=0){
            for(int o =back;o<back_buses.size();o++){
                int old_o = o+1;
                busService.updateBusBackNumberByBackNumber(bus_number,old_o,o);
            }
         }
//        站点删除结束 顺序修改完毕
        System.out.println("go"+go+"go_size"+go_buses.size()+"back"+back+"backsize"+back_buses.size());


        //检查是否为始发站或终点站 修改公交信息表
        List<BusMes> busMes =busMesService.searchBusMesByNumber(bus_number);
        //判断是否首发
        if(go==1){
            busMesService.updateOneBusMesStartStation(station_name,busService.searchBusByNumber(bus_number).get(0).station_name,bus_number);
        }
        if(back==1){
            busMesService.updateOneBusMesStartStation(station_name,busService.searchBusByBackNumber(bus_number).get(0).station_name,bus_number);
        }
        //是否为末尾
        if(go==(go_buses.size())&&go!=0&&go!=1){
            int end =go-2;
            System.out.println(busService.searchBusByNumber(bus_number).get(end).station_name);
            busMesService.updateOneBusMesEndStation(station_name,busService.searchBusByNumber(bus_number).get(end).station_name,bus_number);
        }
        if(back==(back_buses.size())&&back!=0&&back!=1){
            int end =back-2;
            System.out.println(station_name+"--"+busService.searchBusByBackNumber(bus_number).get(end).station_name+"--"+bus_number);
            int i =busMesService.updateOneBusMesEndStation(station_name,busService.searchBusByBackNumber(bus_number).get(end).station_name,bus_number);
            System.out.println(i);
        }
        model.addAttribute("bus_number",bus_number);
        return "ShowUpdateBus.do";
    }

    //删除公交线路
    @RequestMapping("deleteBus.do")
    public String deleteBus(String bus_number,String direction){
//        只删除一个方向
        if(direction!=null){
            List<BusMes> busMes = busMesService.searchBusMesByNumber(bus_number);
            int flag_go = 0;
            int flag_back = 0;
            for(int i=0;i<busMes.size();i++){
                if(busMes.get(i).direction.equals("go")){
                    flag_go = 1;
                }
                if(busMes.get(i).direction.equals("back")){
                    flag_back = 1;
                }
            }
//            两个方向同时存在 修改为null
            if(flag_go == 1 && flag_back == 1){
                if(direction.equals("go")){
                    busService.updateBusGo(bus_number);
                }
                if(direction.equals("back")){
                    busService.updateBusBack(bus_number);
                }
                //处理go和back都为空的站点
                List<Bus> buses = busService.searchBusByNumberNull(bus_number);
                for(int i=0;i<buses.size();i++){
                    if(buses.get(i).go_number==null&&buses.get(i).back_number==null){
                        busService.deleteBusStation(bus_number,buses.get(i).station_name);
                    }
                }
            }
            else {
                //只有一个方向 直接删除
                busService.deleteBus(bus_number);
            }
            busMesService.deleteBusMes(bus_number, direction);

        }
        else {
            //全都都删除
            busService.deleteBus(bus_number);
            busMesService.deleteBusMesAll(bus_number);

        }
        return "showDeleteBus";
    }

    //增加公交线路
    @RequestMapping("addBus.do")
    public String addBus(HttpServletRequest request,Model model, HttpSession session){
        String bus_number=request.getParameter("bus_number");
        Integer num = (Integer)session.getAttribute("addNumber");

       for(int i=1;i<=num;i++){
//           System.out.println("go"+request.getParameter("go_number_"+i)+request.getParameter("station_name_"+i)+request.getParameter("back_number_"+i)+request.getParameter("is_brt_"+i)+request.getParameter("subway_"+i));
         //站名
          String station_name = request.getParameter("station_name_"+i);
          //存入数据库
           busService.addBus(bus_number,station_name);
           if(!request.getParameter("go_number_"+i).equals("")){
               System.out.println("go:"+request.getParameter("go_number_"+i));
               int go_price = Integer.valueOf(request.getParameter("go_price"));
            busService.updateBusGoNumber(bus_number,station_name,Integer.valueOf(request.getParameter("go_number_"+i)));
                if(Integer.valueOf(request.getParameter("go_number_"+i))==1){
                    busMesService.addBusMes(bus_number,request.getParameter("station_name_"+i),request.getParameter("go_end_station"),request.getParameter("go_start_time"),request.getParameter("go_end_time"),go_price,request.getParameter("go_length")+"公里","go",request.getParameter("time"));
                }
           }
           if(!request.getParameter("back_number_"+i).equals("")){
               System.out.println("back:"+request.getParameter("back_number_"+i));
               int back_price = Integer.valueOf(request.getParameter("back_price"));
           busService.updateBusBackNumber(bus_number,station_name,Integer.valueOf(request.getParameter("back_number_"+i)));
               if(Integer.valueOf(request.getParameter("back_number_"+i))==1){
                   busMesService.addBusMes(bus_number,request.getParameter("station_name_"+i),request.getParameter("back_end_station"),request.getParameter("back_start_time"),request.getParameter("back_end_time"),back_price,request.getParameter("back_length")+"公里","back",request.getParameter("time"));
               }
           }
           if(request.getParameter("is_brt_"+i)!=null){
               System.out.println("brt:"+request.getParameter("is_brt_"+i));
            busService.updateBusIsBrt(bus_number,station_name,true);
           }
           if(!request.getParameter("subway_"+i).equals("")){
               System.out.println("subway:"+request.getParameter("subway_"+i));
               busService.updateBusSubway(bus_number,station_name,request.getParameter("subway_"+i));
           }
           System.out.println("----结束---");
       }
        return "searchBusByNumber";
    }
    //查看所有用户数据页面
    @RequestMapping("showAllUserMes")
    public String showAllUserMes(Model model,HttpSession session){
        List<User> users = userService.checkAllUser();
        model.addAttribute("users",users);
        if(!users.isEmpty()){
            Integer girl = 0 ;
            Integer boy = 0 ;
            Integer age_80 =0;
            Integer age_85 =0;
            Integer age_90 =0;
            Integer age_95 =0;
            Integer age_00 =0;
            for(int i=0;i<users.size();i++){
                //性别统计
                if(users.get(i).getUser_sex().equals("女")){
                    girl ++;
                }else {
                    boy++;
                }
                //年龄统计
                Integer year = Integer.valueOf(users.get(i).getUser_birthday().substring(0,4));
                if(1985>year&& year>=1980){
                    age_80 ++;
                }
                if(1990>year&& year>=1985){
                    age_85 ++;
                }
                if(1995>year&& year>=1990){
                    age_90 ++;
                }
                if(2000>year&& year>=1995){
                    age_95 ++;
                }
                if(year>=2000){
                    age_00 ++;
                }
                session.setAttribute("girl",girl);
                session.setAttribute("boy",boy);

                session.setAttribute("age_80",age_80);

                session.setAttribute("age_85",age_85);

                session.setAttribute("age_90",age_90);

                session.setAttribute("age_95",age_95);

                session.setAttribute("age_00",age_00);
            }

        }
        return "adminCheckUser";
    }

    //根据id查询用户
    @RequestMapping("searchUser.do")
    public String searchUser(Model model,String user_id){
        List<User> users= userService.searchUserId(user_id);
        model.addAttribute("users",users);
        return "adminCheckUser";
    }

    //修改用户登录权限
    @RequestMapping("updateUserState")
    public String updateUserState(Model model,String user_id,String block_time){
        System.out.println(user_id+"--"+block_time);
            if(block_time.length()>=2){
                userService.updUserState(user_id,false,block_time);
            }
        List<User> users = userService.checkAllUser();
        model.addAttribute("users",users);
        return "adminCheckUser";
    }
    //修改用户登录权限
    @RequestMapping("UserStateFree")
    public String UserStateFree(Model model,String user_id){
        System.out.println("--"+user_id);
            userService.updUserState(user_id,true,"");
        List<User> users = userService.checkAllUser();
        model.addAttribute("users",users);
        return "adminCheckUser";
    }
}
