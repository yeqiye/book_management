package com.book_management.dao;

import com.book_management.entity.Category;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface CategoryMapper {

    @Select("SELECT c.*, COUNT(b.book_id) as book_count FROM categories c " +
            "LEFT JOIN books b ON c.category_id = b.category_id " +
            "GROUP BY c.category_id, c.category_name, c.description " +
            "ORDER BY c.category_id")
    List<Category> findAllWithBookCount();

    @Select("SELECT * FROM categories ORDER BY category_name")
    List<Category> findAll();

    @Select("SELECT * FROM categories WHERE category_id = #{categoryId}")
    Category findById(@Param("categoryId") Integer categoryId);

    @Select("SELECT COUNT(*) FROM books WHERE category_id = #{categoryId}")
    int countBooksByCategory(@Param("categoryId") Integer categoryId);

    @Insert("INSERT INTO categories (category_name, description) " +
            "VALUES (#{categoryName}, #{description})")
    @Options(useGeneratedKeys = true, keyProperty = "categoryId")
    int insert(Category category);

    @Update("UPDATE categories SET category_name = #{categoryName}, " +
            "description = #{description} WHERE category_id = #{categoryId}")
    int update(Category category);

    @Delete("DELETE FROM categories WHERE category_id = #{categoryId}")
    int delete(@Param("categoryId") Integer categoryId);

}