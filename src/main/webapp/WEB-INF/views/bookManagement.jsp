<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书管理 - 图书借阅系统</title>
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
            max-width: 1400px;
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
        input[type="text"], input[type="number"], select, textarea {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus, input[type="number"]:focus, select:focus, textarea:focus {
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
            padding: 12px 15px;
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
        .copies-info {
            display: flex;
            gap: 10px;
        }
        .copies-info .form-group {
            flex: 1;
        }
        .edit-form {
            display: none;
            background: #f8f9fa;
            border-radius: 5px;
            margin: 10px 0;
            padding: 20px;
            border-left: 4px solid #2196F3;
        }

        .edit-form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .edit-form-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .edit-form-actions button {
            flex: 1;
        }
        .expandable {
            cursor: pointer;
        }
        .book-details {
            display: none;
            padding: 10px;
            background: #f9f9f9;
            border-left: 3px solid #4a6baf;
            margin-top: 5px;
        }
    </style>
    <script>
        function showEditForm(bookId) {
            var forms = document.getElementsByClassName('edit-form');
            for (var i = 0; i < forms.length; i++) {
                forms[i].style.display = 'none';
            }

            var editForm = document.getElementById('edit-form-' + bookId);
            if (editForm) {
                editForm.style.display = 'block';
                editForm.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }

        function cancelEdit(bookId) {
            var editForm = document.getElementById('edit-form-' + bookId);
            if (editForm) {
                editForm.style.display = 'none';
            }
        }

        function toggleBookDetails(bookId) {
            var details = document.getElementById('details-' + bookId);
            if (details) {
                if (details.style.display === 'none' || details.style.display === '') {
                    details.style.display = 'block';
                } else {
                    details.style.display = 'none';
                }
            }
        }

        function confirmDelete(bookId, bookTitle) {
            return confirm('确定要删除《' + bookTitle + '》这本书吗？');
        }
    </script>
</head>
<body>
<div class="header">
    <h1>图书借阅系统</h1>
    <div class="user-info">
        <span>欢迎，<strong>${sessionScope.user.realName}(${sessionScope.user.isAdmin() ? '管理员':'普通用户'})</strong></span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出</a>
    </div>
</div>
<div class="nav">
    <a href="${pageContext.request.contextPath}/main">首页</a>
    <a href="${pageContext.request.contextPath}/books/search">图书检索</a>
    <a href="${pageContext.request.contextPath}/borrow">我的借阅</a>
    <a href="${pageContext.request.contextPath}/users/manage">用户管理</a>
    <a href="${pageContext.request.contextPath}/books/manage" class="active">图书管理</a>
    <a href="${pageContext.request.contextPath}/categories/manage">分类管理</a>
</div>
<div class="container">
    <h2 style="margin-bottom: 20px; color: #444;">图书管理</h2>

    <c:if test="${not empty message}">
        <div class="message ${messageType}">
                ${message}
        </div>
    </c:if>

    <div class="management-panel">
        <div class="form-panel">
            <h3 class="panel-title">添加图书</h3>
            <form method="post" action="${pageContext.request.contextPath}/books/add">
                <div class="form-group">
                    <label for="title">书名：</label>
                    <input type="text" id="title" name="title" required>
                </div>

                <div class="form-group">
                    <label for="author">作者：</label>
                    <input type="text" id="author" name="author" required>
                </div>

                <div class="form-group">
                    <label for="isbn">ISBN：</label>
                    <input type="text" id="isbn" name="isbn">
                </div>

                <div class="form-group">
                    <label for="categoryId">分类：</label>
                    <select id="categoryId" name="categoryId" required>
                        <option value="">请选择分类</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}">${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="publisher">出版社：</label>
                    <input type="text" id="publisher" name="publisher">
                </div>

                <div class="form-group">
                    <label for="publicationYear">出版年份：</label>
                    <input type="number" id="publicationYear" name="publicationYear" min="1900" max="2030">
                </div>

                <div class="form-group">
                    <label for="price">价格：</label>
                    <input type="number" id="price" name="price" step="0.01" min="0">
                </div>

                <div class="form-group">
                    <label for="totalCopies">总数量：</label>
                    <input type="number" id="totalCopies" name="totalCopies" min="1" value="1" required>
                </div>

                <button type="submit">添加图书</button>
            </form>
        </div>

        <div class="list-panel">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>书名</th>
                    <th>作者</th>
                    <th>分类</th>
                    <th>出版社</th>
                    <th>库存</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty books}">
                        <tr>
                            <td colspan="7" style="text-align: center; color: #888; padding: 40px;">
                                暂无图书数据
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="book" items="${books}">
                            <tr class="expandable" onclick="toggleBookDetails(${book.bookId})">
                                <td>${book.bookId}</td>
                                <td><strong>${book.title}</strong></td>
                                <td>${book.author}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty book.categoryName}">未分类</c:when>
                                        <c:otherwise>${book.categoryName}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty book.publisher}">N/A</c:when>
                                        <c:otherwise>${book.publisher}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${book.availableCopies}/${book.totalCopies}</td>
                                <td>
                                    <button class="action-btn edit-btn" onclick="event.stopPropagation(); showEditForm(${book.bookId})">编辑</button>
                                    <form method="post" action="${pageContext.request.contextPath}/books/delete" style="display: inline;" onsubmit="return confirmDelete(${book.bookId}, '${book.title}')">
                                        <input type="hidden" name="bookId" value="${book.bookId}">
                                        <button type="submit" class="action-btn delete-btn" onclick="event.stopPropagation();">删除</button>
                                    </form>
                                </td>
                            </tr>

                            <tr id="details-${book.bookId}" class="book-details" style="display: none;">
                                <td colspan="7">
                                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                                        <div>
                                            <strong>ISBN：</strong> ${empty book.isbn ? 'N/A' : book.isbn}
                                        </div>
                                        <div>
                                            <strong>出版年份：</strong> ${book.publicationYear > 0 ? book.publicationYear : 'N/A'}
                                        </div>
                                        <div>
                                            <strong>价格：</strong> ${book.price > 0 ? '¥' : ''}${book.price > 0 ? book.price : 'N/A'}
                                        </div>
                                        <div>
                                            <strong>添加时间：</strong>
                                            <c:choose>
                                                <c:when test="${book.createdAt != null}">
                                                    ${book.createdAt}
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr id="edit-form-${book.bookId}" class="edit-form">
                                <td colspan="7">
                                    <h4>编辑图书信息 - ${book.title}</h4>
                                    <form method="post" action="${pageContext.request.contextPath}/books/update">
                                        <input type="hidden" name="bookId" value="${book.bookId}">
                                        <div class="edit-form-grid">
                                            <div class="form-group">
                                                <label>书名：</label>
                                                <input type="text" name="title" value="${book.title}" required>
                                            </div>
                                            <div class="form-group">
                                                <label>作者：</label>
                                                <input type="text" name="author" value="${book.author}" required>
                                            </div>
                                            <div class="form-group">
                                                <label>ISBN：</label>
                                                <input type="text" name="isbn" value="${empty book.isbn ? '' : book.isbn}">
                                            </div>
                                            <div class="form-group">
                                                <label>分类：</label>
                                                <select name="categoryId" required>
                                                    <option value="">请选择分类</option>
                                                    <c:forEach var="category" items="${categories}">
                                                        <option value="${category.categoryId}"
                                                                <c:if test="${category.categoryId == book.categoryId}">selected</c:if>>
                                                                ${category.categoryName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label>出版社：</label>
                                                <input type="text" name="publisher" value="${empty book.publisher ? '' : book.publisher}">
                                            </div>
                                            <div class="form-group">
                                                <label>出版年份：</label>
                                                <input type="number" name="publicationYear" value="${book.publicationYear > 0 ? book.publicationYear : ''}" min="1900" max="2030">
                                            </div>
                                            <div class="form-group">
                                                <label>价格：</label>
                                                <input type="number" name="price" step="0.01" min="0" value="${book.price > 0 ? book.price : ''}">
                                            </div>
                                            <div class="form-group">
                                                <label>总数量：</label>
                                                <input type="number" name="totalCopies" value="${book.totalCopies}" min="1" required>
                                            </div>
                                        </div>
                                        <div class="edit-form-actions">
                                            <button type="submit" class="edit-btn">更新信息</button>
                                            <button type="button" class="delete-btn" onclick="cancelEdit(${book.bookId})">取消</button>
                                        </div>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>