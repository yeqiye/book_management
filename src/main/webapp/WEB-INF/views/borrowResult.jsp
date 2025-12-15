<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>借阅结果 - 图书借阅系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background-color: #f5f6fa;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .result-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }
        h1 {
            margin-bottom: 20px;
            color: #333;
        }
        .message--success {
            color: #4CAF50;
            margin-bottom: 30px;
            line-height: 1.6;
            font-size: 16px;
        }
        .message--success h1 {
            color: #4CAF50;
        }
        .message--error {
            color: #f44336;
            margin-bottom: 30px;
            line-height: 1.6;
            font-size: 16px;
        }
        .message--error h1 {
            color: #f44336;
        }
        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s;
            display: inline-block;
        }
        .btn-primary {
            background: #4a6baf;
            color: white;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
<div class="result-container">
    <c:choose>
        <c:when test="${messageType == 'success'}">
            <div class="message--success">
                <h1>借阅成功</h1>
                <p>${message}</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="message--error">
                <h1>借阅失败</h1>
                <p>${message}</p>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="actions">
        <a href="${pageContext.request.contextPath}/books/search" class="btn btn-primary">继续借书</a>
        <a href="${pageContext.request.contextPath}/borrow" class="btn btn-secondary">我的借阅</a>
        <a href="${pageContext.request.contextPath}/main" class="btn btn-secondary">返回首页</a>
    </div>
</div>
</body>
</html>