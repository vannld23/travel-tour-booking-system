<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Schedule</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/management.css'/>">
</head>
<body>
    <h1>Delete Schedule</h1>
    <div class="card">
        <p>Delete schedule day <strong>${schedule.dayNumber}</strong> of tour <strong>${schedule.tourName}</strong>?</p>
        <form method="post" action="<c:url value='/schedule/delete'/>">
            <input type="hidden" name="id" value="${schedule.scheduleId}">
            <button class="danger" type="submit">Delete</button>
            <a class="secondary" href="<c:url value='/schedule/list'/>">Cancel</a>
        </form>
    </div>
</body>
</html>
