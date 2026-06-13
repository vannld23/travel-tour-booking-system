<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Đăng nhập - Horizon Voyager Admin</title>

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
                    <span class="material-symbols-outlined">explore</span>
                </div>

                <h2 class="login-title">Horizon Voyager</h2>
                <p class="login-subtitle">Hệ thống quản lý đặt Tour &amp; Logistics</p>

                <form class="login-form" action="<c:url value='/auth/login'/>" method="post">
                    <c:if test="${not empty error}">
                        <div style="background-color: #FEE2E2; color: #B91C1C; padding: 10px 14px; border-radius: 8px; font-size: 13px; font-weight: 500; margin-bottom: 20px; border: 1px solid #FCA5A5; text-align: left; display: flex; align-items: center; gap: 8px;">
                            <span class="material-symbols-outlined" style="font-size: 18px;">error</span>
                            ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty message}">
                        <div style="background-color: #ECFDF5; color: #047857; padding: 10px 14px; border-radius: 8px; font-size: 13px; font-weight: 500; margin-bottom: 20px; border: 1px solid #A7F3D0; text-align: left; display: flex; align-items: center; gap: 8px;">
                            <span class="material-symbols-outlined" style="font-size: 18px;">check_circle</span>
                            ${message}
                        </div>
                    </c:if>

                    <div class="form-group">
                        <label class="form-label" for="email">Tên đăng nhập / Email</label>
                        <input class="form-input" type="email" id="email" name="email" required placeholder="admin@voyagerelite.com" value="${email}"/>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="password">Mật khẩu</label>
                        <input class="form-input" type="password" id="password" name="password" required placeholder="••••••••"/>
                    </div>

                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" name="remember" style="border-radius: 4px; border-color: var(--outline-variant); color: var(--ocean-blue); focus:ring-ocean-blue;"/>
                            Ghi nhớ đăng nhập
                        </label>
                        <a class="forgot-password" href="<c:url value='/auth/forgot-password'/>">Quên mật khẩu?</a>
                    </div>

                    <button class="btn-login" type="submit">Đăng nhập hệ thống</button>
                    <div style="
                         margin-top:20px;
                         text-align:center;
                         font-size:13px;
                         color:var(--on-surface-variant);
                         ">

                        Chưa có tài khoản?

                        <a href="<c:url value='/auth/register'/>"
                           style="
                           color:var(--ocean-blue);
                           font-weight:600;
                           text-decoration:none;
                           ">

                            Đăng ký ngay

                        </a>

                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
