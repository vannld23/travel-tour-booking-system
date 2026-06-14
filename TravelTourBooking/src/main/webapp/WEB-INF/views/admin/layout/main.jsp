<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Khai báo tập trung tại đây --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="flex">
        <%@ include file="sidebar.jsp" %>
        
        <main class="flex-1 ml-[280px] p-6">
            <jsp:include page="../${dynamicContent}" />
        </main>
    </div>
</body>
</html>