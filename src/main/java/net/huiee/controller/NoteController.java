package net.huiee.controller;


import com.alibaba.fastjson.JSON;
import net.huiee.entity.Bus;
import net.huiee.entity.Note;
import net.huiee.entity.SearchBus;
import net.huiee.service.BusService;
import net.huiee.service.NoteService;
import net.huiee.service.SearchBusService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class NoteController {

    @Resource
    NoteService noteService;
    @Resource
    SearchBusService searchBusService;
    @Resource
    BusService busService;

    //目录页
    @RequestMapping("showNoteTitle")
    public String showNoteTitle(Model model, HttpSession session){
        String user_id = (String)session.getAttribute("user_id");
        List<Note> notes = noteService.searchNote(user_id);
        model.addAttribute("notes",notes);

//        model.addAttribute("notes_clock",notes_clock);
        return "note";
    }

    //查看具体内容
    @RequestMapping("checkNote")
    public String checkNote(Model model,HttpSession session,String note_time){
        String user_id = (String)session.getAttribute("user_id");
        List<Note> notes = noteService.searchNote(user_id);
        if(note_time==null){
            note_time = (String)  session.getAttribute("note_time");
            session.removeAttribute("note_time");
        }
        for(int i=0;i<notes.size();i++){
            System.out.println(notes.get(i).note_time+"--"+note_time);
            System.out.println(notes.get(i).note_time.equals(note_time));
            if(notes.get(i).note_time.equals(note_time)){
                model.addAttribute("note_title",notes.get(i).note_title);
                model.addAttribute("note",notes.get(i).note);
                model.addAttribute("note_time",notes.get(i).note_time);
                if(notes.get(i).clock_state!=null&&notes.get(i).clock_state==true){
                model.addAttribute("note_clock",notes.get(i).clock);
                }
                break;
            }
        }
        return "showNote";
    }

    //显示增加页
    @RequestMapping("showAddNote")
    public String showAddNote(){
       return "showNote";
    }

    //修改收藏
    @RequestMapping("updateCollect")
    public String updateCollect(HttpSession session,Model model,String note_time,String collect){
        String user_id = (String)session.getAttribute("user_id");
        Boolean col = Boolean.valueOf(collect);
        noteService.updateNoteCollect(user_id,note_time,col);
        session.removeAttribute("user_note_collect");
        List<Note> noteList = noteService.searchNoteByCollect(user_id,true);
        session.setAttribute("user_note_collect",noteList);

        return "showNoteTitle";
    }
    //增加收藏--直达
    @RequestMapping("collectResult")
    public String addLike(HttpSession session, Model model, String start, String end){
        String user_id = (String)session.getAttribute("user_id");
        List<Note> notes = noteService.searchNote(user_id);
        String note_title = start+"->"+end;
        int flag=0;
        String note="可乘坐";
        String old_time =null;
        List<Bus> bus_go=(List<Bus>) session.getAttribute("buses");
        List<Bus> bus_back =(List<Bus>) session.getAttribute("buses_back");
        System.out.println("aa:"+bus_go+"--"+bus_back);

        if(!bus_go.isEmpty()){
            int go_number=0;
            for (int i=0;i<bus_go.size();i++){
                if(bus_go.get(i).station_name.equals(start)){
                    go_number=bus_go.get(i).go_number;
                }
                if(go_number!=0&&bus_go.get(i).station_name.equals(end)){
                    System.out.println("找到");
                    note=note+bus_go.get(i).bus_number+"(坐"+(bus_go.get(i).go_number-go_number+1)+"站)、";
                }
            }
        }
        if (!bus_back.isEmpty()){
            int back_number=0;
            for (int i=0;i<bus_back.size();i++){
                if(bus_back.get(i).station_name.equals(start)){
                    back_number=bus_back.get(i).back_number;
                }
                if(back_number!=0&&bus_back.get(i).station_name.equals(end)){
                    note=note+bus_back.get(i).bus_number+"(坐"+(bus_back.get(i).back_number-back_number+1)+"站)、";
                }
            }
        }

        Date date=new Date();
        SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String note_time = sim.format(date);
            note = note+ "到" + end + "下车";
            noteService.addNote(user_id,note_title, note,note_time);

        noteService.updateNoteCollect(user_id,note_time,true);
        System.out.println("--收藏成功--");
        session.removeAttribute("user_note_collect");
        List<Note> noteList = noteService.searchNoteByCollect(user_id,true);
        session.setAttribute("user_note_collect",noteList);
        return "searchBusChange.do";
    }
    //增加收藏--一次换乘
    @RequestMapping("collectResultChange")
    public String addLikeChange(HttpSession session,Model model,String start,String end,String bus_number_A,String bus_number_B,String num){
        String user_id = (String)session.getAttribute("user_id");
        String note_title = start+"->"+end;
        List<SearchBus> searchBuses = searchBusService.searchBusFasterByAll(start,end,bus_number_A,bus_number_B);

        List<Note> notes = noteService.searchNote(user_id);
        System.out.println(notes);
        int flag=0;
        String note=null;
        String old_time =null;
        for(int o=0; o<notes.size();o++){
            System.out.println("o:"+o+notes.get(o).note_title+"--"+note_title+"--"+notes.get(o).note_title.equals(note_title));
            if(notes.get(o).note_title.equals(note_title)){
                System.out.println("已存在");
                old_time=notes.get(o).note_time;
                flag=1;
                note=notes.get(o).note+";\r\n \r\n"+bus_number_A+"->"+bus_number_B+":"+ "乘坐"+bus_number_A+ "到";
                break;
            }
        }
        Date date=new Date();
        SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String note_time = sim.format(date);
        if(flag==0) {
           note =bus_number_A+"->"+bus_number_B+":"+ "乘坐" + bus_number_A + "到";}

        for (int i=0;i<searchBuses.size();i++){
            note =note + searchBuses.get(i).change_station_C+"(共"+searchBuses.get(i).getNum()+"站）、";
        }
        note=note+"换乘"+bus_number_B+"到"+end+"下车";
        if(flag==0){
        noteService.addNote(user_id,note_title, note,note_time);
    }
        else {
        noteService.updateNote(user_id,old_time,note_time,note);
    }
        noteService.updateNoteCollect(user_id,note_time,true);
        System.out.println("--收藏成功--");
        session.removeAttribute("user_note_collect");
        List<Note> noteList = noteService.searchNoteByCollect(user_id,true);
        session.setAttribute("user_note_collect",noteList);
        return "searchBusChange.do";
    }

    //增加收藏--二次换乘
    @RequestMapping("collectResultChangeTwo")
    public String addLikeChangeTwo(HttpSession session, Model model, String start, String end, String bus_number_A, String bus_number_B, String bus_number_D, String num){
        String user_id = (String)session.getAttribute("user_id");
        String note_title = start+"->"+end;
        List<SearchBus> searchBuses = searchBusService.searchBusFasterTwoByAll(start,end,bus_number_A,bus_number_B,bus_number_D);
        ArrayList<SearchBus> changeStationC1 = new ArrayList<SearchBus>();
        ArrayList<SearchBus> changeStationC2 = new ArrayList<SearchBus>();

        changeStationC1=searchChangeStation(1,changeStationC1,searchBuses);
        changeStationC2=searchChangeStation(2,changeStationC2,searchBuses);
        List<Note> notes = noteService.searchNote(user_id);
        System.out.println(notes);
        int flag=0;
        String note=null;
        String old_time =null;
        //查看是否存在该标题
        for(int o=0; o<notes.size();o++){
            System.out.println("o:"+o+notes.get(o).note_title+"--"+note_title+"--"+notes.get(o).note_title.equals(note_title));
            if(notes.get(o).note_title.equals(note_title)){
                System.out.println("已存在");
                old_time=notes.get(o).note_time;
                flag=1;
                note=notes.get(o).note+";\r\n \r\n"+bus_number_A+"->"+bus_number_D+"->"+bus_number_B+":"+"乘坐"+bus_number_A+ "到";
                break;
            }
        }
        Date date=new Date();
        SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String note_time = sim.format(date);
//        如果不存在该标题
        if(flag==0) {
            note = bus_number_A+"->"+bus_number_D+"->"+bus_number_B+":"+"乘坐" + bus_number_A + "到";}

        for (int i=0;i<changeStationC1.size();i++){
                Integer num_AC=changeStationC1.get(i).num_A_C-changeStationC1.get(i).num_A;
            note =note + changeStationC1.get(i).change_station_C+"(共"+num_AC+"站）、";
        }
        note=note+"换乘"+bus_number_D+"到";
        for (int i=0;i<changeStationC2.size();i++){
                Integer num_CB=changeStationC2.get(i).num_B-changeStationC2.get(i).num_C_B;
                note =note + changeStationC2.get(i).change_station_C2+"(共"+num_CB+"站）、";
        }
        note=note+"换乘"+bus_number_B+"到"+end+"下车";
        if(flag==0){
            noteService.addNote(user_id,note_title, note,note_time);
        }
        else {
            noteService.updateNote(user_id,old_time,note_time,note);
        }
        noteService.updateNoteCollect(user_id,note_time,true);
        System.out.println("--收藏成功--");
        session.removeAttribute("user_note_collect");
        List<Note> noteList = noteService.searchNoteByCollect(user_id,true);
        session.setAttribute("user_note_collect",noteList);
        return "searchBusChange.do";
    }

    //增加
    @RequestMapping("addNote.do")
    public String addNote(HttpSession session,Model model,String note_title,String note,String clock_time){
        String user_id = (String)session.getAttribute("user_id");
        Date date=new Date();
        SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String note_time = sim.format(date);
//        model.addAttribute("note_time",note_time);
        if(note_title==null||note_title==""){
            if(note.length()>10){
                note_title=note.substring(0,9)+"...";
            }
            else {
                note_title=note+"...";
            }
        }

        noteService.addNote(user_id,note_title,note,note_time);
        if(clock_time!=null&&clock_time!=""){
            noteService.updateClock(user_id,note_time,clock_time,true);
            model.addAttribute("note_clock",clock_time);
        }
        model.addAttribute("note_title",note_title);
        model.addAttribute("note",note);
        model.addAttribute("note_time",note_time);

        System.out.println("增加记事");
        return "showNote";
    }

    //删除闹钟
    @RequestMapping("deleteClock")
    public void deleteClock(HttpServletResponse response, HttpSession session,String note_time, String clock_time){
        String user_id = (String)session.getAttribute("user_id");
        System.out.println(note_time);
        noteService.updateClock(user_id,note_time,null,false);
        //        刷新提醒
        Date date=new Date();
        SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd");
        String today = sim.format(date);
        session.removeAttribute("notes_clock");
        List<Note> notes_clock =noteService.searchNoteByClock(user_id,today);
        session.setAttribute("notes_clock",notes_clock);
        System.out.println("--删除闹钟--");
    }

    //增加/修改闹钟
    @RequestMapping("updateClock")
    public String updateClock(Model model,  HttpSession session, String note_time, HttpServletRequest request, String clock_time){
        String user_id = (String)session.getAttribute("user_id");
        noteService.updateClock(user_id,note_time,clock_time,true);
        model.addAttribute("note_clock",clock_time);
        System.out.println("--修改闹钟--"+clock_time+note_time);
        session.setAttribute("note_time",note_time);
        // 刷新提醒
        Date date=new Date();
        SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd");
        String today = sim.format(date);
        session.removeAttribute("notes_clock");
        List<Note> notes_clock =noteService.searchNoteByClock(user_id,today);
        session.setAttribute("notes_clock",notes_clock);
        return  "checkNote";
    }

    //修改内容
    @RequestMapping("updateNote")
    public String updateNote(HttpSession session,Model model,String note_title,String note,String note_time){
        String user_id = (String)session.getAttribute("user_id");
        Date date=new Date();
        SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String new_note_time = sim.format(date);
        if(note_title==null||note_title==""){
            if(note.length()>10){
                note_title=note.substring(0,9)+"...";
            }
            else {
                note_title=note+"...";
            }
        }

        model.addAttribute("note_title",note_title);
        model.addAttribute("note",note);
        model.addAttribute("note_time",new_note_time);

        List<Note> notes = noteService.searchNote(user_id);

        for(int i=0;i<notes.size();i++){
            if(notes.get(i).note_time.equals(note_time)){
                String old_note_title =notes.get(i).note_title;
                String old_note = notes.get(i).note;
                Boolean old_clock_state = notes.get(i).clock_state;
                String old_clock_time = notes.get(i).clock;
                if(!old_note.equals(note)){
                    noteService.updateNote(user_id,note_time,new_note_time,note);
                }
                if(!old_note_title.equals(note_title)){
                    noteService.updateNoteTitle(user_id,note_time,new_note_time,note_title);
                }
                System.out.println("--Note修改完毕--");
                break;
            }
        }

        return "showNote";
    }

    //删除内容
    @RequestMapping("deleteNote")
    public String deleteNote(HttpSession session,String note_time){
        String user_id = (String)session.getAttribute("user_id");
        noteService.deleteNote(user_id,note_time);
        System.out.println(note_time+"--删除完毕--");
        return "showNoteTitle";
    }

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
}
