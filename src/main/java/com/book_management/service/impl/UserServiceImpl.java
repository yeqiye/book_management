package com.book_management.service.impl;

import com.book_management.dao.UserMapper;
import com.book_management.entity.User;
import com.book_management.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(String username, String password) {
        return userMapper.findByUsernameAndPassword(username, password);
    }
    @Override
    public User getUserById(Integer userId) {
        return userMapper.findByUserId(userId);
    }
    @Override
    public List<User> getAllUsers() {
        return userMapper.findAll();
    }
    @Override
    public boolean addUser(User user) {
        if (userMapper.countByUsername(user.getUsername()) > 0) {return false;}
        return userMapper.insert(user)>0;
    }
    @Override
    public boolean updateUser(User user) {return userMapper.update(user)>0;}
    @Override
    public boolean deleteUser(Integer userId) {return userMapper.delete(userId)>0;}
    @Override
    public boolean isUsernameExists(String username){
        return userMapper.countByUsername(username)>0;
    }
}
