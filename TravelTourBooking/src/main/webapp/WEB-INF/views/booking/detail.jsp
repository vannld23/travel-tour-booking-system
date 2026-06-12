<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Đơn Đặt Tour</title>
</head>
<body>

<h2>Chi Tiết Đơn Đặt Tour</h2>

<table border="1">

    <tr>
        <th>Mã Đặt Tour</th>
        <td>${booking.bookingId}</td>
    </tr>

    <tr>
        <th>Mã Khách Hàng</th>
        <td>${booking.userId}</td>
    </tr>

    <tr>
        <th>Mã Tour</th>
        <td>${booking.tourId}</td>
    </tr>

    <tr>
        <th>Ngày Đặt</th>
        <td>${booking.bookingDate}</td>
    </tr>

    <tr>
        <th>Số Người</th>
        <td>${booking.numberOfPeople}</td>
    </tr>

    <tr>
        <th>Tổng Tiền</th>
        <td>${booking.totalPrice} VNĐ</td>
    </tr>

    <tr>
        <th>Trạng Thái</th>
        <td>${booking.bookingStatus}</td>
    </tr>

</table>

<br>

<a href="${pageContext.request.contextPath}/bookings">
    Quay Lại Danh Sách
</a>

</body>
</html>