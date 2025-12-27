<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>图书借阅系统 - 分类管理</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: "Georgia", "Times New Roman", serif;
            background: linear-gradient(rgba(0,0,0,0.45), rgba(0,0,0,0.55)),
            url('https://images.unsplash.com/photo-1521587760476-6c12a4b04085?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
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
        }
        .nav a {
            color: #6b4f2c;
            padding: 15px 25px;
            margin: 0 8px;
            font-weight: bold;
            text-decoration: none;
            transition: all 0.3s;
        }
        .nav a:hover, .nav a.active {
            color: #8b6a3b;
            background: rgba(194,164,109,0.25);
            border-bottom: 5px solid #d4b778;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .quick-title {
            color: #d4b778;
            margin-bottom: 30px;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.3);
            font-size: 2.2em;
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
            width: 200px;
            height: 3px;
            background: linear-gradient(to right, transparent, #d4b778, transparent);
        }

        .management-panel {
            display: grid;
            grid-template-columns: 400px 1fr;
            gap: 30px;
        }

        .form-panel, .list-panel {
            background: #f8f1e0;
            border: 3px solid #d4b778;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4), inset 0 0 30px rgba(120,90,50,0.3);
            padding: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #6b4f2c;
            font-weight: bold;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #c2a46d;
            border-radius: 8px;
            background: #f5e8c7;
            color: #4a3a24;
            font-size: 1em;
        }
        input:focus, textarea:focus {
            outline: none;
            border-color: #d4b778;
            box-shadow: 0 0 10px rgba(212,183,120,0.5);
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #8b6a3b, #6b4f2c);
            color: #f3e9d2;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.1em;
            transition: all 0.3s;
        }
        button:hover {
            background: linear-gradient(135deg, #a67c3f, #8b6a3b);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212,183,120,0.5);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #d4b778;
        }
        th {
            background: #f5e8c7;
            color: #8b6a3b;
            font-weight: bold;
        }
        tr:hover {
            background: rgba(194,164,109,0.15);
        }
        .action-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9em;
            transition: all 0.3s;
            margin: 4px;
        }
        .edit-btn {
            background: linear-gradient(135deg, #8b6a3b, #6b4f2c);
            color: #f3e9d2;
        }
        .edit-btn:hover {
            background: linear-gradient(135deg, #a67c3f, #8b6a3b);
            transform: translateY(-2px);
        }
        .delete-btn {
            background: linear-gradient(135deg, #b45331, #8b2f1d);
            color: white;
        }
        .delete-btn:hover {
            background: linear-gradient(135deg, #d32f2f, #b02a2a);
            transform: translateY(-2px);
        }
        .delete-btn:disabled {
            background: #cccccc;
            cursor: not-allowed;
        }
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            text-align: center;
        }
        .success {
            background: rgba(212,183,120,0.3);
            color: #3b2f1e;
            border: 2px solid #d4b778;
        }
        .error {
            background: rgba(244,67,54,0.3);
            color: #e0d4b8;
            border: 2px solid #d4b778;
        }
        .panel-title {
            margin-bottom: 25px;
            color: #8b6a3b;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.3);
        }
    </style>
    <script>
        function showEditForm(categoryId) {
            var forms = document.getElementsByClassName('edit-form');
            for (var i = 0; i < forms.length; i++) {
                forms[i].style.display = 'none';
            }

            var editForm = document.getElementById('edit-form-' + categoryId);
            if (editForm) {
                editForm.style.display = 'block';
            }
        }

        function cancelEdit(categoryId) {
            var editForm = document.getElementById('edit-form-' + categoryId);
            if (editForm) {
                editForm.style.display = 'none';
            }
        }
    </script>
</head>
<body>
<div class="magic-overlay"></div>

<div class="parchment-card header">
    <h1>📖 图书借阅系统</h1>
    <div class="user-info">
        <span>欢迎，<strong>${sessionScope.user.realName}</strong>
            <c:choose>
                <c:when test="${sessionScope.user.role == 'admin'}">（管理员）</c:when>
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

<div class="container">
    <h2 class="quick-title">分类管理</h2>

    <c:if test="${not empty message}">
        <div class="message ${messageType}">
                ${message}
        </div>
    </c:if>

    <div class="management-panel">
        <div class="form-panel">
            <h3 class="panel-title">添加分类</h3>
            <form method="post" action="${pageContext.request.contextPath}/categories/add">
                <div class="form-group">
                    <label for="category_name">分类名称：</label>
                    <input type="text" id="category_name" name="categoryName" required>
                </div>
                <div class="form-group">
                    <label for="description">分类描述：</label>
                    <textarea id="description" name="description" placeholder="请输入分类描述..."></textarea>
                </div>
                <button type="submit">添加分类</button>
            </form>
        </div>

        <div class="list-panel">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>分类名称</th>
                    <th>描述</th>
                    <th>图书数量</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="category" items="${categories}">
                    <tr>
                        <td>${category.categoryId}</td>
                        <td><strong>${category.categoryName}</strong></td>
                        <td>${empty category.description ? '无描述' : category.description}</td>
                        <td>${category.bookCount} 本</td>
                        <td>
                            <button class="action-btn edit-btn" onclick="showEditForm(${category.categoryId})">编辑</button>
                            <form method="post" action="${pageContext.request.contextPath}/categories/delete" style="display: inline;">
                                <input type="hidden" name="categoryId" value="${category.categoryId}">
                                <button type="submit" class="action-btn delete-btn" onclick="return confirm('确定要删除这个分类吗？')" ${category.bookCount > 0 ? 'disabled' : ''}>删除</button>
                            </form>
                        </td>
                    </tr>
                    <tr id="edit-form-${category.categoryId}" class="edit-form" style="display: none;">
                        <td colspan="5">
                            <h4 style="color: #8b6a3b;">编辑分类信息</h4>
                            <form method="post" action="${pageContext.request.contextPath}/categories/update">
                                <input type="hidden" name="categoryId" value="${category.categoryId}">
                                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                                    <div class="form-group">
                                        <label>分类名称：</label>
                                        <input type="text" name="categoryName" value="${category.categoryName}" required>
                                    </div>
                                    <div class="form-group">
                                        <label>分类描述：</label>
                                        <textarea name="description">${category.description}</textarea>
                                    </div>
                                </div>
                                <div class="book-count">
                                    该分类下有 ${category.bookCount} 本图书
                                </div>
                                <div style="display: flex; gap: 10px; margin-top: 20px;">
                                    <button type="submit" class="edit-btn">更新信息</button>
                                    <button type="button" class="delete-btn" onclick="cancelEdit(${category.categoryId})">取消</button>
                                </div>
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