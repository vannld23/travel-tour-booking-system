<%-- 
    Document   : list
    Created on : Jun 7, 2026, 9:24:25 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Customer List</h2>

<a class="btn"
   href="${pageContext.request.contextPath}/customers/add">
    Add Customer
</a>

<br><br>

<table>

    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Action</th>
    </tr>

    <c:forEach var="c" items="${customers}">

        <tr>

            <td>${c.id}</td>

            <td>${c.name}</td>

            <td>${c.email}</td>

            <td>

                <a href="${pageContext.request.contextPath}/customers/edit/${c.id}">
                    Edit
                </a>

                |

                <a href="${pageContext.request.contextPath}/customers/delete/${c.id}">
                    Delete
                </a>

            </td>

        </tr>

    </c:forEach>

</table>