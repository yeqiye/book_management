<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理 - 图书借阅系统</title>
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
        .management-panel {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 25px;
        }
        .form-panel {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            height: fit-content;
        }
        .list-panel {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"], input[type="password"], select {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus, input[type="password"]:focus, select:focus {
            border-color: #4a6baf;
            outline: none;
        }
        button {
            padding: 10px 25px;
            background: #4a6baf;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
            width: 100%;
        }
        button:hover {
            background: #3a5a9f;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }
        th {
            background: #f8f9fa;
            font-weight: bold;
            color: #555;
        }
        tr:hover {
            background: #f8f9fa;
        }
        .delete-btn {
            padding: 6px 12px;
            background: #f44336;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            transition: background 0.3s;
        }
        .delete-btn:hover {
            background: #d32f2f;
        }
        .delete-btn:disabled {
            background: #cccccc;
            cursor: not-allowed;
        }
        .message {
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .panel-title {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
            color: #444;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>图书借阅系统</h1>
    <div class="user-info">
        <span>欢迎，<strong>${sessionScope.user.realName}(${sessionScope.user.role == 'admin' ? '管理员':'普通用户'})</strong></span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出</a>
    </div>
</div>
<div class="nav">
    <a href="${pageContext.request.contextPath}/main">首页</a>
    <a href="${pageContext.request.contextPath}/books/search">图书检索</a>
    <a href="${pageContext.request.contextPath}/borrow">我的借阅</a>
    <a href="${pageContext.request.contextPath}/users/manage" class="active">用户管理</a>
    <a href="${pageContext.request.contextPath}/books/manage">图书管理</a>
    <a href="${pageContext.request.contextPath}/categories/manage">分类管理</a>
</div>

<div class="container">
    <h2 style="margin-bottom: 20px; color: #444;">用户管理</h2>

    <c:if test="${not empty message}">
        <div class="message ${messageType}">
                ${message}
        </div>
    </c:if>

    <div class="management-panel">
        <div class="form-panel">
            <h3 class="panel-title">添加用户</h3>
            <form method="post" action="${pageContext.request.contextPath}/users/add">
                <div class="form-group">
                    <label for="username">用户名：</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label for="password">密码：</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <div class="form-group">
                    <label for="real_name">真实姓名：</label>
                    <input type="text" id="real_name" name="realName" required>
                </div>

                <div class="form-group">
                    <label for="role">用户类型：</label>
                    <select id="role" name="role" required>
                        <option value="user">普通用户</option>
                        <option value="admin">管理员</option>
                    </select>
                </div>

                <button type="submit">添加用户</button>
            </form>
        </div>

        <div class="list-panel">
            <table>
                <thead>
                <tr>
                    <th>用户ID</th>
                    <th>用户名</th>
                    <th>真实姓名</th>
                    <th>用户类型</th>
                    <th>注册时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.userId}</td>
                        <td>${user.username}</td>
                        <td>${user.realName}</td>
                        <td>${user.role == 'admin' ? '管理员' : '普通用户'}</td>
                        <td>${user.createdAt}</td>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/users/delete" style="display: inline;">
                                <input type="hidden" name="userId" value="${user.userId}">
                                <button type="submit" class="delete-btn"
                                        <c:if test="${user.userId == currentUserId}">disabled</c:if>>
                                        ${user.userId == currentUserId ? '当前用户' : '删除'}
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>