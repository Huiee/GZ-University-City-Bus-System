package net.huiee.service;

import net.huiee.dao.NoteDao;
import net.huiee.entity.Note;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class NoteService {
    @Resource
    NoteDao noteDao;

    //查看
   public List<Note> searchNote(String user_id){
       return noteDao.searchNote(user_id);
   }

   public     List<Note> searchNoteByCollect(String user_id,Boolean collect){
       return noteDao.searchNoteByCollect(user_id, collect);
   }

   public     List<Note> searchNoteByClock(String user_id,String clock){
       return noteDao.searchNoteByClock(user_id, clock);
   }
    //增加
    public int addNote(String user_id, String note_title,String note,String note_time){
       return noteDao.addNote(user_id, note_title, note, note_time);
    }

    //修改
    public  int updateNoteTitle(String user_id, String note_time,String new_note_time,String note_title){
       return noteDao.updateNoteTitle(user_id, note_time, new_note_time, note_title);
    }

    public  int updateNoteCollect(String user_id, String note_time,Boolean collect){
       return noteDao.updateNoteCollect(user_id, note_time, collect);
    }

    //修改
    public int updateNote(String user_id, String note_time,String new_note_time,String note){
       return noteDao.updateNote(user_id, note_time, new_note_time, note);
    }

    //修改闹钟
    public  int updateClock(String user_id, String note_time,String clock,Boolean clock_state){
       return noteDao.updateClock(user_id, note_time, clock, clock_state);
    }


    //删除

    public  void deleteNote(String user_id,String note_time){
       noteDao.deleteNote(user_id, note_time);
    }
}
