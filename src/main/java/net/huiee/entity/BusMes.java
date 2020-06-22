package net.huiee.entity;

import javax.persistence.*;

@Entity
@Table(name = "bus_mes")
@IdClass(BusMesKey.class)
public class BusMes {
    @Id
    public String bus_number;
    @Id
    @Column(name = "start_station")
    public String start_station;
    public String end_station;
    public String start_time;
    public String end_time;
    public Integer price;
    public String length;
    public String direction;
    public String bus_time;

    public BusMes() {
    }

    public String getBus_number() {
        return bus_number;
    }

    public void setBus_number(String bus_number) {
        this.bus_number = bus_number;
    }

    public String getStart_station() {
        return start_station;
    }

    public void setStart_station(String start_station) {
        this.start_station = start_station;
    }

    public String getEnd_station() {
        return end_station;
    }

    public void setEnd_station(String end_station) {
        this.end_station = end_station;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getLength() {
        return length;
    }

    public void setLength(String length) {
        this.length = length;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getBus_time() {
        return bus_time;
    }

    public void setBus_time(String bus_time) {
        this.bus_time = bus_time;
    }

    public BusMes(String bus_number, String start_station, String end_station, String start_time, String end_time, Integer price, String length, String direction, String bus_time) {
        this.bus_number = bus_number;
        this.start_station = start_station;
        this.end_station = end_station;
        this.start_time = start_time;
        this.end_time = end_time;
        this.price = price;
        this.length = length;
        this.direction = direction;
        this.bus_time = bus_time;
    }

    @Override
    public String toString() {
        return "BusMes{" +
                "bus_number='" + bus_number + '\'' +
                ", start_station='" + start_station + '\'' +
                ", end_station='" + end_station + '\'' +
                ", start_time='" + start_time + '\'' +
                ", end_time='" + end_time + '\'' +
                ", price=" + price +
                ", length='" + length + '\'' +
                ", direction='" + direction + '\'' +
                ", bus_time='" + bus_time + '\'' +
                '}';
    }
}
