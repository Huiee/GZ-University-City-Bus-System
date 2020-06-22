package net.huiee.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table ( name = "user")
public class User {
    @Id
    String user_id;
    String user_name;
    String user_password;
    String user_birthday;
    Boolean user_state;        //检查用户是否封号状态
    String user_bolock_time;   //封号时间
    String user_sex;
    String user_picture;

    public User() {
        super();
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_password() {
        return user_password;
    }

    public void setUser_password(String user_password) {
        this.user_password = user_password;
    }

    public String getUser_birthday() {
        return user_birthday;
    }

    public void setUser_birthday(String user_birthday) {
        this.user_birthday = user_birthday;
    }

    public Boolean getUser_state() {
        return user_state;
    }

    public void setUser_state(Boolean user_state) {
        this.user_state = user_state;
    }

    public String getUser_bolock_time() {
        return user_bolock_time;
    }

    public void setUser_bolock_time(String user_bolock_time) {
        this.user_bolock_time = user_bolock_time;
    }

    public String getUser_sex() {
        return user_sex;
    }

    public void setUser_sex(String user_sex) {
        this.user_sex = user_sex;
    }

    public String getUser_picture() {
        return user_picture;
    }

    public void setUser_picture(String user_picture) {
        this.user_picture = user_picture;
    }


    public User(String user_id, String user_name, String user_password, String user_birthday, Boolean user_state, String user_bolock_time, String user_sex, String user_picture) {
        this.user_id = user_id;
        this.user_name = user_name;
        this.user_password = user_password;
        this.user_birthday = user_birthday;
        this.user_state = user_state;
        this.user_bolock_time = user_bolock_time;
        this.user_sex = user_sex;
        this.user_picture = user_picture;
    }

    @Override
    public String toString() {
        return "User{" +
                "user_id='" + user_id + '\'' +
                ", user_name='" + user_name + '\'' +
                ", user_password='" + user_password + '\'' +
                ", user_birthday='" + user_birthday + '\'' +
                ", user_state=" + user_state +
                ", user_bolock_time='" + user_bolock_time + '\'' +
                ", user_sex='" + user_sex + '\'' +
                ", user_picture='" + user_picture + '\'' +
                '}';
    }
}
