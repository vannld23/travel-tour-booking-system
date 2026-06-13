<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân</title>
</head>
<body>

    <h2>Thông tin cá nhân</h2>

    <hr>

    <c:if test="${not empty success}">
        <p style="color: green; font-weight: bold;">
            ${success}
        </p>
    </c:if>

    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">
            ${error}
        </p>
    </c:if>

    <form action="<c:url value='/user/profile'/>"
          method="post">

        <p>
            <strong>Họ tên:</strong><br>

            <input
                type="text"
                name="fullName"
                value="${user.fullName}"
                required
                style="width:300px;">
        </p>

        <p>
            <strong>Email:</strong><br>

            <input
                type="email"
                value="${user.email}"
                readonly
                style="width:300px;">
        </p>

        <p>
            <strong>Số điện thoại:</strong><br>

            <input
                type="text"
                name="phone"
                value="${user.phone}"
                style="width:300px;">
        </p>

        <p>
            <strong>Địa chỉ:</strong><br>

            <input
                type="text"
                name="address"
                value="${user.address}"
                style="width:300px;">
        </p>

        <p>
            <strong>Role ID:</strong>
            ${user.roleId}
        </p>

        <p>
            <strong>Ngày tạo:</strong>
            ${user.createdAt}
        </p>

        <button type="submit">
            Cập nhật thông tin
        </button>

    </form>

    <br>

    <a href="<c:url value='/auth/logout'/>">
        Đăng xuất
    </a>

</body>
</html>