<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>错误 - 图书借阅系统</title>
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
        .error-container {
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
            color: #f44336;
        }
        .message {
            color: #333;
            margin-bottom: 30px;
            line-height: 1.6;
            font-size: 16px;
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
<div class="error-container">
    <h1>错误提示</h1>
    <div class="message">
        <p>${message}</p>
    </div>
    <div class="actions">
        <a href="${pageContext.request.contextPath}/main" class="btn btn-primary">返回首页</a>
        <c:if test="${sessionScope.user == null}">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">重新登录</a>
        </c:if>
    </div>
</div>
</body>
</html>