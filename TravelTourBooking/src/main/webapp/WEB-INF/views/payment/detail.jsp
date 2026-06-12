<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi Tiết Thanh Toán</title>
    </head>
    <body>

        <h2>Chi Tiết Thanh Toán</h2>

        <table border="1">

            <tr>
                <td>Mã Payment</td>
                <td>${payment.paymentId}</td>
            </tr>

            <tr>
                <td>Mã Booking</td>
                <td>${payment.bookingId}</td>
            </tr>

            <tr>
                <td>Khách Hàng</td>
                <td>${payment.fullName}</td>
            </tr>

            <tr>
                <td>Tour</td>
                <td>${payment.tourName}</td>
            </tr>

            <tr>
                <td>Số Tiền</td>
                <td>
            <fmt:formatNumber
                value="${payment.amount}"
                type="number"/>
            VNĐ
        </td>
    </tr>

    <tr>
        <td>Phương Thức</td>
        <td>${payment.paymentMethod}</td>
    </tr>

    <tr>
        <td>Ngày Thanh Toán</td>
        <td>
    <fmt:formatDate
        value="${payment.paymentDate}"
        pattern="dd/MM/yyyy HH:mm"/>
</td>
</tr>

<tr>
    <td>Trạng Thái</td>
    <td>${payment.paymentStatus}</td>
</tr>

</table>

<br>

<a href="${pageContext.request.contextPath}/payments">
    Quay Lại
</a>

</body>
</html>