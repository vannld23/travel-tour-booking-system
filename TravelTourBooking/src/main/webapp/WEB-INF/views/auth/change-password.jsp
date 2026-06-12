<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đổi mật khẩu - Horizon Voyager Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    
    <!-- Link CSS stylesheets -->
    <link rel="stylesheet" href="<c:url value='/resource/css/common/layout.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resource/css/auth/login.css'/>"/>
</head>
<body>
    <div class="login-container">
        <!-- Blobs trang trí phía sau -->
        <div class="login-bg-blob login-bg-blob-1"></div>
        <div class="login-bg-blob login-bg-blob-2"></div>

        <div class="login-card">
            <div class="login-logo">
                <span class="material-symbols-outlined">lock_reset</span>
            </div>
            
            <h2 class="login-title">Đặt lại mật khẩu</h2>
            <p class="login-subtitle" style="margin-bottom: 24px;">Nhập mật khẩu mới của bạn bên dưới</p>

            <form class="login-form" action="<c:url value='/auth/change-password'/>" method="post">
                <c:if test="${not empty error}">
                    <div style="background-color: #FEE2E2; color: #B91C1C; padding: 10px 14px; border-radius: 8px; font-size: 13px; font-weight: 500; margin-bottom: 20px; border: 1px solid #FCA5A5; text-align: left; display: flex; align-items: center; gap: 8px;">
                        <span class="material-symbols-outlined" style="font-size: 18px;">error</span>
                        ${error}
                    </div>
                </c:if>

                <div class="form-group">
                    <label class="form-label" for="password">Mật khẩu mới</label>
                    <input class="form-input" type="password" id="password" name="password" required placeholder="Tối thiểu 6 ký tự"/>
                </div>

                <div class="form-group" style="margin-bottom: 24px;">
                    <label class="form-label" for="confirmPassword">Xác nhận mật khẩu mới</label>
                    <input class="form-input" type="password" id="confirmPassword" name="confirmPassword" required placeholder="Nhập lại mật khẩu mới"/>
                </div>

                <button class="btn-login" type="submit">Đặt lại mật khẩu</button>
            </form>
        </div>
    </div>
</body>
</html>
