<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<h2>Danh Sách Thanh Toán</h2>

<a href="${pageContext.request.contextPath}/payments/add">
    Thêm Thanh Toán
</a>

<br><br>

<table border="1">

    <tr>
        <th>Mã Payment</th>
        <th>Khách Hàng</th>
        <th>Tour</th>
        <th>Số Tiền</th>
        <th>Phương Thức</th>
        <th>Ngày Thanh Toán</th>
        <th>Trạng Thái</th>
        <th>Thao Tác</th>
    </tr>

    <c:forEach var="payment" items="${payments}">

        <tr>

            <td>${payment.paymentId}</td>

            <td>${payment.fullName}</td>

            <td>${payment.tourName}</td>

            <td>
                <fmt:formatNumber
                    value="${payment.amount}"
                    type="number"/>
                VNĐ
            </td>

            <td>${payment.paymentMethod}</td>

            <td>
                <fmt:formatDate
                    value="${payment.paymentDate}"
                    pattern="dd/MM/yyyy HH:mm"/>
            </td>

            <td>

                <c:choose>

                    <c:when test="${payment.paymentStatus == 'PENDING'}">
                        Chờ Thanh Toán
                    </c:when>

                    <c:when test="${payment.paymentStatus == 'PAID'}">
                        Đã Thanh Toán
                    </c:when>

                    <c:otherwise>
                        ${payment.paymentStatus}
                    </c:otherwise>

                </c:choose>

            </td>

            <td>

                <a href="${pageContext.request.contextPath}/payments/${payment.paymentId}">
                    Xem
                </a>

                <c:if test="${payment.paymentStatus == 'PENDING'}">

                    |

                    <a href="${pageContext.request.contextPath}/payments/confirm/${payment.paymentId}"
                       onclick="return confirm('Xác nhận thanh toán này?')">
                        Xác Nhận
                    </a>

                </c:if>

            </td>

        </tr>

    </c:forEach>

</table>