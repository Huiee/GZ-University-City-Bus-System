package net.huiee.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "history")
public class History {
    String user_id;
    String start;
    String destination;
    String station_name;
    String bus_number;
    @Id
    String history_time;
    String history_type;

    public History() {
    }

    public History(String user_id, String start, String destination, String station_name, String bus_number, String history_time, String history_type) {
        this.user_id = user_id;
        this.start = start;
        this.destination = destination;
        this.station_name = station_name;
        this.bus_number = bus_number;
        this.history_time = history_time;
        this.history_type = history_type;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getStation_name() {
        return station_name;
    }

    public void setStation_name(String station_name) {
        this.station_name = station_name;
    }

    public String getBus_number() {
        return bus_number;
    }

    public void setBus_number(String bus_number) {
        this.bus_number = bus_number;
    }

    public String getHistory_time() {
        return history_time;
    }

    public void setHistory_time(String history_time) {
        this.history_time = history_time;
    }

    public String getHistory_type() {
        return history_type;
    }

    public void setHistory_type(String history_type) {
        this.history_type = history_type;
    }

    @Override
    public String toString() {
        return "History{" +
                "user_id='" + user_id + '\'' +
                ", start='" + start + '\'' +
                ", destination='" + destination + '\'' +
                ", station_name='" + station_name + '\'' +
                ", bus_number='" + bus_number + '\'' +
                ", history_time='" + history_time + '\'' +
                ", history_type='" + history_type + '\'' +
                '}';
    }
}
