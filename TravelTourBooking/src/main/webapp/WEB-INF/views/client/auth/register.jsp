<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0"/>

        <title>Đăng ký tài khoản - Horizon Voyager</title>

        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
              rel="stylesheet"/>

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1"
              rel="stylesheet"/>

        <link rel="stylesheet"
              href="<c:url value='/resource/css/common/layout.css'/>"/>

        <link rel="stylesheet"
              href="<c:url value='/resource/css/auth/login.css'/>"/>
    </head>

    <body>

        <div class="login-container">

            <!-- Background -->
            <div class="login-bg-blob login-bg-blob-1"></div>
            <div class="login-bg-blob login-bg-blob-2"></div>

            <div class="login-card">

                <div class="login-logo">
                    <span class="material-symbols-outlined">
                        explore
                    </span>
                </div>

                <h2 class="login-title">
                    Đăng ký thành viên
                </h2>

                <p class="login-subtitle">
                    Tạo tài khoản sử dụng hệ thống Horizon Voyager
                </p>

                <form class="login-form"
                      action="<c:url value='/auth/register'/>"
                      method="post">

                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div style="
                             background:#FEE2E2;
                             color:#B91C1C;
                             padding:12px;
                             border-radius:8px;
                             margin-bottom:20px;
                             border:1px solid #FCA5A5;
                             display:flex;
                             align-items:center;
                             gap:8px;
                             ">
                            <span class="material-symbols-outlined">
                                error
                            </span>

                            ${error}
                        </div>
                    </c:if>

                    <!-- Full Name -->
                    <div class="form-group">
                        <label class="form-label" for="fullName">
                            Họ và tên
                        </label>

                        <input class="form-input"
                               type="text"
                               id="fullName"
                               name="fullName"
                               required
                               placeholder="Nguyễn Văn A"
                               value="${fullName}">
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label class="form-label" for="email">
                            Email
                        </label>

                        <input class="form-input"
                               type="email"
                               id="email"
                               name="email"
                               required
                               placeholder="example@gmail.com"
                               value="${email}">
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label class="form-label" for="phone">
                            Số điện thoại
                        </label>

                        <input class="form-input"
                               type="text"
                               id="phone"
                               name="phone"
                               placeholder="0901234567"
                               value="${phone}">
                    </div>

                    <!-- Address -->
                    <div class="form-group">
                        <label class="form-label" for="address">
                            Địa chỉ
                        </label>

                        <input class="form-input"
                               type="text"
                               id="address"
                               name="address"
                               placeholder="TP.HCM"
                               value="${address}">
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label class="form-label" for="password">
                            Mật khẩu
                        </label>

                        <input class="form-input"
                               type="password"
                               id="password"
                               name="password"
                               required
                               placeholder="Nhập mật khẩu">
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label class="form-label"
                               for="confirmPassword">

                            Xác nhận mật khẩu
                        </label>

                        <input class="form-input"
                               type="password"
                               id="confirmPassword"
                               name="confirmPassword"
                               required
                               placeholder="Nhập lại mật khẩu">
                    </div>

                    <button class="btn-login"
                            type="submit">

                        Tạo tài khoản
                    </button>

                    <div style="
                         margin-top:20px;
                         text-align:center;
                         font-size:13px;
                         ">

                        Đã có tài khoản?

                        <a href="<c:url value='/auth/login'/>"
                           style="
                           color:var(--ocean-blue);
                           text-decoration:none;
                           font-weight:600;
                           ">

                            Đăng nhập ngay
                        </a>

                    </div>

                </form>

            </div>

        </div>

        <script>

            document.querySelector(".login-form")
                    .addEventListener("submit", function (e) {

                        let password =
                                document.getElementById("password").value;

                        let confirmPassword =
                                document.getElementById("confirmPassword").value;

                        if (password !== confirmPassword) {

                            alert("Mật khẩu xác nhận không khớp!");

                            e.preventDefault();
                        }
                    });

        </script>

    </body>
</html>