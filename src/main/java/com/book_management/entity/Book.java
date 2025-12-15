package com.book_management.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Book {
    private Integer bookId;
    private String title;
    private String author;
    private String isbn;
    private Integer categoryId;
    private String categoryName;
    private String publisher;
    private Integer publicationYear;
    private Double price;
    private Integer totalCopies;
    private Integer availableCopies;
    private Date createdAt;
}
