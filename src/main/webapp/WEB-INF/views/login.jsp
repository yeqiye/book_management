<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书借阅系统 - 登录</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 350px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
        }
        .captcha-group {
            display: flex;
            align-items: center;
        }
        .captcha-input {
            flex: 1;
        }
        .captcha-code{
            margin: 0 10px;
            background: #f0f0f0;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            letter-spacing: 3px;
            font-size: 20px;
            color: #333;
        }
        .refresh-captcha{
            padding: 10px 20px;
            border-radius: 5px;
            background: #007bff;
            border: 0;
            color: white;
        }
        .btn-login {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-login:hover {
            background: #0056b3;
        }
        .error {
            color: red;
            margin-bottom: 15px;
            padding: 10px;
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 3px;
            text-align: center;
        }
        .test-accounts {
            margin-top: 15px;
            text-align: center;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>图书借阅系统</h2>
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">用户名:</label>
            <input type="text" id="username" name="username" required placeholder="请输入用户名">
        </div>
        <div class="form-group">
            <label for="password">密码:</label>
            <input type="password" id="password" name="password" required placeholder="请输入密码">
        </div>
        <div class="form-group">
            <label for="captcha">验证码:</label>
            <div class="captcha-group">
                <input type="text" id="captcha" name="captcha" class="captcha-input" required placeholder="请输入验证码">
                <div class="captcha-code">${captcha}</div>
                <button type="button" class="refresh-captcha" onclick="refreshCaptcha()">刷新验证码</button>
            </div>
        </div>
        <button type="submit" class="btn-login">登录</button>
    </form>
    <div class="test-accounts">
        <p>测试账号: admin / admin123 (管理员)</p>
        <p>测试账号: user1 / user123 (普通用户)</p>
    </div>
</div>
<script>
    function refreshCaptcha() {
        window.location.href = '${pageContext.request.contextPath}/refreshCaptcha';
    }
</script>
</body>
</html>