<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

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
                <td>Mã Booking</td>
                <td>${booking.bookingId}</td>
            </tr>

            <tr>
                <td>Khách Hàng</td>
                <td>${booking.fullName}</td>
            </tr>

            <tr>
                <td>Tên Tour</td>
                <td>${booking.tourName}</td>
            </tr>

            <tr>
                <td>Ngày Đặt</td>
                <td>
                    <fmt:formatDate
                        value="${booking.bookingDate}"
                        pattern="dd/MM/yyyy HH:mm"/>
                </td>
            </tr>

            <tr>
                <td>Số Người</td>
                <td>${booking.numberOfPeople}</td>
            </tr>

            <tr>
                <td>Tổng Tiền</td>
                <td>
                    <fmt:formatNumber
                        value="${booking.totalPrice}"
                        type="number"/>
                    VNĐ
                </td>
            </tr>

            <tr>
                <td>Trạng Thái</td>
                <td>${booking.bookingStatus}</td>
            </tr>

        </table>

        <br>

        <a href="${pageContext.request.contextPath}/bookings">
            Quay Lại Danh Sách
        </a>

    </body>
</html>