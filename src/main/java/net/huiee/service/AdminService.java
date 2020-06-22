package net.huiee.service;

import net.huiee.dao.AdminDao;
import net.huiee.entity.Admin;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AdminService {
    @Resource
    AdminDao adminDao;
    public List<Admin> checkAdmin(String user_id, String user_password){
        return adminDao.checkAdmin(user_id, user_password);
    }

}
