<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <title>Quản lý tài khoản | VoyagerElite Admin</title>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .glass-card { background: white; border: 1px solid #e5e7eb; }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
    <%@ include file="../layout/sidebar.jsp" %>

    <main class="flex-1 ml-[280px] p-8">
        <div class="mb-8 flex justify-between items-center">
            <div>
                <h2 class="text-3xl font-bold text-[#05285D]">Quản lý Tài khoản</h2>
                <p class="text-gray-500 text-sm mt-1">Danh sách người dùng và phân quyền hệ thống</p>
            </div>
        </div>

        <c:if test="${param.error == 'cannot_delete_admin'}">
            <div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-700 rounded-xl flex items-center gap-2">
                <span class="material-symbols-outlined">error</span>
                <span class="font-medium">Lỗi bảo mật: Không thể xóa tài khoản Quản trị viên (ADMIN)!</span>
            </div>
        </c:if>

        <div class="glass-card rounded-xl shadow-sm overflow-hidden bg-white">
            <div class="p-6 border-b border-gray-100 flex justify-between items-center">
                <h3 class="font-bold text-gray-800 text-lg">Danh sách người dùng</h3>
            </div>
            
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-gray-50 border-b border-gray-100 text-gray-500 text-xs font-semibold uppercase">
                            <th class="py-4 px-6">Họ và Tên</th>
                            <th class="py-4 px-6">Email</th>
                            <th class="py-4 px-6">Số điện thoại</th>
                            <th class="py-4 px-6">Vai trò</th>
                            <th class="py-4 px-6">Trạng thái</th>
                            <th class="py-4 px-6 text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 text-sm text-gray-700">
                        <c:forEach var="u" items="${users}">
                            <tr class="hover:bg-gray-50/50 transition-colors">
                                <td class="py-4 px-6 font-semibold text-gray-900">${u.fullName}</td>
                                <td class="py-4 px-6">${u.email}</td>
                                <td class="py-4 px-6">${empty u.phone ? 'N/A' : u.phone}</td>
                                <td class="py-4 px-6">
                                    <c:choose>
                                        <c:when test="${u.roleId == 1}"><span class="px-2 py-1 bg-red-100 text-red-700 text-xs font-bold rounded">ADMIN</span></c:when>
                                        <c:when test="${u.roleId == 3}"><span class="px-2 py-1 bg-indigo-100 text-indigo-700 text-xs font-bold rounded">STAFF</span></c:when>
                                        <c:when test="${u.roleId == 4}"><span class="px-2 py-1 bg-purple-100 text-purple-700 text-xs font-bold rounded">MANAGER</span></c:when>
                                        <c:otherwise><span class="px-2 py-1 bg-gray-100 text-gray-600 text-xs font-bold rounded">CUSTOMER</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-4 px-6">
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <span class="inline-flex items-center gap-1 text-green-700 bg-green-50 px-2 py-1 rounded-full text-xs font-semibold">
                                                ● Đang hoạt động
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1 text-red-700 bg-red-50 px-2 py-1 rounded-full text-xs font-semibold">
                                                ● Đang khóa
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-4 px-6 text-center">
                                    <div class="flex items-center justify-center gap-3">
                                        <a href="${pageContext.request.contextPath}/admin/user/edit?id=${u.userId}"
                                           class="text-[#0194F3] hover:text-[#0074c2] font-semibold transition-colors flex items-center gap-1">
                                            <span class="material-symbols-outlined text-base">edit</span> Sửa
                                        </a>
                                        <c:choose>
                                            <c:when test="${u.roleId == 1}">
                                                <span class="text-gray-300 flex items-center gap-1 cursor-not-allowed" title="Không thể xóa tài khoản Admin">
                                                    <span class="material-symbols-outlined text-base">block</span> Xóa
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/admin/user/delete?id=${u.userId}"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản này?')"
                                                   class="text-red-600 hover:text-red-700 font-semibold transition-colors flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-base">delete</span> Xóa
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
</body>
</html>
