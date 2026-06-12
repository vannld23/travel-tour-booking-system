<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<h2>Danh Sách Đơn Đặt Tour</h2>

<a href="${pageContext.request.contextPath}/bookings/add">
    Thêm Đơn Đặt Tour
</a>

<br><br>

<table border="1">

    <tr>
        <th>Mã Booking</th>
        <th>Khách Hàng</th>
        <th>Tên Tour</th>
        <th>Số Người</th>
        <th>Ngày Đặt</th>
        <th>Tổng Tiền</th>
        <th>Trạng Thái</th>
        <th>Thao Tác</th>
    </tr>

    <c:forEach var="booking" items="${bookings}">

        <tr>

            <td>${booking.bookingId}</td>

            <td>${booking.fullName}</td>

            <td>${booking.tourName}</td>

            <td>${booking.numberOfPeople}</td>

            <td>
                <fmt:formatDate
                    value="${booking.bookingDate}"
                    pattern="dd/MM/yyyy HH:mm"/>
            </td>

            <td>
                <fmt:formatNumber
                    value="${booking.totalPrice}"
                    type="number"/>
                VNĐ
            </td>

            <td>

                <c:choose>

                    <c:when test="${booking.bookingStatus == 'PENDING'}">
                        Chờ Xử Lý
                    </c:when>

                    <c:when test="${booking.bookingStatus == 'CONFIRMED'}">
                        Đã Xác Nhận
                    </c:when>

                    <c:when test="${booking.bookingStatus == 'COMPLETED'}">
                        Hoàn Thành
                    </c:when>

                    <c:when test="${booking.bookingStatus == 'CANCELLED'}">
                        Đã Hủy
                    </c:when>

                    <c:otherwise>
                        ${booking.bookingStatus}
                    </c:otherwise>

                </c:choose>

            </td>

            <td>

                <a href="${pageContext.request.contextPath}/bookings/${booking.bookingId}">
                    Xem
                </a>

                |

                <a href="${pageContext.request.contextPath}/bookings/edit/${booking.bookingId}">
                    Sửa
                </a>

                <c:if test="${booking.bookingStatus != 'CANCELLED'}">

                    |

                    <a href="${pageContext.request.contextPath}/bookings/cancel/${booking.bookingId}"
                       onclick="return confirm('Bạn có chắc muốn hủy đơn đặt tour này?')">
                        Hủy
                    </a>

                </c:if>

            </td>

        </tr>

    </c:forEach>

</table>