package net.huiee.dao;

import net.huiee.entity.BusMes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface BusMesDao extends JpaRepository<BusMes,String> {
//   --查询--
    //根据公交号码查询公交线路
    @Query(value = " select * from bus_mes where bus_number=?1 ",nativeQuery = true)
    List<BusMes> searchBusMesByNumber(String bus_number);

    //根据公交号码和方向查询公交线路
    @Query(value = " select * from bus_mes where bus_number=?1 and direction=?2 ",nativeQuery = true)
    BusMes searchBusMesByNumberAndDirection(String bus_number,String direction);

    @Query(value = " select * from bus_mes ",nativeQuery = true)
    List<BusMes> searchBusMesAll();
//    --增加--
    //增加线路
    @Transactional
    @Modifying
    @Query(value = "insert into bus_mes (bus_number,start_station,end_station,start_time,end_time,price,length,direction,bus_time) values(?1,?2,?3,?4,?5,?6,?7,?8,?9)",nativeQuery = true)
    int addBusMes(String bus_number,String start_station,String end_station,String start_time,String end_time,Integer price,String length,String direction,String bus_time);

//    --修改--

    //修改bus_number
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set bus_number=?2 where bus_number = ?1 ",nativeQuery = true)
    int updateBusMesBusNumber (String bus_number,String new_bus_number);

    //修改所有 start_station_name
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set start_station=?2 where start_station = ?1 ",nativeQuery = true)
    int updateBusMesStartStation (String start_station,String new_start_station);

    //修改所有 end_station_name
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set end_station=?2 where end_station = ?1 ",nativeQuery = true)
    int updateBusMesEndStation (String end_station,String new_end_station);

    //修改某一start_station_name
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set start_station=?2 where start_station = ?1 and bus_number = ?3",nativeQuery = true)
    int updateOneBusMesStartStation (String start_station,String new_start_station,String bus_number);

    //修改某一 end_station_name
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set end_station=?2 where end_station = ?1 and bus_number = ?3",nativeQuery = true)
    int updateOneBusMesEndStation (String end_station,String new_end_station,String bus_number);

    //修改start_time
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set start_time=?3 where bus_number = ?1 and direction = ?2",nativeQuery = true)
    int updateOneBusMesStartTime (String bus_number,String direction,String start_time);

    //修改end_time
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set end_time=?3 where bus_number = ?1 and direction = ?2",nativeQuery = true)
    int updateOneBusMesEndTime (String bus_number,String direction,String end_time);

    //修改price
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set price=?3 where bus_number = ?1 and direction = ?2",nativeQuery = true)
    int updateOneBusMesPrice (String bus_number,String direction,Integer price);

    //修改length
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set length=?3 where bus_number = ?1 and direction = ?2",nativeQuery = true)
    int updateOneBusMesLength (String bus_number,String direction,String length);

    //修改bus_time
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus_mes set bus_time=?3 where bus_number = ?1 and direction = ?2",nativeQuery = true)
    int updateOneBusMesBusTime (String bus_number,String direction,String bus_time);


    //    --删除--
    //删除BusMes一个方向
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "delete from bus_mes where bus_number=?1 and direction = ?2 ",nativeQuery = true)
    void deleteBusMes(String bus_number,String direction);

    //删除BusMes
    @Transactional
    @Modifying
    @Query(value = "delete from bus_mes where bus_number=?1  ",nativeQuery = true)
    void deleteBusMesAll(String bus_number);

}
