package net.huiee.service;

import net.huiee.dao.HistoryDao;
import net.huiee.entity.History;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class HistoryService {
    @Resource
    HistoryDao historyDao;
    public List<History> searchHistory(String user_id){
        return historyDao.searchHistory(user_id);
    }

    public List<History> searchHistoryByType(String user_id,String history_type){
        return historyDao.searchHistoryByType(user_id,history_type);
    }


    //增加
   public int addHistory(String user_id, String start, String destination, String history_time,String history_type){
        return historyDao.addHistory(user_id, start, destination, history_time, history_type);
   }


    //增加站点
    public int addHistoryStation(String user_id, String station_name, String history_time,String history_type){
        return historyDao.addHistoryStation(user_id, station_name, history_time, history_type);
    }

    //增加公交号码
    public int addHistoryBusNumber(String user_id, String bus_number, String history_time,String history_type){
        return historyDao.addHistoryBusNumber(user_id, bus_number, history_time, history_type);
    }


    //修改
    public int updateHistoryTime(String user_id, String old_history_time, String new_history_time){
        return historyDao.updateHistoryTime(user_id, old_history_time, new_history_time);
    }



    //删除
    public void deleteHistory(String user_id, String history_time){
        historyDao.deleteHistory(user_id, history_time);
    }
}
