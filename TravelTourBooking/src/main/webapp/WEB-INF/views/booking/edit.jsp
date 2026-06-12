<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cập Nhật Đơn Đặt Tour</title>
    </head>
    <body>

        <h2>Cập Nhật Đơn Đặt Tour</h2>

        <form action="${pageContext.request.contextPath}/bookings/edit"
              method="post">

            <input type="hidden"
                   name="bookingId"
                   value="${booking.bookingId}">

            <input type="hidden"
                   name="userId"
                   value="${booking.userId}">

            <input type="hidden"
                   name="tourId"
                   value="${booking.tourId}">

            <table border="1">

                <tr>
                    <td>Mã Booking</td>
                    <td>${booking.bookingId}</td>
                </tr>

                <tr>
                    <td>Mã Khách Hàng</td>
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
                    <td>Tổng Tiền</td>
                    <td>
                <fmt:formatNumber
                    value="${booking.totalPrice}"
                    type="number"/>
                VNĐ
                </td>
                </tr>

                <tr>
                    <td>Số Người</td>
                    <td>
                        <input type="number"
                               name="numberOfPeople"
                               value="${booking.numberOfPeople}"
                               min="1"
                               required>
                    </td>
                </tr>

                <tr>
                    <td>Trạng Thái</td>
                    <td>

                        <select name="bookingStatus">

                            <option value="PENDING"
                                    ${booking.bookingStatus == 'PENDING' ? 'selected' : ''}>
                                Chờ Xử Lý
                            </option>

                            <option value="CONFIRMED"
                                    ${booking.bookingStatus == 'CONFIRMED' ? 'selected' : ''}>
                                Đã Xác Nhận
                            </option>

                            <option value="COMPLETED"
                                    ${booking.bookingStatus == 'COMPLETED' ? 'selected' : ''}>
                                Hoàn Thành
                            </option>

                            <option value="CANCELLED"
                                    ${booking.bookingStatus == 'CANCELLED' ? 'selected' : ''}>
                                Đã Hủy
                            </option>

                        </select>

                    </td>
                </tr>

            </table>

            <br>

            <input type="submit" value="Cập Nhật">

            <a href="${pageContext.request.contextPath}/bookings">
                Quay Lại
            </a>

        </form>

    </body>
</html>