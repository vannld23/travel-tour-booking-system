<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Thanh Toán</title>
    </head>
    <body>

        <h2>Thêm Thanh Toán</h2>

        <form action="${pageContext.request.contextPath}/payments/add"
              method="post">

            <table border="1">

                <tr>
                    <td>Booking</td>
                    <td>

                        <select name="bookingId" required>

                            <option value="">
                                -- Chọn Booking --
                            </option>

                            <c:forEach var="booking"
                                       items="${bookings}">

                                <option value="${booking.bookingId}">
                                    #${booking.bookingId}
                                    -
                                    ${booking.fullName}
                                    -
                                    ${booking.tourName}
                                </option>

                            </c:forEach>

                        </select>

                    </td>
                </tr>

                <tr>
                    <td>Phương Thức Thanh Toán</td>
                    <td>

                        <select name="paymentMethod" required>

                            <option value="">
                                -- Chọn Phương Thức --
                            </option>

                            <option value="CASH">
                                Tiền Mặt
                            </option>

                            <option value="BANK_TRANSFER">
                                Chuyển Khoản
                            </option>

                            <option value="MOMO">
                                MOMO
                            </option>

                        </select>

                    </td>
                </tr>

            </table>

            <br>

            <input type="submit"
                   value="Lưu">

            <a href="${pageContext.request.contextPath}/payments">
                Quay Lại
            </a>

        </form>

    </body>
</html>