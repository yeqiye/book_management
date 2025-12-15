package com.book_management.entity;

import lombok.Data;

import java.util.Date;

@Data
public class BorrowRecord {
    private Integer recordId;
    private Integer userId;
    private Integer bookId;
    private String title;
    private String author;
    private Date borrowDate;
    private Date dueDate;
    private Date returnDate;
    private String status;
    private Double penalty;

    public boolean isOverdue(){
        if ("borrowed".equals(status) && dueDate!=null){
            return dueDate.before(new Date());
        }
        return false;
    }
}
