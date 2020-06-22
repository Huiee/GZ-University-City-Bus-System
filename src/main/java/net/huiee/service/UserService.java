package net.huiee.service;

import net.huiee.dao.UserDao;
import net.huiee.entity.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserService {
    @Resource
    UserDao userDao;
    //注册
    //1.查询ID是否重复(注册)
    public boolean checkUserId(String user_id){
        List<User> user = userDao.checkUserId(user_id);
        if(!user.isEmpty()){
            return false;
        }
        return true;
    }
    //2.ID不重复则可增加新用户
    public int addUser( String user_id , String user_name , String user_password , String user_birthday ,String user_sex,Boolean user_state){
        return userDao.addUser(user_id , user_name ,user_password , user_birthday ,user_sex,user_state);
    }

    //登陆验证
    public List<User> checkUser(String user_id, String user_password){
        return  userDao.checkUser(user_id,user_password);
    }

    //查看个人信息
    public User checkUserMessage(String user_id){
       return  userDao.checkUserMessage(user_id);
    }

   //修改个人信息
    public void updUserPicture(String user_id,String picture){
        userDao.updUserPicture(user_id,picture);
    }


    public void updUserName(String user_id,String user_name){
        userDao.updUserName(user_id, user_name);
    }


    public void updUserPassword(String user_id,String user_password){
        userDao.updUserPassword(user_id, user_password);
    }

    public List<User> checkAllUser(){
        return  userDao.checkAllUser();
    }

    public List<User> searchUserId(String user_id){return userDao.searchUserId(user_id);}

    //   账号状态调整
    public void updUserState(String user_id,Boolean user_state,String user_bolock_time){
        userDao.updUserState(user_id, user_state, user_bolock_time);
    }
}
