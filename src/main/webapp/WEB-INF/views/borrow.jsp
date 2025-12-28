<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>图书借阅系统 - 我的借阅</title>
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

        .filters {
            background: #f8f1e0;
            border: 3px solid #d4b778;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4), inset 0 0 30px rgba(120,90,50,0.3);
            padding: 20px;
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .filter-btn {
            padding: 10px 20px;
            border: 2px solid #c2a46d;
            background: #f5e8c7;
            border-radius: 8px;
            color: #6b4f2c;
            text-decoration: none;
            transition: all 0.3s;
        }
        .filter-btn.active, .filter-btn:hover {
            background: #d4b778;
            color: #3b2f1e;
            border-color: #d4b778;
        }

        .borrow-list {
            background: #f8f1e0;
            border: 3px solid #d4b778;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4);
            overflow: hidden;
            padding: 20px;
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
        tr{
            color: #8b6f47;
        }
        tr:hover {
            background: rgba(194,164,109,0.15);
        }
        .return-btn {
            padding: 8px 16px;
            background: linear-gradient(135deg, #6b4f2c, #3b2f1e);
            color: #f3e9d2;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .return-btn:hover {
            background: linear-gradient(135deg, #8b6a3b, #4a3a24);
            transform: translateY(-2px);
        }
        .return-btn:disabled {
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
        .no-records {
            text-align: center;
            padding: 40px;
            color: #d4b778;
            font-size: 1.2em;
        }
        .overdue-warning {
            background: rgba(244, 67, 54, 0.3);
            border: 2px solid #d4b778;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            color: #e0d4b8;
            text-align: center;
            font-weight: bold;
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
    </style>
</head>
<body>
<div class="magic-overlay"></div>

<div class="parchment-card header">
    <h1>📖 图书借阅系统</h1>
    <div class="user-info">
        <span>欢迎，<strong>${sessionScope.user.realName}</strong>
            <c:choose>
                <c:when test="${sessionScope.user.isAdmin()}">（管理员）</c:when>
                <c:otherwise>（学生）</c:otherwise>
            </c:choose>
        </span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
    </div>
</div>

<div class="parchment-card nav" style="height: 60px; display: flex; align-items: center; justify-content: center;">
    <a href="${pageContext.request.contextPath}/main">首页</a>
    <a href="${pageContext.request.contextPath}/books/search">图书检索</a>
    <a href="${pageContext.request.contextPath}/borrow" class="active">我的借阅</a>
    <c:if test="${sessionScope.user.admin}">
        <a href="${pageContext.request.contextPath}/users/manage">用户管理</a>
        <a href="${pageContext.request.contextPath}/books/manage">图书管理</a>
        <a href="${pageContext.request.contextPath}/categories/manage">分类管理</a>
    </c:if>
</div>

<div class="container">
    <h2 class="quick-title">我的借阅记录</h2>

    <div class="filters">
        <span>筛选：</span>
        <a href="${pageContext.request.contextPath}/borrow?status=all" class="filter-btn ${param.status == 'all' || empty param.status ? 'active' : ''}">全部</a>
        <a href="${pageContext.request.contextPath}/borrow?status=borrowed" class="filter-btn ${param.status == 'borrowed' ? 'active' : ''}">在借中</a>
        <a href="${pageContext.request.contextPath}/borrow?status=overdue" class="filter-btn ${param.status == 'overdue' ? 'active' : ''}">已超期</a>
        <a href="${pageContext.request.contextPath}/borrow?status=returned" class="filter-btn ${param.status == 'returned' ? 'active' : ''}">已归还</a>
    </div>

    <c:if test="${overdueCount > 0}">
        <div class="overdue-warning">
            <strong>提醒：</strong> 您有 ${overdueCount} 本图书已超期，请尽快归还！
        </div>
    </c:if>

    <div class="parchment-card borrow-list">
        <table>
            <thead>
            <tr>
                <th>图书名称</th>
                <th>作者</th>
                <th>借阅日期</th>
                <th>应还日期</th>
                <th>归还日期</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty records}">
                    <tr>
                        <td colspan="7" class="no-records">
                            <p>没有找到借阅记录</p>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="record" items="${records}">
                        <tr>
                            <td><strong>${record.title}</strong></td>
                            <td>${record.author}</td>
                            <td><fmt:formatDate value="${record.borrowDate}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${record.dueDate}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${record.returnDate != null}">
                                        <fmt:formatDate value="${record.returnDate}" pattern="yyyy-MM-dd"/>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="status-${record.status}">
                                <c:choose>
                                    <c:when test="${record.status == 'borrowed' && record.overdue}">已超期</c:when>
                                    <c:when test="${record.status == 'borrowed'}">在借中</c:when>
                                    <c:otherwise>已归还</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${record.status == 'borrowed'}">
                                        <form action="${pageContext.request.contextPath}/borrow/returnBook" method="post">
                                            <input type="hidden" name="recordId" value="${record.recordId}">
                                            <button type="submit" class="return-btn">归还</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="return-btn" disabled>已归还</button>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/borrow?page=1&status=${param.status}">首页</a>
                    <a href="${pageContext.request.contextPath}/borrow?page=${currentPage-1}&status=${param.status}">上一页</a>
                </c:if>

                <c:set var="startPage" value="${currentPage - 2}"/>
                <c:set var="endPage" value="${currentPage + 2}"/>
                <c:if test="${startPage < 1}">
                    <c:set var="startPage" value="1"/>
                </c:if>
                <c:if test="${endPage > totalPages}">
                    <c:set var="endPage" value="${totalPages}"/>
                </c:if>

                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="active">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/borrow?page=${i}&status=${param.status}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/borrow?page=${currentPage+1}&status=${param.status}">下一页</a>
                    <a href="${pageContext.request.contextPath}/borrow?page=${totalPages}&status=${param.status}">尾页</a>
                </c:if>

                <span style="margin-left: 15px; color: #e0d4b8;">
                    共 ${totalRecords} 条记录，第 ${currentPage}/${totalPages} 页
                </span>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>