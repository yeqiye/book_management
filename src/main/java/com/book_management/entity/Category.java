package com.book_management.entity;

import lombok.Data;

@Data
public class Category {
    private Integer categoryId;
    private String categoryName;
    private String description;
    private Integer bookCount;
}
