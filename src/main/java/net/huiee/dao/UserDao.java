package net.huiee.dao;

import net.huiee.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface UserDao  extends JpaRepository<User,Double> {
    //注册
    //查询id是否重复
    @Query(value = "select * from user where user_id=?1 ",nativeQuery = true)
   List<User> checkUserId(String user_id);

    //增加新用户
    @Transactional
    @Modifying
    @Query(value = "insert into user(user_id , user_name ,user_password , user_birthday , user_sex,user_state) values(?1,?2,?3,?4,?5,?6)",nativeQuery = true)
    int addUser( String user_id , String user_name , String user_password , String user_birthday , String user_sex,Boolean user_state);

    //登陆，user_state 检查用户是否封号状态
    @Query(value = "select * from user where user_id=?1 and user_password=?2",nativeQuery = true)
    List<User> checkUser(String user_id, String user_password);

    //查询个人信息
    @Query(value = "select * from user where user_id=?1",nativeQuery = true)
    User checkUserMessage(String user_id);
    //模糊查询个人信息
    //模糊标题查询
    @Query(value = " select * from user where user_id like %?1% ",nativeQuery = true)
    List<User> searchUserId(String user_id);

    //查看所有用户
    @Query(value = "select * from user",nativeQuery = true)
    List<User> checkAllUser();

    //换头像
    @Transactional
    @Modifying
    @Query(value = "update user set user_picture=?2 where user_id=?1",nativeQuery = true)
    void updUserPicture(String user_id,String user_picture);

    //换昵称
   @Transactional
   @Modifying
   @Query(value = "update user set user_name=?2 where user_id=?1",nativeQuery = true)
   void updUserName(String user_id,String user_name);

   //换密码
   @Transactional
   @Modifying
   @Query(value = "update user set user_password=?2 where user_id=?1",nativeQuery = true)
   void updUserPassword(String user_id,String user_password);


    //   账号状态调整
    @Transactional
    @Modifying
    @Query(value = "update user set user_state=?2,user_bolock_time=?3 where user_id=?1",nativeQuery = true)
    void updUserState(String user_id,Boolean user_state,String user_bolock_time);


  }
