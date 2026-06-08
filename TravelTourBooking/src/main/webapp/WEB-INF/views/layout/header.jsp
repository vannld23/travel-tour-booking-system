<%-- 
    Document   : header
    Created on : Jun 7, 2026, 9:22:07 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Spring MVC Order App</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/resources/css/style.css">
    </head>
    <body>

        <header>
            <div class="logo">
                Shopping Management
            </div>

            <nav>
                <a href="${pageContext.request.contextPath}/customers">Customers</a>

                <a href="${pageContext.request.contextPath}/products">Products</a>

                <a href="${pageContext.request.contextPath}/orders">Orders</a>
            </nav>
        </header>

        <div class="container">