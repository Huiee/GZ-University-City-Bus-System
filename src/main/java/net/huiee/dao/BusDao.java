package net.huiee.dao;

import net.huiee.entity.Bus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

public interface BusDao  extends JpaRepository<Bus,String> {

    //增加线路
    @Transactional
    @Modifying
    @Query(value = "insert into bus(bus_number,station_name) values(?1,?2)",nativeQuery = true)
    int addBus(String bus_number,String station_name);

    //修改线路 bus_number
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus set bus_number = ?2 where bus_number=?1 ",nativeQuery = true)
    int updateBusNumber (String bus_number,String new_bus_number);

    //修改某一线路 station_name
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus set station_name=?3  where bus_number=?1 and station_name =?2 ",nativeQuery = true)
    int updateBusStationName (String bus_number,String station_name,String new_station_name);

    //修改所有线路 station_name
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus set station_name=?2 where station_name = ?1 ",nativeQuery = true)
    int updateBusStationNameAll (String station_name,String new_station_name);
    //修改线路 go_number
    @Transactional
    @Modifying
    @Query(value = "update bus set go_number = ?3 where bus_number=?1 and station_name=?2",nativeQuery = true)
    int updateBusGoNumber (String bus_number,String station_name,Integer go_number);

//根据原来的go_number为判断  因插入修改go_number顺序

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus set go_number = ?3 where bus_number=?1 and go_number=?2",nativeQuery = true)
    int updateBusGoNumberByGoNumber (String bus_number,Integer go_number,Integer new_go_number);

    //根据原来的back_number为判断  因插入修改back_number顺序
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus set back_number = ?3 where bus_number=?1 and back_number=?2",nativeQuery = true)
    int updateBusBackNumberByBackNumber (String bus_number,Integer back_number,Integer new_back_number);

    //修改线路 back_number
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus set back_number = ?3 where bus_number=?1 and station_name=?2",nativeQuery = true)
    int updateBusBackNumber (String bus_number,String station_name,Integer back_number);

    //修改线路 is_brt
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus set is_brt = ?3 where bus_number=?1 and station_name=?2",nativeQuery = true)
    int updateBusIsBrt (String bus_number,String station_name,Boolean is_brt);

    //修改线路 subway
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update bus set subway = ?3 where bus_number=?1 and station_name=?2",nativeQuery = true)
    int updateBusSubway (String bus_number,String station_name,String subway);

    //删除Bus
    @Transactional
    @Modifying
    @Query(value = "delete from bus where bus_number=?1 ",nativeQuery = true)
    void deleteBus(String bus_number);

    //删除某一站点
    @Transactional
    @Modifying
    @Query(value = "delete from bus where bus_number=?1 and station_name = ?2  ",nativeQuery = true)
    void deleteBusStation(String bus_number,String station_name);

    //半删除Bus go方向(修改)
    @Transactional
    @Modifying
    @Query(value = "update bus set go_number = null where bus_number=?1 ",nativeQuery = true)
    int updateBusGo (String bus_number);

    @Transactional
    @Modifying
    @Query(value = "update bus set back_number = null where bus_number=?1 ",nativeQuery = true)
    int updateBusBack (String bus_number);

//   查询
    //根据公交号码查询公交线路
    @Query(value = " select * from bus where bus_number=?1 and go_number is not null order by go_number ",nativeQuery = true)
    List<Bus> searchBusByNumber(String bus_number);

    //根据公交号码查询公交线路
    @Query(value = " select * from bus where bus_number=?1 and back_number is not null order by back_number ",nativeQuery = true)
    List<Bus> searchBusByBackNumber(String bus_number);


    //根据公交号码查询公交线路——允许空
    @Query(value = " select * from bus where bus_number=?1 order by go_number ",nativeQuery = true)
    List<Bus> searchBusByNumberNull(String bus_number);

    //根据公交号码查询公交线路——允许空
    @Query(value = " select * from bus where bus_number=?1  order by back_number ",nativeQuery = true)
    List<Bus> searchBusByBackNumberNull(String bus_number);

    //根据公交站点查询途经公交
//  模糊查询
    @Query(value = " select * from bus where  station_name like %?1% order by station_name",nativeQuery = true)
    List<Bus> searchBusByStationName(String station_name);

    //模糊查询获取站点名字
    @Query(value = " select distinct station_name from bus where  station_name like %?1%",nativeQuery = true)
    List<String> searchStationNameByLikeStationName(String station_name);
    //直达
    //   方向1
    @Query(value = " select * from bus  where go_number is not null and  bus_number in (" +
            " select t1.bus_number from(select * from bus  where station_name = ?1) t1 ," +
            "(select * from bus  where station_name = ?2) t2" +
            "    where t1.go_number < t2.go_number and   t1.bus_number = t2.bus_number )  order by  bus_number,go_number",nativeQuery = true)
    List<Bus> searchBus(String start,String end);
//   方向2
    @Query(value = " select * from bus  where back_number is not null and  bus_number in (" +
            " select t1.bus_number from(select * from bus  where station_name = ?1) t1 ," +
            "(select * from bus  where station_name = ?2) t2" +
            "    where t1.back_number < t2.back_number and   t1.bus_number = t2.bus_number )  order by  bus_number,back_number",nativeQuery = true)
    List<Bus> searchBusBack(String start,String end);

    //一次换乘
    @Query(value = "select * from bus where station_name =?1 and bus_number not in(" +
            "select bus_number from bus where station_name = ?2  )",nativeQuery = true)
    List<Bus> searchBusChange(String start,String end);

    //获取点
    @Query(value = "select distinct station_name from bus where bus_number  in (select bus_number from bus where station_name =?1 and bus_number not in" +
            "(select bus_number from bus where station_name =?2 )) " +
            "or bus_number in(select bus_number from bus where station_name =?2 and bus_number not in" +
            "(select bus_number from bus where station_name =?1 )) ",nativeQuery = true)
    List<String> allStation(String start,String end);

    //获取所有可交换线路
    @Query(value = "select distinct group_concat(bus_number separator ',') as bus_number " +
            "from bus group by station_name having count(station_name) >1 ",nativeQuery = true)
    List<String> getRoadChange();

    //获取所有线路

    @Query(value = "select distinct bus_number from bus",nativeQuery = true)
    List<String> getAllRoad();
}
