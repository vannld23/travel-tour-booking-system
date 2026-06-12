<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Đơn Đặt Tour</title>
    </head>
    <body>

        <h2>Thêm Đơn Đặt Tour</h2>

        <form action="${pageContext.request.contextPath}/bookings/add"
              method="post">

            <table border="1">

                <tr>
                    <td>Mã Khách Hàng</td>
                    <td>
                        <input type="number"
                               name="userId"
                               min="1"
                               required>
                    </td>
                </tr>

                <tr>
                    <td>Mã Tour</td>
                    <td>
                        <input type="number"
                               name="tourId"
                               min="1"
                               required>
                    </td>
                </tr>

                <tr>
                    <td>Số Người</td>
                    <td>
                        <input type="number"
                               name="numberOfPeople"
                               min="1"
                               required>
                    </td>
                </tr>

            </table>

            <br>

            <input type="submit" value="Lưu">

            <a href="${pageContext.request.contextPath}/bookings">
                Quay Lại
            </a>

        </form>

    </body>
</html>