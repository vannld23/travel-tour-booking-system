<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<h2>

<c:choose>

<c:when test="${order.id == 0}">
    Create Order
</c:when>

<c:otherwise>
    Edit Order
</c:otherwise>

</c:choose>

</h2>

<form:form method="post"
           modelAttribute="order"
           action="${pageContext.request.contextPath}/orders/save">

    <form:hidden path="id"/>

    <p>

        <label>Customer</label>

        <form:select path="customer.id">

            <c:forEach var="c" items="${customers}">

                <form:option value="${c.id}">
                    ${c.name}
                </form:option>

            </c:forEach>

        </form:select>

        <form:errors path="customer"
                     cssClass="error"/>

    </p>

    <p>

        <label>Order Date</label>

        <form:input path="orderDate"
                    type="date"/>

        <form:errors path="orderDate"
                     cssClass="error"/>

    </p>

    <hr>

    <h3>Order Detail</h3>

    <p>

        <label>Product</label>

        <form:select path="details[0].product.id">

            <c:forEach var="p" items="${products}">

                <form:option value="${p.id}">
                    ${p.name}
                </form:option>

            </c:forEach>

        </form:select>

    </p>

    <p>

        <label>Quantity</label>

        <form:input path="details[0].quantity"/>

    </p>

    <button type="submit">
        Save Order
    </button>

</form:form>