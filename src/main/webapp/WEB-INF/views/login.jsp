<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书借阅系统 - 登录</title>
    <style>
        body {
            height: 100vh;
            margin: 0;

            background-image: url("${pageContext.request.contextPath}/static/images/login-bg.jpg");
            background-repeat: no-repeat;
            background-position: center center;
            background-size: cover;

            display: flex;
            justify-content: center;
            align-items: center;
        }
        body.hogwarts-bg {
            font-family: "Georgia", "Times New Roman", serif;
            background-image: url("${pageContext.request.contextPath}/static/images/login-bg.jpg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }
        .magic-overlay {
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.45);
            z-index: 1;
        }

        .parchment {
            position: relative;
            z-index: 2;
            width: 420px;
            padding: 50px 40px;
            background: #f5e8c7 url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" opacity="0.07"><text x="10" y="50" font-size="60" fill="%23c2a46d">✶</text></svg>') repeat;
            background-blend-mode: overlay;
            border-radius: 8px 12px 8px 12px;
            box-shadow:
                    0 0 40px rgba(0,0,0,0.7),
                    inset 0 0 40px rgba(140, 110, 60, 0.4),
                    inset 0 0 80px rgba(220, 190, 120, 0.25);
            border: 3px solid #b8975e;
            border-image: linear-gradient(to bottom, #d4b778, #8b6f3e, #d4b778) 1;
        }

        .parchment::after {
            content: "";
            position: absolute;
            bottom: 25px;
            right: 35px;
            width: 80px;
            height: 80px;
            background: url("${pageContext.request.contextPath}/static/images/wax-seal.png") center/contain no-repeat;
            opacity: 0.9;
            pointer-events: none;
            filter: drop-shadow(0 3px 6px rgba(0,0,0,0.5));
        }

        .login-container {
            background: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 450px;
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
            background: rgba(255,255,255,0.6);
            border: 1px solid #b59b6a;
            border-radius: 4px;
            padding: 8px;
            font-size: 14px;
        }

        input:focus {
            outline: none;
            border-color: #7a5c2e;
            box-shadow: 0 0 5px rgba(122, 92, 46, 0.5);
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
            /*background: #f0f0f0;*/
            /*padding: 10px 20px;*/
            border-radius: 5px;
            font-weight: bold;
            letter-spacing: 3px;
            font-size: 20px;
            color: #333;
            cursor: pointer;
        }

        .refresh-captcha{
            padding: 10px 20px;
            border-radius: 5px;
            background: #007bff;
            border: 0;
            color: white;
        }
        .btn-login {
            background: linear-gradient(135deg, #6b4f2c, #3b2f1e);
            color: #f3e9d2;
            font-size: 16px;
            letter-spacing: 2px;
            border: none;
            border-radius: 4px;
            padding: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: "Georgia", "Times New Roman", serif;
            font-weight: bold;
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #8a6a3b, #4a3a24);
            transform: translateY(-1px);
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
        .title {
            text-align: center;
            font-size: 28px;
            letter-spacing: 2px;
            margin-bottom: 10px;
            color: #3b2f1e;
        }
        .magic-btn {
            background: #4a351e;
            font-family: "Georgia", "Times New Roman", serif;
            color: #f5e6c8;
            border: 1px solid #c2a46d;
            border-radius: 4px;
            padding: 8px 16px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            box-shadow:
                    inset 0 1px 1px rgba(255,255,255,0.3),
                    0 2px 4px rgba(0,0,0,0.4);
            transition: all 0.2s ease;
        }

        .magic-btn:hover {
            background: #7a5a34;
        }

        .magic-btn:active {
            transform: translateY(1px);
            box-shadow:
                    inset 0 2px 4px rgba(0,0,0,0.6);
        }
        .btn-login {
            background: linear-gradient(135deg, #8b6f47, #4a351e);
            box-shadow: 0 0 15px rgba(220, 180, 100, 0.6);
            transition: all 0.4s ease;
        }

        .btn-login:hover {
            box-shadow: 0 0 25px rgba(255, 215, 0, 0.9), 0 0 40px rgba(255, 165, 0, 0.6);
            transform: scale(1.03);
        }

    </style>
</head>
<body class="hogwarts-bg">
<div class="magic-overlay">
</div>
<div class="login-container parchment">
    <h2 class="title">图书借阅系统</h2>
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
<%--                <div class="captcha-code">${captcha}</div>--%>
                <img id="captchaImage"
                     src="${pageContext.request.contextPath}/captcha"
                     alt="验证码"
                     class="captcha-code"
                     onclick="refreshCaptcha()">
<%--                <button type="button"--%>
<%--                        class="magic-btn"--%>
<%--                        onclick="refreshCaptcha()">--%>
<%--                    刷新验证码--%>
<%--                </button>--%>
            </div>
        </div>
        <button type="submit" class="btn-login">登  录</button>
    </form>
    <div class="test-accounts">
        <p>🪄 管理员: admin / admin123</p>
        <p>📚 学生: user1 / user123</p>
    </div>
</div>
<script>
    function refreshCaptcha() {
        var captchaImg = document.getElementById("captchaImage");
        captchaImg.src='${pageContext.request.contextPath}/captcha?t='+new Date().getTime();
        document.getElementById('captcha').value='';
        <%--window.location.href = '${pageContext.request.contextPath}/refreshCaptcha';--%>
    }
</script>
</body>
</html>