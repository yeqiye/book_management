<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的借阅 - 图书借阅系统</title>
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
        .filters {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .filter-btn {
            padding: 8px 16px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 5px;
            text-decoration: none;
            color: #666;
            transition: all 0.3s;
        }
        .filter-btn.active, .filter-btn:hover {
            background: #4a6baf;
            color: white;
            border-color: #4a6baf;
        }
        .borrow-list {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 25px;
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
        .return-btn {
            padding: 6px 12px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            transition: background 0.3s;
        }
        .return-btn:hover {
            background: #45a049;
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
        .no-records {
            text-align: center;
            padding: 40px;
            color: #888;
        }
        .overdue-warning {
            background: rgba(244, 67, 54, 0.48);
            border: 1px solid #ffeaa7;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            color: #856404;
        }
        .status-overdue {
            color: #dc3545;
            font-weight: bold;
        }
        .status-borrowed {
            color: #28a745;
        }
        .status-returned {
            color: #6c757d;
        }
    </style>
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
    <a href="${pageContext.request.contextPath}/borrow" class="active">我的借阅</a>
    <c:if test="${sessionScope.user.isAdmin()}">
        <a href="${pageContext.request.contextPath}/users/manage">用户管理</a>
        <a href="${pageContext.request.contextPath}/books/manage">图书管理</a>
        <a href="${pageContext.request.contextPath}/categories/manage">分类管理</a>
    </c:if>
</div>

<div class="container">
    <h2>我的借阅记录</h2>

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

    <div class="borrow-list">
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

                <span style="margin-left: 15px; color: #666;">
                    共 ${totalRecords} 条记录，第 ${currentPage}/${totalPages} 页
                </span>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>