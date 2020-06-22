package net.huiee.dao;

import net.huiee.entity.History;
import net.huiee.entity.Note;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface HistoryDao extends JpaRepository<History,String> {

    //查看
    @Query(value = " select * from history where user_id = ?1 order by history_time desc",nativeQuery = true)
    List<History> searchHistory(String user_id);

    //查看
    @Query(value = " select * from history where user_id = ?1 and history_type = ?2 order by history_time desc",nativeQuery = true)
    List<History> searchHistoryByType(String user_id,String history_type);

    //查看
    @Query(value = " select * from history where user_id = ?1 and history_time = ?2 order by history_time desc",nativeQuery = true)
    List<History> searchHistoryByTime(String user_id,String history_time);

    //增加换乘查询
    @Transactional
    @Modifying
    @Query(value = "insert into history(user_id,start,destination,history_time,history_type) values(?1,?2,?3,?4,?5)",nativeQuery = true)
    int addHistory(String user_id, String start, String destination, String history_time,String history_type);


    //增加站点查询
    @Transactional
    @Modifying
    @Query(value = "insert into history(user_id,station_name,history_time,history_type) values(?1,?2,?3,?4)",nativeQuery = true)
    int addHistoryStation(String user_id, String station_name, String history_time,String history_type);

    //增加公交号码查询
    @Transactional
    @Modifying
    @Query(value = "insert into history(user_id,bus_number,history_time,history_type) values(?1,?2,?3,?4)",nativeQuery = true)
    int addHistoryBusNumber(String user_id, String bus_number, String history_time,String history_type);


    //修改
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update history set history_time = ?3 where user_id=?1 and history_time =?2 ",nativeQuery = true)
    int updateHistoryTime(String user_id, String old_history_time, String new_history_time);

    //删除
    @Transactional
    @Modifying
    @Query(value = "delete from history where user_id=?1 and history_time=?2 ",nativeQuery = true)
    void deleteHistory(String user_id, String history_time);

}
