package net.huiee.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="admin_")
public class Admin {
    @Id
    String admin_id;
    String admin_password;
    String admin_picture;

    public String getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(String admin_id) {
        this.admin_id = admin_id;
    }

    public String getAdmin_password() {
        return admin_password;
    }

    public void setAdmin_password(String admin_password) {
        this.admin_password = admin_password;
    }

    public String getAdmin_picture() {
        return admin_picture;
    }

    public void setAdmin_picture(String admin_picture) {
        this.admin_picture = admin_picture;
    }

    public Admin() {
    }

    public Admin(String admin_id, String admin_password, String admin_picture) {
        this.admin_id = admin_id;
        this.admin_password = admin_password;
        this.admin_picture = admin_picture;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "admin_id='" + admin_id + '\'' +
                ", admin_password='" + admin_password + '\'' +
                ", admin_picture='" + admin_picture + '\'' +
                '}';
    }
}
