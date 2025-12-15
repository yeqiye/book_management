package com.book_management.controller;

import com.book_management.entity.Category;
import com.book_management.entity.User;
import com.book_management.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/categories")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @PostMapping("/add")
    public String addCategory(Category category, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isAdmin()) {
            redirectAttributes.addFlashAttribute("message", "权限不足，请先登录管理员账号");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/main";
        }

        boolean success = categoryService.addCategory(category);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "分类添加成功！");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "添加分类失败！");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        return "redirect:/categories/manage";
    }

    @PostMapping("/delete")
    public String deleteCategory(@RequestParam Integer categoryId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isAdmin()) {
            redirectAttributes.addFlashAttribute("message", "权限不足，请先登录管理员账号");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/main";
        }

        if (categoryService.hasBooks(categoryId)) {
            redirectAttributes.addFlashAttribute("message", "该分类下还有图书，无法删除！");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/categories/manage";
        }

        boolean success = categoryService.deleteCategory(categoryId);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "分类删除成功！");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "删除分类失败！");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        return "redirect:/categories/manage";
    }

    @PostMapping("/update")
    public String updateCategory(Category category, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isAdmin()) {
            redirectAttributes.addFlashAttribute("message", "权限不足，请先登录管理员账号");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/main";
        }

        boolean success = categoryService.updateCategory(category);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "分类信息更新成功！");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "更新分类失败！");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        return "redirect:/categories/manage";
    }

    @GetMapping("/manage")
    public String managePage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isAdmin()) {
            model.addAttribute("message", "权限不足，只有管理员可以访问用户管理页面");
            model.addAttribute("messageType", "error");
            return "redirect:/main";
        }

        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);

        return "categoryManagement";
    }


}
