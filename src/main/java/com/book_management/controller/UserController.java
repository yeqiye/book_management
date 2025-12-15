package com.book_management.controller;

import com.book_management.entity.User;
import com.book_management.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping("/add")
    public String addUser(User user, HttpSession session, RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        if (!currentUser.isAdmin()) {
            redirectAttributes.addFlashAttribute("message", "权限不足，请先登录管理员账号");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/main";
        }

        boolean success = userService.addUser(user);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "用户添加成功！");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "用户名已存在！");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        return "redirect:/users/manage";
    }

    @PostMapping("/delete")
    public String deleteUser(@RequestParam Integer userId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        if (!currentUser.isAdmin()) {
            redirectAttributes.addFlashAttribute("message", "权限不足，请先登录管理员账号");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/main";
        }

        if (userId.equals(currentUser.getUserId())) {
            redirectAttributes.addFlashAttribute("message", "不能删除当前登录用户！");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/users/manage";
        }

        boolean success = userService.deleteUser(userId);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "用户删除成功！");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "删除用户失败！");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        return "redirect:/users/manage";
    }

    @GetMapping("/manage")
    public String managePage(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        if (!currentUser.isAdmin()) {
            model.addAttribute("message", "权限不足，只有管理员可以访问用户管理页面");
            model.addAttribute("messageType", "error");
            return "error";
        }

        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        model.addAttribute("currentUserId", currentUser.getUserId());

        return "userManagement";
    }
}