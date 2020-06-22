package net.huiee.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "note")
public class Note {
    public String user_id;
    public String note_title;
    public String note;
    @Id
    public String note_time;
    public String clock;
    public Boolean clock_state;
    public Boolean collect;
    public Note() {
    }

    public Note(String user_id, String note_title, String note, String note_time, String clock, Boolean clock_state, Boolean collect) {
        this.user_id = user_id;
        this.note_title = note_title;
        this.note = note;
        this.note_time = note_time;
        this.clock = clock;
        this.clock_state = clock_state;
        this.collect = collect;
    }

    public Boolean getCollect() {
        return collect;
    }

    public void setCollect(Boolean collect) {
        this.collect = collect;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getNote_title() {
        return note_title;
    }

    public void setNote_title(String note_title) {
        this.note_title = note_title;
    }

    public String getNote_time() {
        return note_time;
    }

    public void setNote_time(String note_time) {
        this.note_time = note_time;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }



    public String getClock() {
        return clock;
    }

    public void setClock(String clock) {
        this.clock = clock;
    }

    public Boolean getClock_state() {
        return clock_state;
    }

    public void setClock_state(Boolean clock_state) {
        this.clock_state = clock_state;
    }

    @Override
    public String toString() {
        return "Note{" +
                "user_id='" + user_id + '\'' +
                ", note_title='" + note_title + '\'' +
                ", note='" + note + '\'' +
                ", note_time='" + note_time + '\'' +
                ", clock='" + clock + '\'' +
                ", clock_state=" + clock_state +
                ", collect=" + collect +
                '}';
    }
}
