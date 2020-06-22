package net.huiee.entity;

import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class BusMesKey implements Serializable {
    /**
     * @Fields serialVersionUID	:3176972128965536016L
     */
    private static final long serialVersionUID = 3176972128965536016L;

    protected String bus_number;
    protected String  start_station;

    public BusMesKey() {
    }

    public BusMesKey(String bus_number, String start_station) {
        this.bus_number = bus_number;
        this.start_station = start_station;
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

    @Override
    public int hashCode() {
        final int PRIME = 31;
        int result = 1;
        result = PRIME * result + (bus_number== null ? 0 : bus_number.hashCode());
        result = PRIME * result + (start_station == null ? 0 : start_station.hashCode());

        return result;
    }

    @Override
    public boolean equals(Object o) {
        if(this == o) return true;
        if(o== null) return false;
        if(!(o instanceof Bus)) return false;
        BusMesKey objKey = (BusMesKey)o;
        if(
                bus_number.equalsIgnoreCase(objKey.bus_number)&&
                        start_station.equalsIgnoreCase(objKey.start_station)
        ) {
            return true;
        }
        return false;
    }
}
