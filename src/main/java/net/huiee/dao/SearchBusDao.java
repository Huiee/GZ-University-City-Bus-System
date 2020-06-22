package net.huiee.dao;

import net.huiee.entity.SearchBus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface SearchBusDao extends JpaRepository<SearchBus,String> {

    //查看 优先顺序-公交车-站点-价格 bus_number_A,num,price
    @Query(value = " select * from search_bus_faster where station_A = ?1 and station_B =?2 order by num,price,bus_number_A,bus_number_D,bus_number_B ",nativeQuery = true)
    List<SearchBus> searchBusFaster(String station_A,String station_B);

    //查看 优先顺序 价格-站点
    @Query(value = " select * from search_bus_faster where station_A = ?1 and station_B =?2 order by price,bus_number_A,bus_number_D,bus_number_B,num ",nativeQuery = true)
    List<SearchBus> searchBusFasterByPrice(String station_A,String station_B);

    //查看 优先顺序-公交车-站点-价格 bus_number_A,num,price
    @Query(value = " select * from search_bus_faster where station_A = ?1 and station_B =?2 order by price,bus_number_A,bus_number_D,bus_number_B,num",nativeQuery = true)
    List<SearchBus> searchBusFasterTwo(String station_A,String station_B);

//    //查看 changeC1
//    @Query(value = " select number,bus_number_A,bus_number_B,bus_number_D,change from search_bus_faster where station_A = ?1 and station_B =?2 order by num,price,bus_number_A,bus_number_B ",nativeQuery = true)
//    List<SearchBus> searchBusChangeStationC1(String station_A,String station_B);
    //收藏--查看--一次
    @Query(value = " select * from search_bus_faster where station_A = ?1 and station_B =?2  and bus_number_A=?3 and bus_number_B =?4 order by bus_number_A,num,price ",nativeQuery = true)
    List<SearchBus> searchBusFasterByAll(String station_A,String station_B,String bus_number_A,String bus_number_B);

    //收藏--查看--二次
    @Query(value = " select * from search_bus_faster where station_A = ?1 and station_B =?2  and bus_number_A=?3 and bus_number_B =?4 and bus_number_D=?5 order by num,price ",nativeQuery = true)
    List<SearchBus> searchBusFasterTwoByAll(String station_A,String station_B,String bus_number_A,String bus_number_B,String bus_number_D);

    //增加——一次换乘
    @Transactional
    @Modifying
    @Query(value = "insert into  search_bus_faster(station_A,station_B,bus_number_A,change_station_C,bus_number_B,num,num_A,num_A_C,num_C_B,num_B,price,bus_time) values(?1,?2,?3,?4,?5,?6,?7,?8,?9,?10,?11,?12)",nativeQuery = true)
    int addsearchBusFaster(String station_A, String station_B,String bus_number_A,String change_station_C,String bus_number_B,Integer num,Integer A,Integer A_C,Integer C_B,Integer B,Integer price,String bus_time);

    //增加——二次换乘
//    public String change_station_C2;//站点 A-C C-C2 C2-B
//    public String bus_number_D;//公交：A-D-B
//    public Integer num_C1;
//    public Integer num_C2;
    @Transactional
    @Modifying
    @Query(value = "insert into  search_bus_faster(station_A,station_B,change_station_C,change_station_C2,bus_number_A,bus_number_B,bus_number_D,num,num_A,num_A_C,num_C1,num_C2,num_C_B,num_B,price,bus_time) values(?1,?2,?3,?4,?5,?6,?7,?8,?9,?10,?11,?12,?13,?14,?15,?16)",nativeQuery = true)
    int addsearchBusFasterTwo(String station_A,String station_B,String change_station_C1,String change_station_C2,String bus_number_A,String bus_number_B,String bus_number_D,Integer num,Integer A,Integer A_C,Integer num_C1,Integer num_C2,Integer C_B,Integer B,Integer price,String bus_time);

    //修改



}
