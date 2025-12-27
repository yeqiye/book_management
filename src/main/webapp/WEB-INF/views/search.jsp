<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>图书借阅系统 - 图书检索</title>
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

        .parchment-card::after {
            content: "";
            position: absolute;
            bottom: 20px;
            right: 30px;
            width: 80px;
            height: 80px;
            opacity: 0.85;
            pointer-events: none;
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

        .search-form {
            background: #f8f1e0;
            border: 3px solid #d4b778;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4), inset 0 0 30px rgba(120,90,50,0.3);
            padding: 30px;
            margin-bottom: 40px;
        }
        .form-group {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        label {
            color: #6b4f2c;
            font-weight: bold;
            min-width: 80px;
        }
        input[type="text"], select {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #c2a46d;
            border-radius: 8px;
            background: #f5e8c7;
            color: #4a3a24;
            font-size: 1em;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #d4b778;
            box-shadow: 0 0 10px rgba(212,183,120,0.5);
        }
        button {
            background: linear-gradient(135deg, #8b6a3b, #6b4f2c);
            color: #f3e9d2;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1em;
            transition: all 0.3s;
        }
        button:hover {
            background: linear-gradient(135deg, #a67c3f, #8b6a3b);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212,183,120,0.5);
        }

        .book-list {
            background: #f8f1e0;
            border: 3px solid #d4b778;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4);
            padding: 20px;
        }
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }
        .book-card {
            background: #f5e8c7;
            border: 2px solid #c2a46d;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            transition: all 0.3s;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
        }
        .book-title {
            font-size: 1.4em;
            color: #8b6a3b;
            margin-bottom: 10px;
        }
        .book-author, .book-info {
            color: #6b4f2c;
            margin-bottom: 8px;
        }
        .book-available {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #d4b778;
        }
        .available-count {
            font-weight: bold;
            color: #8b6a3b;
        }
        .borrow-btn {
            background: linear-gradient(135deg, #6b4f2c, #3b2f1e);
            color: #f3e9d2;
            padding: 8px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .borrow-btn:hover {
            background: linear-gradient(135deg, #8b6a3b, #4a3a24);
            transform: translateY(-2px);
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
            margin-top: 40px;
        }
        .pagination a, .pagination span {
            padding: 8px 15px;
            text-decoration: none;
            border: 1px solid #d4b778;
            border-radius: 8px;
            color: #8b6a3b;
            transition: all 0.3s;
        }
        .pagination a:hover {
            background: #8b6a3b;
            color: white;
        }
        .pagination .active {
            background: #8b6a3b;
            color: white;
        }
        .no-books {
            text-align: center;
            padding: 40px;
            color: #d4b778;
            font-size: 1.2em;
        }
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
    <a href="${pageContext.request.contextPath}/main">首页</a>
    <a href="${pageContext.request.contextPath}/books/search" class="active">图书检索</a>
    <a href="${pageContext.request.contextPath}/borrow">我的借阅</a>
    <c:if test="${sessionScope.user.admin}">
        <a href="${pageContext.request.contextPath}/users/manage">用户管理</a>
        <a href="${pageContext.request.contextPath}/books/manage">图书管理</a>
        <a href="${pageContext.request.contextPath}/categories/manage">分类管理</a>
    </c:if>
</div>

<div class="container">
    <div class="parchment-card search-form">
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

    <div class="parchment-card book-list">
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
<script>
    document.addEventListener('DOMContentLoaded', function() {
        <c:if test="${not empty messageType}">
        Swal.fire({
            title: "${messageType == 'success' ? '借阅成功！' : '借阅失败'}",
            text: "${message}",
            icon: "${messageType == 'success' ? 'success' : 'error'}",
            confirmButtonText: '确定',
            confirmButtonColor: '#8b6a3b',
            background: '#f8f1e0',
            backdrop: 'rgba(30, 20, 60, 0.8)',
            timer: 4000,
            timerProgressBar: true,
            showConfirmButton: false
        }).then(() => {

            window.location.href = "${pageContext.request.contextPath}/borrow";
        });
        </c:if>
    });
</script>
</body>
</html>