<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书借阅系统 - 主页</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: "Georgia", "Times New Roman", serif;
            background: linear-gradient(rgba(0,0,0,0.45), rgba(0,0,0,0.55)),
            url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: #e0d4b8;
            min-height: 100vh;
            position: relative;
        }

        .magic-overlay {
            position: fixed;
            inset: 0;
            background: rgba(30, 20, 60, 0.55);
            z-index: -1;
        }

        .parchment-card {
            background: #f8f1e0;
            border: 3px solid #d4b778;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.5), inset 0 0 40px rgba(120,90,50,0.3);
            padding: 30px;
            margin: 25px auto;
            max-width: 1100px;
            position: relative;
            overflow: hidden;
        }

        .parchment-card::after {
            content: "";
            position: absolute;
            bottom: 20px;
            right: 30px;
            width: 80px;
            height: 80px;
            opacity: 0.85;
        }

        .header {
            background: #3b2f1e url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" opacity="0.12"><text x="10" y="20" font-size="30" fill="%23d4b778">★</text><text x="60" y="50" font-size="25" fill="%23d4b778">✶</text><text x="30" y="80" font-size="35" fill="%23d4b778">✦</text></svg>') repeat;
            color: #f3e9d2;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.6);
        }
        .header h1 {
            font-size: 2.2em;
            letter-spacing: 4px;
            text-shadow: 0 0 10px rgba(212,183,120,0.7);
        }
        .user-info span {
            color: #f3e9d2;
        }
        .logout-btn {
            color: #f3e9d2;
            background: rgba(212,183,120,0.3);
            padding: 8px 18px;
            border-radius: 20px;
            text-decoration: none;
            transition: all 0.3s;
        }
        .logout-btn:hover {
            background: rgba(212,183,120,0.5);
            box-shadow: 0 0 15px rgba(212,183,120,0.7);
        }

        .nav {
            background: #f0e4c8;
            padding: 0 40px;
            border-bottom: 4px solid #d4b778;
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
            height: 40px;
        }
        .nav a {
            color: #6b4f2c;
            padding: 15px 25px;
            margin: 0 5px;
            font-weight: bold;
            text-decoration: none;
            transition: all 0.3s;
        }
        .nav a:hover, .nav a.active {
            color: #8b6a3b;
            background: rgba(194,164,109,0.25);
            border-bottom: 5px solid #d4b778;
        }

        .quick-title {
            color: #8b6a3b;
            margin-bottom: 25px;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.3);
            font-size: 1.8em;
            text-align: center;
            position: relative;
            padding: 10px 0;
        }
        .quick-title::after {
            content: "";
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 150px;
            height: 3px;
            background: linear-gradient(to right, transparent, #d4b778, transparent);
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }
        .action-btn {
            background: #f8f1e0;
            border: 3px solid #d4b778;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4), inset 0 0 30px rgba(120,90,50,0.3);
            color: #6b4f2c;
            padding: 35px 25px;
            text-align: center;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.4s ease;
        }
        .action-btn:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.5), inset 0 0 50px rgba(120,90,50,0.4);
            background: linear-gradient(to bottom, #fbf8ef, #f5e8c7);
        }
        .action-btn strong {
            font-size: 1.7em;
            color: #8b6a3b;
            display: block;
            margin-bottom: 12px;
        }
        .action-btn p {
            color: #6b4f2c;
            margin: 0;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
<div class="magic-overlay"></div>

<div class="parchment-card header">
    <h1>📖 图书借阅系统</h1>
    <div class="user-info">
        <span>欢迎，<strong>${sessionScope.user.realName}</strong>
            <c:choose>
                <c:when test="${sessionScope.user.admin}">（管理员）</c:when>
                <c:otherwise>（学生）</c:otherwise>
            </c:choose>
        </span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
    </div>
</div>

<div class="parchment-card nav" style="height: 60px; display: flex; align-items: center; justify-content: center;">
    <a href="${pageContext.request.contextPath}/main" class="active">首页</a>
    <a href="${pageContext.request.contextPath}/books/search">图书检索</a>
    <a href="${pageContext.request.contextPath}/borrow">我的借阅</a>
    <c:if test="${sessionScope.user.admin}">
        <a href="${pageContext.request.contextPath}/users/manage">用户管理</a>
        <a href="${pageContext.request.contextPath}/books/manage">图书管理</a>
        <a href="${pageContext.request.contextPath}/categories/manage">分类管理</a>
    </c:if>
</div>

<div class="parchment-card welcome-section" style="position: relative;">
    <h2 style="color: #4a3a24;">欢迎回来，${sessionScope.user.realName}</h2>
    <p style="color: #5c4228; font-size: 1.2em;">
        今天是探图书馆的好日子，愿你找到心仪的书籍～ 🪄
    </p>

    <img src="${pageContext.request.contextPath}/static/images/my-custom-seal.png"
         alt="自定义装饰"
         style="position: absolute;
                bottom: 5px;
                right: 30px;
                width: 120px;
                height: auto;
                opacity: 0.9;
                pointer-events: none;">
</div>

<h3 class="quick-title">快捷操作</h3>

<div class="quick-actions">
    <a href="${pageContext.request.contextPath}/main" class="action-btn">
        <strong>🏠 首页</strong>
        <p>返回系统主页</p>
    </a>

    <a href="${pageContext.request.contextPath}/books/search" class="action-btn">
        <strong>📚 图书检索</strong>
        <p>搜索你想要的书籍</p>
    </a>

    <a href="${pageContext.request.contextPath}/borrow" class="action-btn">
        <strong>🪄 我的借阅</strong>
        <p>查看借阅历史与到期提醒</p>
    </a>

    <c:if test="${sessionScope.user.admin}">
        <a href="${pageContext.request.contextPath}/users/manage" class="action-btn">
            <strong>👥 用户管理</strong>
            <p>管理教师与学生账号</p>
        </a>

        <a href="${pageContext.request.contextPath}/books/manage" class="action-btn">
            <strong>📖 图书管理</strong>
            <p>维护图书馆藏书新增书目</p>
        </a>

        <a href="${pageContext.request.contextPath}/categories/manage" class="action-btn">
            <strong>📋 分类管理</strong>
            <p>管理图书分类目录</p>
        </a>
    </c:if>
</div>
<style>
    .quick-actions {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 30px;
        max-width: 1100px;
        margin: 0 auto;
    }

    .quick-actions > *:nth-child(n+4) {
        grid-column: span 1;
    }

    .quick-actions:not:has > *:nth-child(4){
        grid-template-columns: repeat(3, 1fr);
        justify-items: center;
    }

    .action-btn {
        width: 100%;
    }
</style>
</div>

<div class="container" style="padding-bottom: 100px;">
    <!-- 你的欢迎卡片 + 快捷操作 -->
</div>

</body>
</html>