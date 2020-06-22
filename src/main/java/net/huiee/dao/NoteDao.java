package net.huiee.dao;

import net.huiee.entity.Note;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface NoteDao extends JpaRepository<Note,String> {

    //查看
    @Query(value = " select * from note where user_id = ?1 order by note_time desc ",nativeQuery = true)
    List<Note> searchNote(String user_id);

    //查看收藏
    @Query(value = " select * from note where user_id = ?1 and collect =?2 order by note_time desc ",nativeQuery = true)
    List<Note> searchNoteByCollect(String user_id,Boolean collect);

    //查看提醒
    @Query(value = " select * from note where user_id = ?1 and clock =?2 order by note_time desc ",nativeQuery = true)
    List<Note> searchNoteByClock(String user_id,String clock);
    //增加
    @Transactional
    @Modifying
    @Query(value = "insert into note(user_id,note_title,note,note_time) values(?1,?2,?3,?4)",nativeQuery = true)
    int addNote(String user_id, String note_title,String note,String note_time);

    //修改
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update note set collect = ?3 where user_id=?1 and note_time =?2 ",nativeQuery = true)
    int updateNoteCollect(String user_id, String note_time,Boolean collect);

    //修改
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update note set note_time = ?3 , note_title=?4 where user_id=?1 and note_time =?2 ",nativeQuery = true)
    int updateNoteTitle(String user_id, String note_time,String new_note_time,String note_title);

    //修改
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update note set note_time = ?3 , note=?4 where user_id=?1 and note_time =?2 ",nativeQuery = true)
    int updateNote(String user_id, String note_time,String new_note_time,String note);

    //修改闹钟
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "update note set clock = ?3 , clock_state=?4 where user_id=?1 and note_time =?2 ",nativeQuery = true)
    int updateClock(String user_id, String note_time,String clock,Boolean clock_state);


    //删除
    @Transactional
    @Modifying
    @Query(value = "delete from note where user_id=?1 and note_time=?2 ",nativeQuery = true)
    void deleteNote(String user_id,String note_time);





}
