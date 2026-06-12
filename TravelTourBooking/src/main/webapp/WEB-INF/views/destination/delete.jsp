<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Destination</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/management.css'/>">
</head>
<body>
    <h1>Delete Destination</h1>
    <div class="card">
        <p>Delete destination <strong>${destination.destinationName}</strong>?</p>
        <form method="post" action="<c:url value='/destination/delete'/>">
            <input type="hidden" name="id" value="${destination.destinationId}">
            <button class="danger" type="submit">Delete</button>
            <a class="secondary" href="<c:url value='/destination/list'/>">Cancel</a>
        </form>
    </div>
</body>
</html>
