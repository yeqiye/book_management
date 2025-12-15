<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>图书借阅系统 - 图书检索</title>
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
        .search-form {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
            min-width: 80px;
        }
        input[type="text"], select {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
            flex: 1;
        }
        input[type="text"]:focus, select:focus {
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
        }
        button:hover {
            background: #3a5a9f;
        }

        .book-list {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 25px;
        }
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        .book-card {
            border: 1px solid #eaeaea;
            border-radius: 8px;
            padding: 20px;
            transition: transform 0.3s, box-shadow 0.3s;
            background: white;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .book-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
            line-height: 1.4;
        }
        .book-author {
            color: #666;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .book-info {
            color: #888;
            font-size: 13px;
            margin-bottom: 8px;
        }
        .book-available {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #f0f0f0;
        }
        .available-count {
            font-weight: bold;
            color: #4a6baf;
        }
        .borrow-btn {
            padding: 8px 15px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            transition: background 0.3s;
        }
        .borrow-btn:hover {
            background: #45a049;
        }
        .borrow-btn:disabled {
            background: #cccccc;
            cursor: not-allowed;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 25px;
        }
        .pagination a, .pagination span {
            padding: 8px 15px;
            margin: 0 2px;
            text-decoration: none;
            border: 1px solid #ddd;
            border-radius: 5px;
            color: #4a6baf;
            transition: all 0.3s;
        }
        .pagination-record{
            margin-left: 15px; color: #666;
        }
        .pagination a:hover {
            background: #4a6baf;
            color: white;
            border-color: #4a6baf;
        }
        .pagination .active {
            background: #4a6baf;
            color: white;
            border-color: #4a6baf;
        }
        .no-books {
            text-align: center;
            padding: 40px;
            color: #888;
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
    <div class="search-form">
        <form method="get" action="${pageContext.request.contextPath}/books/search">
            <div class="form-group">
                <label for="keyword">搜索词：</label>
                <input type="text" id="keyword" name="keyword" value="${param.keyword}" placeholder="输入书名、作者或出版社">
            </div>
            <div class="form-group">
                <label for="category">分类：</label>
                <select id="category" name="category">
                    <option value="">所有分类</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.categoryId}" <c:if test="${param.category == cat.categoryId}">selected</c:if>>${cat.categoryName}</option>
                    </c:forEach>
                </select>
                <button type="submit">搜索</button>
                <a href="${pageContext.request.contextPath}/books/search">重置</a>
            </div>
        </form>
    </div>

    <div class="book-list">
        <div class="book-grid">
            <c:forEach var="book" items="${books}">
                <div class="book-card">
                    <div class="book-title">${book.title}</div>
                    <div class="book-author">作者：${book.author}</div>
                    <div class="book-info">ISBN：${empty book.isbn ? 'N/A' : book.isbn}</div>
                    <div class="book-info">分类：${book.categoryName}</div>
                    <div class="book-info">出版社：${empty book.publisher ? 'N/A' : book.publisher}</div>
                    <c:if test="${book.publicationYear > 0}">
                        <div class="book-info">出版年份：${book.publicationYear}</div>
                    </c:if>
                    <div class="book-available">
                        <div class="available-count">可借：${book.availableCopies}/${book.totalCopies}</div>
                        <c:choose>
                            <c:when test="${book.availableCopies > 0}">
                                <form action="${pageContext.request.contextPath}/borrow/borrowBook" method="post">
                                    <input type="hidden" name="bookId" value="${book.bookId}">
                                    <button type="submit" class="borrow-btn">借阅</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button class="borrow-btn" disabled>已借完</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty books}">
                <div class="no-books">
                    <p>没有找到符合条件的图书</p>
                </div>
            </c:if>
        </div>

        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/books/search?page=1&keyword=${param.keyword}&category=${param.category}">首页</a>
                    <a href="${pageContext.request.contextPath}/books/search?page=${currentPage-1}&keyword=${param.keyword}&category=${param.category}">上一页</a>
                </c:if>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="active">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/books/search?page=${i}&keyword=${param.keyword}&category=${param.category}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/books/search?page=${currentPage+1}&keyword=${param.keyword}&category=${param.category}">下一页</a>
                    <a href="${pageContext.request.contextPath}/books/search?page=${totalPages}&keyword=${param.keyword}&category=${param.category}">尾页</a>
                </c:if>
                <span class="pagination-record">共 ${totalRecords} 条记录，第 ${currentPage}/${totalPages} 页</span>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>