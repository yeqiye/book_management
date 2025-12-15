package com.book_management.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class MainController {
    @GetMapping("/main")
    public String mainPage(HttpSession session){
        if (session.getAttribute("user")==null){
            return "redirect:/login";
        }
        return "main";
    }
}
