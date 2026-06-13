<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quên mật khẩu - Horizon Voyager Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    
    <!-- Link CSS stylesheets -->
    <link rel="stylesheet" href="<c:url value='/resources/css/common/layout.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/auth/login.css'/>"/>
</head>
<body>
    <div class="login-container">
        <!-- Blobs trang trí phía sau -->
        <div class="login-bg-blob login-bg-blob-1"></div>
        <div class="login-bg-blob login-bg-blob-2"></div>

        <div class="login-card">
            <div class="login-logo">
                <span class="material-symbols-outlined">key</span>
            </div>
            
            <h2 class="login-title">Quên mật khẩu</h2>
            <p class="login-subtitle" style="margin-bottom: 24px;">Nhập email của bạn để nhận liên kết đặt lại mật khẩu</p>

            <form class="login-form" action="<c:url value='/auth/forgot-password'/>" method="post">
                <c:if test="${not empty error}">
                    <div style="background-color: #FEE2E2; color: #B91C1C; padding: 10px 14px; border-radius: 8px; font-size: 13px; font-weight: 500; margin-bottom: 20px; border: 1px solid #FCA5A5; text-align: left; display: flex; align-items: center; gap: 8px;">
                        <span class="material-symbols-outlined" style="font-size: 18px;">error</span>
                        ${error}
                    </div>
                </c:if>

                <div class="form-group" style="margin-bottom: 24px;">
                    <label class="form-label" for="email">Địa chỉ Email đã đăng ký</label>
                    <input class="form-input" type="email" id="email" name="email" required placeholder="admin@voyagerelite.com" value="${email}"/>
                </div>

                <button class="btn-login" type="submit">Gửi yêu cầu đặt lại</button>
                
                <div style="margin-top: 20px; text-align: center; font-size: 13px; color: var(--on-surface-variant);">
                    <a href="<c:url value='/auth/login'/>" style="color: var(--ocean-blue); font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 4px; justify-content: center;">
                        <span class="material-symbols-outlined" style="font-size: 16px;">arrow_back</span> Quay về Đăng nhập
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
