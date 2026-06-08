<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Order List</h2>

<a class="btn"
   href="${pageContext.request.contextPath}/orders/create">

    Create Order

</a>

<br><br>

<table>

    <tr>
        <th>ID</th>
        <th>Customer</th>
        <th>Date</th>
        <th>Total</th>
        <th>Action</th>
    </tr>

    <c:forEach var="o" items="${orders}">

        <tr>

            <td>${o.id}</td>

            <td>${o.customer.name}</td>

            <td>${o.orderDate}</td>

            <td>${o.totalAmount}</td>

            <td>

                <a href="${pageContext.request.contextPath}/orders/edit/${o.id}">
                    Edit
                </a>

                |

                <a href="${pageContext.request.contextPath}/orders/delete/${o.id}">
                    Delete
                </a>

            </td>

        </tr>

    </c:forEach>

</table>