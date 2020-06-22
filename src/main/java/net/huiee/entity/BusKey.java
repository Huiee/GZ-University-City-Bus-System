package net.huiee.entity;

import javax.persistence.Embeddable;
import java.io.Serializable;
@Embeddable
public class BusKey implements Serializable {
    /**
     * @Fields serialVersionUID	:3176972128965536016L
     */
    private static final long serialVersionUID = 3176972128965536016L;

    protected String bus_number;
    protected String  station_name;

    public BusKey() {
    }

    public BusKey(String bus_number, String station_name) {
        this.bus_number = bus_number;
        this.station_name = station_name;
    }

    public String getBus_number() {
        return bus_number;
    }

    public void setBus_number(String bus_number) {
        this.bus_number = bus_number;
    }

    public String getStation_name() {
        return station_name;
    }

    public void setStation_name(String station_name) {
        this.station_name = station_name;
    }


    @Override
    public int hashCode() {
        final int PRIME = 31;
        int result = 1;
        result = PRIME * result + (bus_number== null ? 0 : bus_number.hashCode());
        result = PRIME * result + (station_name == null ? 0 : station_name.hashCode());

        return result;
    }

    @Override
    public boolean equals(Object o) {
        if(this == o) return true;
        if(o== null) return false;
        if(!(o instanceof Bus)) return false;
        BusKey objKey = (BusKey )o;
        if(
                bus_number.equalsIgnoreCase(objKey.bus_number)&&
                        station_name.equalsIgnoreCase(objKey.station_name)
        ) {
            return true;
        }
        return false;
    }
}
