package net.huiee.service;

import net.huiee.dao.BusMesDao;
import net.huiee.entity.BusMes;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BusMesService {
    @Resource
    BusMesDao busMesDao;
    public int addBusMes(String bus_number,String start_station,String end_station,String start_time,String end_time,Integer price,String length,String direction,String bus_time){
        return busMesDao.addBusMes(bus_number, start_station, end_station, start_time, end_time, price, length, direction, bus_time);
    }

    public BusMes searchBusMesByNumberAndDirection(String bus_number,String direction){
        return busMesDao.searchBusMesByNumberAndDirection(bus_number, direction);
    }

    public void deleteBusMes(String bus_number,String direction){
        busMesDao.deleteBusMes(bus_number, direction);
    }

    public  void deleteBusMesAll(String bus_number){
        busMesDao.deleteBusMesAll(bus_number);
    }

    //修改bus_number
    public int updateBusMesBusNumber (String bus_number,String new_bus_number){
        return busMesDao.updateBusMesBusNumber(bus_number, new_bus_number);
    }


    //修改所有 start_station_name
    public int updateBusMesStartStation (String start_station,String new_start_station){
        return busMesDao.updateBusMesStartStation(start_station, new_start_station);
    }

    //修改所有 end_station_name
    public int updateBusMesEndStation (String end_station,String new_end_station){
        return busMesDao.updateBusMesEndStation(end_station, new_end_station);
    }
    //修改某一start_station_name
      public int updateOneBusMesStartStation (String start_station,String new_start_station,String bus_number){
        return busMesDao.updateOneBusMesStartStation(start_station, new_start_station, bus_number);
      }


    //修改某一 end_station_name
    public int updateOneBusMesEndStation (String end_station,String new_end_station,String bus_number){
        return  busMesDao.updateOneBusMesEndStation(end_station, new_end_station, bus_number);
    }

    //修改start_time
    public int updateOneBusMesStartTime (String bus_number,String direction,String start_time){
        return busMesDao.updateOneBusMesStartTime(bus_number, direction, start_time);
    }

    //修改end_time
    public int updateOneBusMesEndTime (String bus_number,String direction,String end_time){
        return busMesDao.updateOneBusMesEndTime(bus_number, direction, end_time);
    }

    //修改price
    public int updateOneBusMesPrice (String bus_number,String direction,Integer price){
        return busMesDao.updateOneBusMesPrice(bus_number, direction, price);
    }

    //修改length
    public int updateOneBusMesLength (String bus_number,String direction,String length){
        return busMesDao.updateOneBusMesLength(bus_number, direction, length);
    }

    //修改bus_time
    public int updateOneBusMesBusTime(String bus_number,String direction,String bus_time){
        return  busMesDao.updateOneBusMesBusTime(bus_number, direction, bus_time);
    }
    public List<BusMes> searchBusMesByNumber(String bus_number){
        return busMesDao.searchBusMesByNumber(bus_number);
    }

    public     List<BusMes> searchBusMesAll(){
        return busMesDao.searchBusMesAll();
    }

}
