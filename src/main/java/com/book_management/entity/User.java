package com.book_management.entity;

import lombok.Data;

import java.util.Date;

@Data
public class User {
    private Integer userId;
    private String username;
    private String password;
    private String realName;
    private String role;
    private Date createdAt;

    public boolean isAdmin(){
        return "admin".equals(role);
    }
}
