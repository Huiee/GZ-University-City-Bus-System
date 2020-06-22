package net.huiee.service;

import net.huiee.dao.SearchBusDao;
import net.huiee.entity.Note;
import net.huiee.entity.SearchBus;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SearchBusService {
    @Resource
    SearchBusDao searchBusDao;
    //查看
    public  List<SearchBus> searchBusFaster(String station_A, String station_B){
        return searchBusDao.searchBusFaster(station_A, station_B);
    }

    public  List<SearchBus> searchBusFasterByPrice(String station_A, String station_B){
        return searchBusDao.searchBusFasterByPrice(station_A, station_B);
    }

     public  List<SearchBus> searchBusFasterByAll(String station_A,String station_B,String bus_number_A,String bus_number_B){
        return searchBusDao.searchBusFasterByAll(station_A, station_B, bus_number_A, bus_number_B);
     }
    public     List<SearchBus> searchBusFasterTwoByAll(String station_A,String station_B,String bus_number_A,String bus_number_B,String bus_number_D){
        return searchBusDao.searchBusFasterTwoByAll(station_A, station_B, bus_number_A, bus_number_B, bus_number_D);
    }
    public     List<SearchBus> searchBusFasterTwo(String station_A,String station_B){
        return searchBusDao.searchBusFasterTwo(station_A, station_B);
     }

    //增加
    public  int addsearchBusFaster(String station_A, String station_B,String bus_number_A,String change_station_C,String bus_number_B,Integer num,Integer A,Integer A_C,Integer C_B,Integer B,Integer price,String bus_time){
        return searchBusDao.addsearchBusFaster(station_A, station_B, bus_number_A, change_station_C, bus_number_B, num, A, A_C, C_B, B,price,bus_time);
    }

    public     int addsearchBusFasterTwo(String station_A,String station_B,String change_station_C1,String change_station_C2,String bus_number_A,String bus_number_B,String bus_number_D,Integer num,Integer A,Integer A_C,Integer num_C1,Integer num_C2,Integer C_B,Integer B,Integer price,String bus_time){
        return searchBusDao.addsearchBusFasterTwo(station_A, station_B, change_station_C1, change_station_C2, bus_number_A, bus_number_B, bus_number_D, num, A, A_C, num_C1, num_C2, C_B, B, price, bus_time);
    }

    //修改



}
