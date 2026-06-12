<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Destination Detail</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/management.css'/>">
</head>
<body>
    <h1>Destination Detail</h1>
    <div class="card">
        <div class="row"><span class="label">ID:</span>${destination.destinationId}</div>
        <div class="row"><span class="label">Name:</span>${destination.destinationName}</div>
        <div class="row"><span class="label">Country:</span>${destination.country}</div>
        <div class="row"><span class="label">City:</span>${destination.city}</div>
        <div class="row"><span class="label">Description:</span>${destination.description}</div>
        <div class="row"><span class="label">Image URL:</span>${destination.imageUrl}</div>
        <a href="<c:url value='/destination/list'/>">Back</a>
    </div>
</body>
</html>
