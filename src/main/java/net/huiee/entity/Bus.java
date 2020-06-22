package net.huiee.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

@Entity
@Table( name = "bus")
@IdClass(BusKey.class)
public class Bus {
    @Id
    public String bus_number;
    public Integer go_number;
    public Integer back_number;
    @Id
    public String  station_name;
    public Boolean is_brt;
    public String  subway;

    public Bus() {
    }

    public Bus(String bus_number, Integer go_number, String station_name, Boolean is_brt, String subway) {
        this.bus_number = bus_number;
        this.go_number = go_number;
        this.station_name = station_name;
        this.is_brt = is_brt;
        this.subway = subway;
    }

    public Bus(String bus_number, Integer go_number, Integer back_number, String station_name, Boolean is_brt, String subway) {
        this.bus_number = bus_number;
        this.go_number = go_number;
        this.back_number = back_number;
        this.station_name = station_name;
        this.is_brt = is_brt;
        this.subway = subway;
    }

    public String getBus_number() {
        return bus_number;
    }

    public void setBus_number(String bus_number) {
        this.bus_number = bus_number;
    }

    public Integer getGo_number() {
        return go_number;
    }

    public void setGo_number(Integer go_number) {
        this.go_number = go_number;
    }

    public Integer getBack_number() {
        return back_number;
    }

    public void setBack_number(Integer back_number) {
        this.back_number = back_number;
    }

    public String getStation_name() {
        return station_name;
    }

    public void setStation_name(String station_name) {
        this.station_name = station_name;
    }

    public Boolean getIs_brt() {
        return is_brt;
    }

    public void setIs_brt(Boolean is_brt) {
        this.is_brt = is_brt;
    }

    public String getSubway() {
        return subway;
    }

    public void setSubway(String subway) {
        this.subway = subway;
    }

    @Override
    public String toString() {
        return "Bus{" +
                "bus_number='" + bus_number + '\'' +
                ", go_number=" + go_number +
                ", back_number=" + back_number +
                ", station_name='" + station_name + '\'' +
                ", is_brt=" + is_brt +
                ", subway='" + subway + '\'' +
                '}';
    }
}
