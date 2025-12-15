package com.book_management.service;

import com.book_management.entity.User;

import java.util.List;

public interface UserService {
    User login(String username, String password);
    User getUserById(Integer userId);
    List<User> getAllUsers();
    boolean addUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(Integer userId);
    boolean isUsernameExists(String username);
}
