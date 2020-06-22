package net.huiee.controller;

import net.huiee.entity.History;
import net.huiee.entity.Note;
import net.huiee.entity.User;
import net.huiee.service.BusService;
import net.huiee.service.HistoryService;
import net.huiee.service.NoteService;
import net.huiee.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class UserController{
    @Resource
    UserService userService;

    @Resource
    NoteService noteService;

    @Resource
    HistoryService historyService;
    @Resource
    BusService busService;
//页面

    @RequestMapping("station")
    public String showStation(){return "station";}

    @RequestMapping("exit")
    public String Exit(HttpSession session){
        session.removeAttribute("user_id");
        session.removeAttribute("user_name");
        session.removeAttribute("user_picture");
        return "showCover";
    }
    //登陆
    @RequestMapping("showLogin")
    public String showLogin(){
        return "login";
    }

    @RequestMapping("login.do")
    public String checkUser(Model model , HttpSession httpSession,String user_id , String user_password){
        List<User> user = userService.checkUser(user_id,user_password);
        System.out.println(user_id+"="+user_password);
        System.out.println(user);
        if(!user.isEmpty()){
           Boolean user_state= user.get(0).getUser_state();//检查账号是否正常
           System.out.println(user_state);
            Date date=new Date();
            SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd");
            String today = sim.format(date);
           if(user_state==false){
               //获取今天日期如果超过就解封
                String bolock_time = user.get(0).getUser_bolock_time();
               try {
                   Date date1 = sim.parse(today);
                   Date date2 = sim.parse(bolock_time);
                   int compareTo = date1.compareTo(date2);
                   System.out.println(compareTo);
                    if(compareTo>=0){
                        String user_bolock_time = "";
                        userService.updUserState(user_id,true,user_bolock_time);
                        User userMes = userService.checkUserMessage(user_id);
                        if(userMes.getUser_picture()!=null){
                            model.addAttribute("user_picture",userMes.getUser_picture());
                        }else {
//                            model.addAttribute("user_picture","p1.jpg");
                            httpSession.setAttribute("user_picture","p1.jpg");
                        }
                        if(httpSession.getAttribute("admin_id")!=null){
                            httpSession.removeAttribute("admin_id");
                            httpSession.removeAttribute("user_name");
                        }
                        httpSession.setAttribute("user_name",user.get(0).getUser_name());
                        httpSession.setAttribute("user_id",user_id);

                        return "showCover";
                    }else{
                        System.out.println("账号被冻结，暂时无法登陆，冻结至:"+user.get(0).getUser_bolock_time());
                        model.addAttribute("block_id","账号被冻结，暂时无法登陆");
                        model.addAttribute("block_time","冻结至："+user.get(0).getUser_bolock_time());
                        return "login";
                    }
               } catch (ParseException e) {
                   e.printStackTrace();
               }
           }

            User userMes = userService.checkUserMessage(user_id);
            if(userMes.getUser_picture()!=null){
               httpSession.setAttribute("user_picture",userMes.getUser_picture());
            }else {
                httpSession.setAttribute("user_picture","p1.jpg");
            }
            httpSession.setAttribute("user_name",user.get(0).getUser_name());
            httpSession.setAttribute("user_id",user_id);
            List<Note> noteList = noteService.searchNoteByCollect(user_id,true);
            httpSession.setAttribute("user_note_collect",noteList);
            List<History> histories = historyService.searchHistoryByType(user_id,"站点查询");
            httpSession.setAttribute("user_show_hisotry",histories);

            List<Note> notes_clock =noteService.searchNoteByClock(user_id,today);
            httpSession.setAttribute("notes_clock",notes_clock);
            System.out.println("--"+histories);
           return "showCover";
        } else {
            if (user_id != null) {
                model.addAttribute("login_id", user_id);
                model.addAttribute("error_id", "密码错误!");
            }
            return "login";
        }
    }

    //注册
    @RequestMapping("register.do")
    public String register(Model model){
        Date date=new Date();
        SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd");
        String today = sim.format(date);
        model.addAttribute("today",today);
        return "register";
    }
    @RequestMapping("addUser.do")
    public String addUser(Model model,HttpSession httpSession,String user_id , String user_name , String user_password , String user_birthday , String user_sex){
        Boolean checkUserID = userService.checkUserId(user_id);
        model.addAttribute("register_id",user_id);
        model.addAttribute("register_name",user_name);
        model.addAttribute("register_birthday",user_birthday);
        System.out.println(user_sex);
        //检查用户账号是否存在
        if(checkUserID){
            Boolean user_state = true;
            Boolean user_money_state = true;
            userService.addUser(user_id, user_name, user_password, user_birthday, user_sex,user_state);
            return "login";
        }
        model.addAttribute("exist_id","该账号已存在!");
        return "register";
    }


    //查看用户个人资料
    @RequestMapping("showUserMessage.do")
    public String getUserId(Model model,HttpSession httpSession,String id){
        httpSession.setAttribute("user_id",id);
        return "showUserMessage";
    }
//查看个人资料
    @RequestMapping("showUserMessage")
    public String showUserMessage(Model model,HttpSession httpSession){
        String user_id = (String)httpSession.getAttribute("user_id");
        String user_name = (String)httpSession.getAttribute("user_name");
        User userMessage = userService.checkUserMessage(user_id);
        model.addAttribute("user_birthday",userMessage.getUser_birthday());
        model.addAttribute("user_sex",userMessage.getUser_sex());
        return "userMessage";
    }

//    修改用户个人资料
    @RequestMapping("/updateUserName")
    public  String updateUserMessage(HttpSession httpSession,String new_user_name){
        String user_id = (String)httpSession.getAttribute("user_id");
        if(new_user_name.length()>0){
            userService.updUserName(user_id,new_user_name);
        }
        httpSession.removeAttribute("user_name");
        httpSession.setAttribute("user_name",new_user_name);
        return "showUserMessage";
    }
    @RequestMapping("updateUserPicture")
    public String updateUserPicture(HttpSession session,String new_user_picture){
        String user_id = (String)session.getAttribute("user_id");
        if(new_user_picture.length()>0){
            userService.updUserPicture(user_id,new_user_picture);
        }
        System.out.println("=="+new_user_picture);
        session.removeAttribute("user_picture");
        session.setAttribute("user_picture",new_user_picture);
        return "showUserMessage";
    }


}
