package com.book_management.dao;

import com.book_management.entity.Book;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface BookMapper {

    List<Book> findByCondition(Map<String, Object> params);

    int countByCondition(Map<String, Object> params);

    @Select("SELECT b.*, c.category_name FROM books b " +
            "LEFT JOIN categories c ON b.category_id = c.category_id " +
            "WHERE b.book_id = #{bookId}")
    Book findById(@Param("bookId") Integer bookId);

    @Select("SELECT * FROM books ORDER BY book_id DESC")
    List<Book> findAll();

    @Insert("INSERT INTO books (title, author, isbn, category_id, publisher, " +
            "publication_year, price, total_copies, available_copies) " +
            "VALUES (#{title}, #{author}, #{isbn}, #{categoryId}, #{publisher}, " +
            "#{publicationYear}, #{price}, #{totalCopies}, #{totalCopies})")
    @Options(useGeneratedKeys = true, keyProperty = "bookId")
    int insert(Book book);

    @Update("UPDATE books SET title = #{title}, author = #{author}, isbn = #{isbn}, " +
            "category_id = #{categoryId}, publisher = #{publisher}, " +
            "publication_year = #{publicationYear}, price = #{price}, " +
            "total_copies = #{totalCopies}, available_copies = #{availableCopies} " +
            "WHERE book_id = #{bookId}")
    int update(Book book);

    @Update("UPDATE books SET available_copies = available_copies - 1 " +
            "WHERE book_id = #{bookId} AND available_copies > 0")
    int decreaseAvailableCopies(@Param("bookId") Integer bookId);

    @Update("UPDATE books SET available_copies = available_copies + 1 " +
            "WHERE book_id = #{bookId}")
    int increaseAvailableCopies(@Param("bookId") Integer bookId);

    @Delete("DELETE FROM books WHERE book_id = #{bookId}")
    int delete(@Param("bookId") Integer bookId);

}