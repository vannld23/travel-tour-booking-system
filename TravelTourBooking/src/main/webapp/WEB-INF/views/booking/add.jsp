<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
                    <td>Khách Hàng</td>
                    <td>

                        <select name="userId" required>

                            <option value="">
                                -- Chọn Khách Hàng --
                            </option>

                            <c:forEach var="user"
                                       items="${users}">

                                <option value="${user.userId}">
                                    ${user.fullName}
                                </option>

                            </c:forEach>

                        </select>

                    </td>
                </tr>

                <tr>
                    <td>Tour</td>
                    <td>

                        <select name="tourId" required>

                            <option value="">
                                -- Chọn Tour --
                            </option>

                            <c:forEach var="tour"
                                       items="${tours}">

                                <option value="${tour.tourId}">
                                    ${tour.tourName}
                                </option>

                            </c:forEach>

                        </select>

                    </td>
                </tr>

                <tr>
                    <td>Số Người</td>
                    <td>

                        <input type="number"
                               name="numberOfPeople"
                               min="1"
                               value="1"
                               required>

                    </td>
                </tr>

            </table>

            <br>

            <input type="submit"
                   value="Lưu">

            <a href="${pageContext.request.contextPath}/bookings">
                Quay Lại
            </a>

        </form>

    </body>
</html>