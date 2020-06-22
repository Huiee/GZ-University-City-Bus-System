package net.huiee.service;

import net.huiee.dao.BusDao;
import net.huiee.entity.Bus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BusService {
    @Resource
    BusDao busDao;

    //一次换乘
    public     List<Bus> searchBusChange(String start,String end){
        return busDao.searchBusChange(start,end);
    }

    //获取点
    public     List<String> allStation(String start,String end){
        return busDao.allStation(start, end);
    }
    //模糊查询获取站名
    public  List<String> searchStationNameByLikeStationName(String station_name){
        return busDao.searchStationNameByLikeStationName(station_name);
    }

    public List<String> getRoadChange(){
        return busDao.getRoadChange();
    }

    //获取所有线路

    public  List<String> getAllRoad(){
        return busDao.getAllRoad();
    }

    public List<Bus> searchBusByNumber(String bus_number){
        return busDao.searchBusByNumber(bus_number);
    }

    public List<Bus> searchBusByStationName(String station_name){
        return busDao.searchBusByStationName(station_name);
    }

    public  List<Bus> searchBusByBackNumber(String bus_number){
        return  busDao.searchBusByBackNumber(bus_number);
    }

    public  List<Bus> searchBus(String start,String end){
        return busDao.searchBus(start, end);
    }

    public  List<Bus> searchBusBack(String start,String end){
        return  busDao.searchBusBack(start, end);
    }

    //删除公交某一站
    public void deleteBusStation(String bus_number,String station_name){
        busDao.deleteBusStation(bus_number, station_name);
    }


    //根据公交号码查询公交线路——允许空
    public List<Bus> searchBusByNumberNull(String bus_number){
        return busDao.searchBusByNumberNull(bus_number);
    }

    //根据公交号码查询公交线路——允许空
    public List<Bus> searchBusByBackNumberNull(String bus_number){
        return busDao.searchBusByBackNumberNull(bus_number);
    }

    //根据原来的go_number为判断  因插入修改go_number顺序
    public int updateBusGoNumberByGoNumber (String bus_number,Integer go_number,Integer new_go_number){
        return busDao.updateBusGoNumberByGoNumber(bus_number, go_number, new_go_number);
    }

    //根据原来的back_number为判断  因插入修改back_number顺序
     public int updateBusBackNumberByBackNumber (String bus_number,Integer back_number,Integer new_back_number){
        return busDao.updateBusBackNumberByBackNumber(bus_number, back_number, new_back_number);
     }

    //增加线路
    public  int addBus(String bus_number,String station_name){
      return   busDao.addBus(bus_number, station_name);
    }

    public int updateBusGoNumber (String bus_number,String station_name,Integer go_number){
        return busDao.updateBusGoNumber(bus_number, station_name, go_number);
    }

    //修改线路 back_number
    public int updateBusBackNumber (String bus_number,String station_name,Integer back_number){
        return busDao.updateBusBackNumber(bus_number, station_name, back_number);
    }

    //修改线路 is_brt
    public int updateBusIsBrt (String bus_number,String station_name,Boolean is_brt){
        return busDao.updateBusIsBrt(bus_number, station_name, is_brt);
    }

    //修改subway
    public  int updateBusSubway (String bus_number,String station_name,String subway){
        return busDao.updateBusSubway(bus_number, station_name, subway);
    }

    public int updateBusNumber (String bus_number,String new_bus_number){
        return busDao.updateBusNumber(bus_number, new_bus_number);
    }

    //修改某一线路 station_name
    public int updateBusStationName (String bus_number,String station_name,String new_station_name){
        return busDao.updateBusStationName(bus_number, station_name, new_station_name);
    }

    //修改所有线路 station_name
    public int updateBusStationNameAll (String station_name,String new_station_name){
        return busDao.updateBusStationNameAll(station_name, new_station_name);
    }

    //删除线路
    public int updateBusGo (String bus_number){
        return busDao.updateBusGo(bus_number);
    }

    public int updateBusBack (String bus_number){
        return busDao.updateBusBack(bus_number);
    }

    public void deleteBus(String bus_number){
       busDao.deleteBus(bus_number);
    }
}
