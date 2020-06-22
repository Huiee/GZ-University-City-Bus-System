package net.huiee.dao;

import net.huiee.entity.Admin;
import net.huiee.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import javax.annotation.Resource;
import java.util.List;

public interface AdminDao extends JpaRepository<Admin,String> {
    @Query(value = "select * from admin_ where admin_id=?1 and admin_password=?2 ",nativeQuery = true)
    List<Admin> checkAdmin(String admin_id, String admin_password);
}
