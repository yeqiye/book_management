<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>分类管理 - 图书借阅系统</title>
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
            grid-template-columns: 350px 1fr;
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
        input[type="text"], textarea {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus, textarea:focus {
            border-color: #4a6baf;
            outline: none;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
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
        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            transition: background 0.3s;
            margin: 2px;
        }
        .edit-btn {
            background: #2196F3;
            color: white;
        }
        .edit-btn:hover {
            background: #0b7dda;
        }
        .delete-btn {
            background: #f44336;
            color: white;
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
        .form-actions {
            display: flex;
            gap: 10px;
        }
        .form-actions button {
            flex: 1;
        }
        .edit-form {
            display: none;
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-top: 10px;
        }
        .book-count {
            color: #666;
            font-size: 12px;
            margin-top: 5px;
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
    <a href="${pageContext.request.contextPath}/users/manage">用户管理</a>
    <a href="${pageContext.request.contextPath}/books/manage">图书管理</a>
    <a href="${pageContext.request.contextPath}/categories/manage" class="active">分类管理</a>
</div>

<div class="container">
    <h2 style="margin-bottom: 20px; color: #444;">分类管理</h2>

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
                    <tr id="edit-form-${category.categoryId}" class="edit-form">
                        <td colspan="5">
                            <h4>编辑分类信息</h4>
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
                                <div class="form-actions">
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