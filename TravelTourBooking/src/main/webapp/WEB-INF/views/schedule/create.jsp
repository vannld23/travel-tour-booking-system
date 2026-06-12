<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create Schedule</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/management.css'/>">
</head>
<body>
    <h1>Create Schedule</h1>
    <form:form method="post" modelAttribute="schedule" action="${pageContext.request.contextPath}/schedule/create">
        <label>Tour</label>
        <form:select path="tourId">
            <form:option value="0" label="-- Select tour --" />
            <form:options items="${tours}" itemValue="tourId" itemLabel="tourName" />
        </form:select>
        <form:errors path="tourId" cssClass="error" />

        <label>Day Number</label>
        <form:input path="dayNumber" type="number" />
        <form:errors path="dayNumber" cssClass="error" />

        <label>Activity Description</label>
        <form:textarea path="activityDescription" />
        <form:errors path="activityDescription" cssClass="error" />

        <button class="primary" type="submit">Save</button>
        <a class="secondary" href="<c:url value='/schedule/list'/>">Back</a>
    </form:form>
</body>
</html>
