package net.huiee.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "search_bus_faster")
public class SearchBus {
    @Id
    public Integer number;
    public String station_A;
    public String station_B;
    public String bus_number_A;
    public String change_station_C;
    public String bus_number_B;
    public Integer num_A;
    public Integer num_A_C;
    public Integer num_C_B;
    public Integer num_B;
    public Integer num;
    public Integer price;
    public String  bus_time;
    //二次
    public String change_station_C2;//站点 A-C C-C2 C2-B
    public String bus_number_D;//公交：A-D-B
    public Integer num_C1;
    public Integer num_C2;

    public SearchBus() {
    }


    public String getBus_time() {
        return bus_time;
    }

    public void setBus_time(String bus_time) {
        this.bus_time = bus_time;
    }

    public String getChange_station_C2() {
        return change_station_C2;
    }

    public void setChange_station_C2(String change_station_C2) {
        this.change_station_C2 = change_station_C2;
    }

    public String getBus_number_D() {
        return bus_number_D;
    }

    public void setBus_number_D(String bus_number_D) {
        this.bus_number_D = bus_number_D;
    }

    public Integer getNum_C1() {
        return num_C1;
    }

    public void setNum_C1(Integer num_C1) {
        this.num_C1 = num_C1;
    }

    public Integer getNum_C2() {
        return num_C2;
    }

    public void setNum_C2(Integer num_C2) {
        this.num_C2 = num_C2;
    }

    public Integer getNum_A() {
        return num_A;
    }

    public void setNum_A(Integer num_A) {
        this.num_A = num_A;
    }

    public Integer getNum_A_C() {
        return num_A_C;
    }

    public void setNum_A_C(Integer num_A_C) {
        this.num_A_C = num_A_C;
    }

    public Integer getNum_C_B() {
        return num_C_B;
    }

    public void setNum_C_B(Integer num_C_B) {
        this.num_C_B = num_C_B;
    }

    public Integer getNum_B() {
        return num_B;
    }

    public void setNum_B(Integer num_B) {
        this.num_B = num_B;
    }

    public String getBus_number_A() {
        return bus_number_A;
    }

    public void setBus_number_A(String bus_number_A) {
        this.bus_number_A = bus_number_A;
    }

    public String getChange_station_C() {
        return change_station_C;
    }

    public void setChange_station_C(String change_station_C) {
        this.change_station_C = change_station_C;
    }

    public String getBus_number_B() {
        return bus_number_B;
    }

    public void setBus_number_B(String bus_number_B) {
        this.bus_number_B = bus_number_B;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public String getStation_A() {
        return station_A;
    }

    public void setStation_A(String station_A) {
        this.station_A = station_A;
    }

    public String getStation_B() {
        return station_B;
    }

    public void setStation_B(String station_B) {
        this.station_B = station_B;
    }


    public SearchBus(String bus_number_A, String change_station_C, String bus_number_B, Integer num_A, Integer num_A_C, Integer num_C_B, Integer num_B, Integer num,Integer price,String bus_time) {

        this.bus_number_A = bus_number_A;
        this.change_station_C = change_station_C;
        this.bus_number_B = bus_number_B;
        this.num_A = num_A;
        this.num_A_C = num_A_C;
        this.num_C_B = num_C_B;
        this.num_B = num_B;
        this.num = num;
        this.price = price;
        this.bus_time = bus_time;
    }
//二次
    public SearchBus(String station_A, String station_B, String change_station_C, String change_station_C2,String bus_number_A,  String bus_number_D, String bus_number_B, Integer num_A, Integer num_A_C, Integer num_C1, Integer num_C2,Integer num_C_B, Integer num_B, Integer num,Integer price,String bus_time) {
        this.station_A = station_A;
        this.station_B = station_B;
        this.bus_number_A = bus_number_A;
        this.change_station_C = change_station_C;
        this.bus_number_B = bus_number_B;
        this.num_A = num_A;
        this.num_A_C = num_A_C;
        this.num_C_B = num_C_B;
        this.num_B = num_B;
        this.num = num;
        this.change_station_C2 = change_station_C2;
        this.bus_number_D = bus_number_D;
        this.num_C1 = num_C1;
        this.num_C2 = num_C2;
        this.price = price;
        this.bus_time = bus_time;
    }

    //
//    public SearchBus(Integer number, String station_A, String station_B, String bus_number_A, String change_station_C, String bus_number_B, Integer num_A, Integer num_A_C, Integer num_C_B, Integer num_B, Integer num, Integer price) {
//        this.number = number;
//        this.station_A = station_A;
//        this.station_B = station_B;
//        this.bus_number_A = bus_number_A;
//        this.change_station_C = change_station_C;
//        this.bus_number_B = bus_number_B;
//        this.num_A = num_A;
//        this.num_A_C = num_A_C;
//        this.num_C_B = num_C_B;
//        this.num_B = num_B;
//        this.num = num;
//        this.price = price;
//    }


    @Override
    public String toString() {
        return "SearchBus{" +
                "number=" + number +
                ", station_A='" + station_A + '\'' +
                ", station_B='" + station_B + '\'' +
                ", bus_number_A='" + bus_number_A + '\'' +
                ", change_station_C='" + change_station_C + '\'' +
                ", bus_number_B='" + bus_number_B + '\'' +
                ", num_A=" + num_A +
                ", num_A_C=" + num_A_C +
                ", num_C_B=" + num_C_B +
                ", num_B=" + num_B +
                ", num=" + num +
                ", price=" + price +
                ", bus_time='" + bus_time + '\'' +
                ", change_station_C2='" + change_station_C2 + '\'' +
                ", bus_number_D='" + bus_number_D + '\'' +
                ", num_C1=" + num_C1 +
                ", num_C2=" + num_C2 +
                '}';
    }
}
