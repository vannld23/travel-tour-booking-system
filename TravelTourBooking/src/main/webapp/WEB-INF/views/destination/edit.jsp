<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Destination</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/management.css'/>">
</head>
<body>
    <h1>Edit Destination</h1>
    <form:form method="post" modelAttribute="destination" action="${pageContext.request.contextPath}/destination/edit">
        <form:hidden path="destinationId" />

        <label>Name</label>
        <form:input path="destinationName" />
        <form:errors path="destinationName" cssClass="error" />

        <label>Country</label>
        <form:input path="country" />

        <label>City</label>
        <form:input path="city" />

        <label>Description</label>
        <form:textarea path="description" />

        <label>Image URL</label>
        <form:input path="imageUrl" />

        <button class="primary" type="submit">Update</button>
        <a class="secondary" href="<c:url value='/destination/list'/>">Back</a>
    </form:form>
</body>
</html>
