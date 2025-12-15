package com.book_management.service;

import com.book_management.entity.BorrowRecord;
import java.util.List;
import java.util.Map;

public interface BorrowService {
    boolean borrowBook(Integer userId, Integer bookId);
    boolean returnBook(Integer recordId, Integer userId);
    List<BorrowRecord> getUserBorrowRecords(Integer userId, String status, int page, int pageSize);
    int countUserBorrowRecords(Integer userId, String status);
    int countOverdueBooks(Integer userId);
    boolean isBookBorrowedByUser(Integer userId, Integer bookId);
}