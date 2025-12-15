package com.book_management.controller;

import com.book_management.entity.User;
import com.book_management.service.UserService;
import com.book_management.util.CaptchaUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@Controller
@RequestMapping("/")
public class LoginController {
    @Autowired
    private UserService userService;

    private String generateCaptcha(HttpSession session){
        String chars="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        StringBuilder sb=new StringBuilder();
        Random random=new Random();
        for(int i=0;i<4;i++){
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }

        String captcha=sb.toString();
        session.setAttribute("captcha",captcha);
        return captcha;
    }

    @GetMapping("/captcha")
    public void captchaImage(HttpServletRequest request,
                             HttpServletResponse response,
                             HttpSession session) throws IOException {
        String captcha = generateCaptcha(session);
        BufferedImage image= CaptchaUtil.generateCaptchaImage(captcha,120,40);

        response.setContentType("image/png");
        response.setHeader("Cache-Control", "no-cache");

        ImageIO.write(image,"png",response.getOutputStream());
    }
    @GetMapping("/refreshCaptcha")
    public String refreshCaptcha(HttpSession session){
        generateCaptcha(session);
        return "redirect:/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        @RequestParam String captcha,
                        HttpSession session,
                        RedirectAttributes redirectAttributes){
        String sessionCaptcha=(String)session.getAttribute("captcha");
        if (sessionCaptcha==null || !sessionCaptcha.equalsIgnoreCase(captcha)){
            redirectAttributes.addAttribute("error","2");
            return "redirect:/login";
        }

        User user=userService.login(username, password);
        if (user==null){
            redirectAttributes.addAttribute("error","1");
            return "redirect:/login";
        }

        session.setAttribute("user",user);
        session.setAttribute("user_id",user.getUserId());
        session.setAttribute("username",user.getUsername());
        session.setAttribute("real_name",user.getRealName());
        session.setAttribute("role",user.getRole());

        session.removeAttribute("captcha");

        return "redirect:/main";
    }
    @GetMapping({"","/login"})
    public String loginPage(HttpSession session, Model model,
                            @RequestParam(value = "error",required = false)String error){
        if (error!=null){
            if ("1".equals(error)){
                model.addAttribute("error","用户名或密码错误！");
            }else if ("2".equals(error)){
                model.addAttribute("error","验证码错误！");
            }
        }
        model.addAttribute("testAccounts",
                "测试账号:admin/admin123(管理员)<br>测试账号:user1/user123(普通用户)");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/login";
    }
}
