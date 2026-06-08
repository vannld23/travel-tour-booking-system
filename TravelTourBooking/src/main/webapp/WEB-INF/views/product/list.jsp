<%-- 
    Document   : list
    Created on : Jun 7, 2026, 9:26:45 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Product List</h2>

<a class="btn"
href="${pageContext.request.contextPath}/products/add">
Add Product </a>

<br><br>

<table>

<tr>
    <th>ID</th>
    <th>Product Name</th>
    <th>Price</th>
    <th>Action</th>
</tr>

<c:forEach var="p" items="${products}">

    <tr>

        <td>${p.id}</td>

        <td>${p.name}</td>

        <td>${p.price}</td>

        <td>

            <a href="${pageContext.request.contextPath}/products/edit/${p.id}">
                Edit
            </a>

            |

            <a href="${pageContext.request.contextPath}/products/delete/${p.id}">
                Delete
            </a>

        </td>

    </tr>

</c:forEach>

</table>
