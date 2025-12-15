package com.book_management.service.impl;

import com.book_management.dao.BookMapper;
import com.book_management.dao.BorrowRecordMapper;
import com.book_management.entity.Book;
import com.book_management.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private BorrowRecordMapper borrowRecordMapper;

    @Override
    public List<Book> searchBooks(String keyword, Integer categoryId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("categoryId", categoryId);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return bookMapper.findByCondition(params);
    }

    @Override
    public int countBooks(String keyword, Integer categoryId) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("categoryId", categoryId);
        return bookMapper.countByCondition(params);
    }

    @Override
    public Book getBookById(Integer bookId) {
        return bookMapper.findById(bookId);
    }

    @Override
    public List<Book> getAllBooks() {
        return bookMapper.findAll();
    }

    @Override
    public boolean addBook(Book book) {
        return bookMapper.insert(book) > 0;
    }

    @Override
    public boolean updateBook(Book book) {
        return bookMapper.update(book) > 0;
    }

    @Override
    public boolean deleteBook(Integer bookId) {
        if (borrowRecordMapper.countBorrowedByBookId(bookId) > 0) {
            return false;
        }
        return bookMapper.delete(bookId) > 0;
    }

    @Override
    public boolean isBookAvailable(Integer bookId) {
        Book book = bookMapper.findById(bookId);
        return book != null && book.getAvailableCopies() > 0;
    }

    @Override
    public boolean decreaseAvailableCopies(Integer bookId) {
        return bookMapper.decreaseAvailableCopies(bookId) > 0;
    }

    @Override
    public boolean increaseAvailableCopies(Integer bookId) {
        return bookMapper.increaseAvailableCopies(bookId) > 0;
    }
}