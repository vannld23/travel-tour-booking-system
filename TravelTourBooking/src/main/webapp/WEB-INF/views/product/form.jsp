<%-- 
    Document   : form
    Created on : Jun 7, 2026, 9:26:50 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="form"
           uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<h2>

    <c:choose>

        <c:when test="${product.id == 0}">
            Add Product
        </c:when>

        <c:otherwise>
            Edit Product
        </c:otherwise>

    </c:choose>

</h2>

<form:form method="post"
           modelAttribute="product"
           action="${pageContext.request.contextPath}/products/save">
    <form:hidden path="id"/>

    <p>
        <label>Product Name</label>

        <form:input path="name"/>

        <form:errors path="name"
                     cssClass="error"/>
    </p>

    <p>
        <label>Price</label>

        <form:input path="price"/>

        <form:errors path="price"
                     cssClass="error"/>
    </p>

    <button type="submit">
        Save Product
    </button>

</form:form>
