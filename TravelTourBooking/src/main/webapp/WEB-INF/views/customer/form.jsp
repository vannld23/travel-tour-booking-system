<%-- 
    Document   : form
    Created on : Jun 7, 2026, 9:24:30 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="form"
           uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<h2>
    <c:choose>
        <c:when test="${customer.id == 0}">
            Add Customer
        </c:when>
        <c:otherwise>
            Edit Customer
        </c:otherwise>
    </c:choose>
</h2>

<form:form method="post"
           modelAttribute="customer"
           action="${pageContext.request.contextPath}/customers/save">

    <form:hidden path="id"/>

    <p>
        <label>Name</label>
        <form:input path="name"/>
        <form:errors path="name" cssClass="error"/>
    </p>

    <p>
        <label>Email</label>
        <form:input path="email"/>
        <form:errors path="email" cssClass="error"/>
    </p>

    <button type="submit">
        Save Customer
    </button>

</form:form>