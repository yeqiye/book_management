package com.book_management.service.impl;

import com.book_management.dao.BookMapper;
import com.book_management.dao.BorrowRecordMapper;
import com.book_management.entity.Book;
import com.book_management.entity.BorrowRecord;
import com.book_management.service.BorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class BorrowServiceImpl implements BorrowService {

    @Autowired
    private BorrowRecordMapper borrowRecordMapper;

    @Autowired
    private BookMapper bookMapper;

    @Override
    public boolean borrowBook(Integer userId, Integer bookId) {
        // 检查图书是否存在且可借
        Book book = bookMapper.findById(bookId);
        if (book == null || book.getAvailableCopies() <= 0) {
            return false;
        }
        // 检查用户是否已借阅该书且未归还
        if (borrowRecordMapper.isBookBorrowedByUser(userId, bookId) > 0) {
            return false;
        }

        BorrowRecord record = new BorrowRecord();
        record.setUserId(userId);
        record.setBookId(bookId);
        record.setBorrowDate(new Date());

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.DAY_OF_YEAR, 30);
        record.setDueDate(calendar.getTime());
        record.setStatus("borrowed");

        int result = borrowRecordMapper.insert(record);
        if (result > 0) {
            return bookMapper.decreaseAvailableCopies(bookId) > 0;
        }
        return false;
    }

    @Override
    public boolean returnBook(Integer recordId, Integer userId) {
        BorrowRecord record = borrowRecordMapper.findBorrowedRecord(recordId, userId);
        if (record == null) {
            return false;
        }

        double penalty = 0.0;
        Date currentDate = new Date();
        if (currentDate.after(record.getDueDate())) {
            long diff = currentDate.getTime() - record.getDueDate().getTime();
            long daysOverdue = diff / (1000 * 60 * 60 * 24);
            penalty = daysOverdue * 1.0;
        }

        record.setReturnDate(currentDate);
        record.setPenalty(penalty);
        record.setStatus("returned");
        int updateResult = borrowRecordMapper.updateReturnInfo(record);
        if (updateResult > 0) {
            return bookMapper.increaseAvailableCopies(record.getBookId()) > 0;
        }
        return false;
    }

    @Override
    public List<BorrowRecord> getUserBorrowRecords(Integer userId, String status, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("status", status);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return borrowRecordMapper.findByUserIdAndStatus(params);
    }

    @Override
    public int countUserBorrowRecords(Integer userId, String status) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("status", status);
        return borrowRecordMapper.countByUserIdAndStatus(params);
    }

    @Override
    public int countOverdueBooks(Integer userId) {
        return borrowRecordMapper.countOverdueBooks(userId);
    }

    @Override
    public boolean isBookBorrowedByUser(Integer userId, Integer bookId) {
        return borrowRecordMapper.isBookBorrowedByUser(userId, bookId) > 0;
    }
}