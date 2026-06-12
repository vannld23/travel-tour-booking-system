<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Schedule List</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/management.css'/>">
</head>
<body>
    <h1>Schedule Management</h1>
    <p><a class="primary" href="<c:url value='/schedule/create'/>">Create Schedule</a></p>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tour</th>
                <th>Day</th>
                <th>Activity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="schedule" items="${schedules}">
                <tr>
                    <td>${schedule.scheduleId}</td>
                    <td>${schedule.tourName}</td>
                    <td>${schedule.dayNumber}</td>
                    <td>${schedule.activityDescription}</td>
                    <td class="actions">
                        <a class="secondary" href="<c:url value='/schedule/edit'><c:param name='id' value='${schedule.scheduleId}'/></c:url>">Edit</a>
                        <a class="danger" href="<c:url value='/schedule/delete'><c:param name='id' value='${schedule.scheduleId}'/></c:url>">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
