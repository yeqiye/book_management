package com.book_management.controller;

import com.book_management.entity.Book;
import com.book_management.entity.Category;
import com.book_management.entity.User;
import com.book_management.service.BookService;
import com.book_management.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/books")
public class BookController {
    @Autowired
    private BookService bookService;
    @Autowired
    private CategoryService categoryService;

    @GetMapping("/search")
    public String searchPage(@RequestParam(value = "keyword",required = false)String keyword,
                             @RequestParam(value = "category",required = false)Integer categoryId,
                             @RequestParam(value = "page",defaultValue = "1")int page,
                             HttpSession session,
                             Model model){
        User user=(User) session.getAttribute("user");
        if (user==null){
            return "redirect:/login";
        }

        int pageSize=10;
        List<Book> books=bookService.searchBooks(keyword,categoryId,page,pageSize);
        int totalRecords=bookService.countBooks(keyword,categoryId);
        int totalPages=(int) Math.ceil((double) totalRecords/pageSize);

        List<Category> categories=categoryService.getAllCategories();

        model.addAttribute("books", books);
        model.addAttribute("keyword", keyword);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("categories", categories);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("isAdmin", user.isAdmin());

        return "search";
    }

    @GetMapping("/manage")
    public String managePage(HttpSession session,Model model){
        User user=(User) session.getAttribute("user");
        if (user==null){
            return "redirect:/login";
        }
        if (!user.isAdmin()){
            model.addAttribute("message", "权限不足，只有管理员可以访问用户管理页面");
            model.addAttribute("messageType", "error");
            return "redirect:/main";
        }

        List<Book> books=bookService.getAllBooks();
        List<Category> categories=categoryService.getAllCategories();
        model.addAttribute("books",books);
        model.addAttribute("categories",categories);
        return "bookManagement";
    }

    @PostMapping("/add")
    public String addBook(Book book, HttpSession session,
                          RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user==null){
            return "redirect:/login";
        }
        if (!user.isAdmin()){
            redirectAttributes.addFlashAttribute("message", "权限不足，请先登录管理员账号");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/main";
        }

        boolean success = bookService.addBook(book);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "图书添加成功！");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "添加图书失败！");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        return "redirect:/books/manage";
    }

    @PostMapping("/delete")
    public String deleteBook(@RequestParam Integer bookId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user==null){
            return "redirect:/login";
        }
        if (!user.isAdmin()){
            redirectAttributes.addFlashAttribute("message", "权限不足，请先登录管理员账号");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/main";
        }

        boolean success = bookService.deleteBook(bookId);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "图书删除成功！");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "该图书已被借出，无法删除！");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        return "redirect:/books/manage";
    }

    @PostMapping("/update")
    public String updateBook(Book book, HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user==null){
            return "redirect:/login";
        }
        if (!user.isAdmin()){
            redirectAttributes.addFlashAttribute("message", "权限不足，请先登录管理员账号");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/main";
        }

        boolean success = bookService.updateBook(book);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "图书信息更新成功！");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "更新图书失败！");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        return "redirect:/books/manage";
    }
}
