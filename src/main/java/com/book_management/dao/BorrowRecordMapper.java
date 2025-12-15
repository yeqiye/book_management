package com.book_management.dao;

import com.book_management.entity.BorrowRecord;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface BorrowRecordMapper {

    List<BorrowRecord> findByUserIdAndStatus(Map<String, Object> params);
    int countByUserIdAndStatus(Map<String, Object> params);

    @Select("SELECT COUNT(*) FROM borrow_records WHERE book_id = #{bookId} " +
            "AND status = 'borrowed'")
    int countBorrowedByBookId(@Param("bookId") Integer bookId);

    @Select("SELECT COUNT(*) FROM borrow_records WHERE user_id = #{userId} " +
            "AND book_id = #{bookId} AND status = 'borrowed'")
    int isBookBorrowedByUser(@Param("userId") Integer userId,
                             @Param("bookId") Integer bookId);

    @Select("SELECT br.*, b.title, b.book_id FROM borrow_records br " +
            "JOIN books b ON br.book_id = b.book_id " +
            "WHERE br.record_id = #{recordId} AND br.user_id = #{userId} " +
            "AND br.status = 'borrowed'")
    BorrowRecord findBorrowedRecord(@Param("recordId") Integer recordId,
                                    @Param("userId") Integer userId);

    @Select("SELECT COUNT(*) FROM borrow_records WHERE user_id = #{userId} " +
            "AND status = 'borrowed' AND due_date < CURDATE()")
    int countOverdueBooks(@Param("userId") Integer userId);

    @Insert("INSERT INTO borrow_records (user_id, book_id, borrow_date, " +
            "due_date, status) VALUES (#{userId}, #{bookId}, #{borrowDate}, " +
            "#{dueDate}, 'borrowed')")
    @Options(useGeneratedKeys = true, keyProperty = "recordId")
    int insert(BorrowRecord record);

    @Update("UPDATE borrow_records SET return_date = #{returnDate}, " +
            "status = 'returned', penalty = #{penalty} WHERE record_id = #{recordId}")
    int updateReturnInfo(BorrowRecord record);

}