package com.book_management.service;

import com.book_management.entity.Book;
import java.util.List;
import java.util.Map;

public interface BookService {
    List<Book> searchBooks(String keyword, Integer categoryId, int page, int pageSize);
    int countBooks(String keyword, Integer categoryId);
    Book getBookById(Integer bookId);
    List<Book> getAllBooks();
    boolean addBook(Book book);
    boolean updateBook(Book book);
    boolean deleteBook(Integer bookId);
    boolean isBookAvailable(Integer bookId);
    boolean decreaseAvailableCopies(Integer bookId);
    boolean increaseAvailableCopies(Integer bookId);
}
