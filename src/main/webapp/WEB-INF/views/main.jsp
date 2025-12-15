<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书借阅系统主页</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background-color: #f5f6fa;
            color: #333;
        }
        .header {
            background: linear-gradient(135deg, #4a6baf 0%, #3a5a9f 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header h1 {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .logout-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            text-decoration: none;
            transition: background 0.3s;
        }
        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }
        .nav {
            background: white;
            padding: 0 30px;
            border-bottom: 1px solid #e1e5eb;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .nav a {
            display: inline-block;
            margin-right: 5px;
            text-decoration: none;
            color: #555;
            padding: 15px 20px;
            border-radius: 0;
            transition: all 0.3s;
            border-bottom: 3px solid transparent;
        }
        .nav a:hover, .nav a.active {
            color: #4a6baf;
            border-bottom-color: #4a6baf;
        }
        .container {
            padding: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .welcome-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        .welcome-section h2 {
            color: #4a6baf;
            margin-bottom: 10px;
        }
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        .action-btn {
            background: white;
            color: #333;
            padding: 25px 15px;
            text-align: center;
            border-radius: 10px;
            text-decoration: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s;
            border-left: 4px solid #4a6baf;
        }
        .action-btn:hover {
            background: #4a6baf;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(74,107,175,0.3);
        }
        .action-btn i {
            font-size: 24px;
            margin-bottom: 10px;
            display: block;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>图书借阅系统</h1>
    <div class="user-info">
        <span>欢迎，<strong>${sessionScope.user.realName}(${sessionScope.user.admin ? '管理员':'普通用户'})</strong></span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出</a>
    </div>
</div>
<div class="nav">
    <a href="${pageContext.request.contextPath}/main" class="active">首页</a>
    <a href="${pageContext.request.contextPath}/books/search">图书检索</a>
    <a href="${pageContext.request.contextPath}/borrow">我的借阅</a>
    <c:if test="${sessionScope.user.admin}">
        <a href="${pageContext.request.contextPath}/users/manage">用户管理</a>
        <a href="${pageContext.request.contextPath}/books/manage">图书管理</a>
        <a href="${pageContext.request.contextPath}/categories/manage">分类管理</a>
    </c:if>
</div>
<div class="container">
    <h2 style="margin-bottom: 20px; color: #444;">快捷操作</h2>
    <div class="quick-actions">
        <a href="${pageContext.request.contextPath}/books/search" class="action-btn">
            <strong>图书检索</strong>
            <p>查找您想要的图书</p>
        </a>
        <a href="${pageContext.request.contextPath}/borrow" class="action-btn">
            <strong>我的借阅</strong>
            <p>查看借阅记录</p>
        </a>
        <c:choose>
            <c:when test="${sessionScope.user.admin}">
                <a href="${pageContext.request.contextPath}/books/manage" class="action-btn">
                    <strong>图书管理</strong>
                    <p>管理图书馆藏</p>
                </a>
                <a href="${pageContext.request.contextPath}/users/manage" class="action-btn">
                    <strong>用户管理</strong>
                    <p>管理系统用户</p>
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/books/search" class="action-btn">
                    <strong>热门图书</strong>
                    <p>查看热门借阅</p>
                </a>
                <a href="${pageContext.request.contextPath}/books/search?category=1" class="action-btn">
                    <strong>计算机类</strong>
                    <p>专业书籍</p>
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>