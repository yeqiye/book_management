<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>归还结果 - 图书借阅系统</title>
    <!-- SweetAlert2 CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            font-family: "Georgia", "Times New Roman", serif;
            background: linear-gradient(rgba(0,0,0,0.45), rgba(0,0,0,0.55)),
            url('https://images.unsplash.com/photo-1521587760476-6c12a4b04085?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: #e0d4b8;
            min-height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .magic-overlay {
            position: fixed;
            inset: 0;
            background: rgba(30, 20, 60, 0.55);
            z-index: -1;
        }

        .result-container {
            background: #f8f1e0;
            border: 3px solid #d4b778;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.5), inset 0 0 40px rgba(120,90,50,0.3);
            padding: 50px;
            text-align: center;
            max-width: 500px;
            width: 90%;
            position: relative;
            overflow: hidden;
        }

        h1 {
            color: #d4b778;
            font-size: 2.5em;
            margin-bottom: 20px;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.3);
        }

        .message {
            color: #6b4f2c;
            font-size: 1.3em;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .actions {
            display: flex;
            gap: 20px;
            justify-content: center;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 1.1em;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-block;
            color: #f3e9d2;
        }

        .btn-primary {
            background: linear-gradient(135deg, #8b6a3b, #6b4f2c);
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #a67c3f, #8b6a3b);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212,183,120,0.5);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6b4f2c, #3b2f1e);
        }
        .btn-secondary:hover {
            background: linear-gradient(135deg, #8b6a3b, #4a3a24);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="magic-overlay"></div>

<div class="result-container">
    <c:choose>
        <c:when test="${messageType == 'success'}">
            <div class="message">
                <h1>归还成功！</h1>
                <p>${message}</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="message">
                <h1>归还失败</h1>
                <p>${message}</p>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/borrow" class="btn btn-primary">我的借阅</a>
        <a href="${pageContext.request.contextPath}/books/search" class="btn btn-secondary">继续借书</a>
        <a href="${pageContext.request.contextPath}/main" class="btn btn-secondary">返回首页</a>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        <c:if test="${not empty messageType}">
        Swal.fire({
            title: "${messageType == 'success' ? '归还成功！' : '归还失败'}",
            text: "${message}",
            icon: "${messageType == 'success' ? 'success' : 'error'}",
            confirmButtonText: '确定',
            confirmButtonColor: '#8b6a3b',
            background: '#f8f1e0',
            backdrop: 'rgba(30, 20, 60, 0.8)',
            timer: 5000,
            timerProgressBar: true,
            showConfirmButton: true
        }).then(() => {

            window.location.href = "${pageContext.request.contextPath}/borrow";
        });
        </c:if>
    });
</script>
</body>
</html>