<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân</title>

    <link rel="stylesheet" href="<c:url value='/resources/css/profile.css'/>"/>
</head>

<body>

<div class="card">

    <h2>Thông tin cá nhân</h2>

    <c:if test="${not empty success}">
        <div style="
            background:#dcfce7;
            color:#166534;
            border:1px solid #86efac;
            padding:12px;
            border-radius:8px;
            margin-bottom:16px;">
            ${success}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div style="
            background:#fef2f2;
            color:#dc2626;
            border:1px solid #fca5a5;
            padding:12px;
            border-radius:8px;
            margin-bottom:16px;">
            ${error}
        </div>
    </c:if>

    <form action="<c:url value='/user/profile'/>"
          method="post">

        <label>Họ và tên</label>
        <input
            type="text"
            name="fullName"
            value="${user.fullName}"
            required>

        <label>Email</label>
        <input
            type="email"
            value="${user.email}"
            readonly>

        <label>Số điện thoại</label>
        <input
            type="text"
            name="phone"
            value="${user.phone}">

        <label>Địa chỉ</label>
        <input
            type="text"
            name="address"
            value="${user.address}">

        <hr style="
            margin:24px 0;
            border:none;
            border-top:1px solid #d1d5db;">

        <div class="row">
            <span class="label">Vai trò:</span>

            <c:choose>
                <c:when test="${user.roleId == 1}">
                    Administrator
                </c:when>
                <c:otherwise>
                    Customer
                </c:otherwise>
            </c:choose>
        </div>

        <div class="row">
            <span class="label">Ngày tham gia:</span>
            ${user.createdAt}
        </div>

        <div style="margin-top:24px;">

            <button
                type="submit"
                class="primary">
                Cập nhật thông tin
            </button>

            <a href="<c:url value='/'/>"
               class="secondary">
                Trang chủ
            </a>

            <a href="<c:url value='/booking/history'/>"
               class="secondary">
                Lịch sử đặt tour
            </a>

            <a href="<c:url value='/auth/logout'/>"
               class="danger">
                Đăng xuất
            </a>

        </div>

    </form>

</div>

</body>
</html>