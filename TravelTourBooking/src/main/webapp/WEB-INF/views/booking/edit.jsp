<%@ page contentType="text/html;charset=UTF-8" %>

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

            <table border="1">

                <tr>
                    <td>Mã Khách Hàng</td>
                    <td>
                        <input type="number"
                               name="userId"
                               value="${booking.userId}"
                               required>
                    </td>
                </tr>

                <tr>
                    <td>Mã Tour</td>
                    <td>
                        <input type="number"
                               name="tourId"
                               value="${booking.tourId}"
                               required>
                    </td>
                </tr>

                <tr>
                    <td>Số Người</td>
                    <td>
                        <input type="number"
                               name="numberOfPeople"
                               value="${booking.numberOfPeople}"
                               required>
                    </td>
                </tr>

                <tr>
                    <td>Tổng Tiền</td>
                    <td>
                        <input type="number"
                               name="totalPrice"
                               value="${booking.totalPrice}"
                               required>
                    </td>
                </tr>

                <tr>
                    <td>Trạng Thái</td>
                    <td>
                        <input type="text"
                               name="bookingStatus"
                               value="${booking.bookingStatus}"
                               required>
                    </td>
                </tr>

            </table>

            <br>

            <input type="submit" value="Cập Nhật">

            <a href="${pageContext.request.contextPath}/bookings">
                Hủy
            </a>

        </form>

    </body>
</html>