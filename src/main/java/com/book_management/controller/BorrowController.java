package com.book_management.controller;

import com.book_management.entity.BorrowRecord;
import com.book_management.entity.User;
import com.book_management.service.BorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/borrow")
public class BorrowController {

    @Autowired
    private BorrowService borrowService;

    @PostMapping("/borrowBook")
    public String borrowBook(@RequestParam Integer bookId,
                             HttpSession session,
                             Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("message", "请先登录系统");
            model.addAttribute("messageType", "error");
            return "returnResult";
        }

        boolean success = borrowService.borrowBook(user.getUserId(), bookId);
        if (success) {
            model.addAttribute("message", "借阅成功！");
            model.addAttribute("messageType", "success");
        } else {
            model.addAttribute("message", "借阅失败，可能图书已借完或您已借阅该书！");
            model.addAttribute("messageType", "error");
        }

        return "redirect:/books/search";
    }

    @PostMapping("/returnBook")
    public String returnBook(@RequestParam Integer recordId,
                             HttpSession session,
                             Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("message", "请先登录系统");
            model.addAttribute("messageType", "error");
            return "redirect:/login";
        }

        boolean success = borrowService.returnBook(recordId, user.getUserId());
        if (success) {
            model.addAttribute("message", "归还成功！");
            model.addAttribute("messageType", "success");
        } else {
            model.addAttribute("message", "归还失败！");
            model.addAttribute("messageType", "error");
        }

        return "redirect:/borrow";
    }

    @GetMapping
    public String borrowPage(@RequestParam(value = "status", defaultValue = "all") String status,
                             @RequestParam(value = "page", defaultValue = "1") int page,
                             HttpSession session,
                             Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        int pageSize = 10;
        List<BorrowRecord> records = borrowService.getUserBorrowRecords(
                user.getUserId(), status, page, pageSize);
        int totalRecords = borrowService.countUserBorrowRecords(user.getUserId(), status);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        int overdueCount = borrowService.countOverdueBooks(user.getUserId());

        model.addAttribute("records", records);
        model.addAttribute("status", status);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("overdueCount", overdueCount);

        return "borrow";
    }


}