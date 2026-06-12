<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Destination List</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/management.css'/>">
</head>
<body>
    <h1>Destination Management</h1>
    <p><a class="primary" href="<c:url value='/destination/create'/>">Create Destination</a></p>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Country</th>
                <th>City</th>
                <th>Description</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="destination" items="${destinations}">
                <tr>
                    <td>${destination.destinationId}</td>
                    <td>${destination.destinationName}</td>
                    <td>${destination.country}</td>
                    <td>${destination.city}</td>
                    <td>${destination.description}</td>
                    <td>${destination.imageUrl}</td>
                    <td class="actions">
                        <a class="secondary" href="<c:url value='/destination/detail'><c:param name='id' value='${destination.destinationId}'/></c:url>">Detail</a>
                        <a class="secondary" href="<c:url value='/destination/edit'><c:param name='id' value='${destination.destinationId}'/></c:url>">Edit</a>
                        <a class="danger" href="<c:url value='/destination/delete'><c:param name='id' value='${destination.destinationId}'/></c:url>">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
