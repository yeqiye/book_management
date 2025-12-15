package com.book_management.dao;

import com.book_management.entity.User;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface UserMapper {

    @Select("SELECT * FROM users WHERE username = #{username} AND password = #{password}")
    User findByUsernameAndPassword(
            @Param("username") String username,
            @Param("password") String password);

    @Select("SELECT * FROM users WHERE user_id = #{userId}")
    User findByUserId(@Param("userId") Integer userId);

    @Select("SELECT * FROM users ORDER BY user_id")
    List<User> findAll();

    @Select("SELECT COUNT(*) FROM users WHERE username = #{username}")
    int countByUsername(@Param("username") String username);

    @Insert("INSERT INTO users (username, password, real_name, role) " +
            "VALUES (#{username}, #{password}, #{realName}, #{role})")
    @Options(useGeneratedKeys = true, keyProperty = "userId")
    int insert(User user);

    @Update("UPDATE users SET username = #{username}, password = #{password}, " +
            "real_name = #{realName}, role = #{role} WHERE user_id = #{userId}")
    int update(User user);

    @Delete("DELETE FROM users WHERE user_id = #{userId}")
    int delete(@Param("userId") Integer userId);
}