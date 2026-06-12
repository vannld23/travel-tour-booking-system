<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tour Detail</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/management.css'/>">
</head>
<body>
    <h1>Tour Detail</h1>
    <div class="card">
        <div class="row"><span class="label">ID:</span>${tour.tourId}</div>
        <div class="row"><span class="label">Name:</span>${tour.tourName}</div>
        <div class="row"><span class="label">Destination:</span>${tour.destinationName}</div>
        <div class="row"><span class="label">Duration Days:</span>${tour.durationDays}</div>
        <div class="row"><span class="label">Price:</span>${tour.price}</div>
        <div class="row"><span class="label">Max Capacity:</span>${tour.maxCapacity}</div>
        <div class="row"><span class="label">Start Date:</span>${tour.startDate}</div>
        <div class="row"><span class="label">End Date:</span>${tour.endDate}</div>
        <div class="row"><span class="label">Description:</span>${tour.description}</div>
        <div class="row"><span class="label">Image URL:</span>${tour.imageUrl}</div>

        <h2>Schedules</h2>
        <table>
            <thead>
                <tr>
                    <th>Day</th>
                    <th>Activity</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="schedule" items="${schedules}">
                    <tr>
                        <td>${schedule.dayNumber}</td>
                        <td>${schedule.activityDescription}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <a href="<c:url value='/tour/list'/>">Back</a>
    </div>
</body>
</html>
