<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <title>Chỉnh sửa quyền tài khoản | VoyagerElite Admin</title>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .glass-card { background: white; border: 1px solid #e5e7eb; }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
    <%@ include file="../layout/sidebar.jsp" %>

    <main class="flex-1 ml-[280px] p-8">
        <div class="mb-8">
            <nav class="flex items-center gap-2 text-gray-500 text-sm mb-2">
                <a class="hover:text-[#0194F3]" href="${pageContext.request.contextPath}/admin/user/list">Quản lý Tài khoản</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-[#0194F3] font-semibold">Chỉnh sửa</span>
            </nav>
            <h2 class="text-3xl font-bold text-[#05285D]">Chỉnh sửa Tài khoản</h2>
        </div>

        <div class="max-w-2xl bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
            <div class="p-6 bg-gray-50 border-b border-gray-100 flex items-center gap-2 text-[#0194F3]">
                <span class="material-symbols-outlined">manage_accounts</span>
                <h3 class="font-bold text-gray-800 text-lg">Thông tin phân quyền</h3>
            </div>
            
            <form action="${pageContext.request.contextPath}/admin/user/edit" method="POST" class="p-8 space-y-6">
                <input type="hidden" name="userId" value="${user.userId}"/>

                <div>
                    <label class="block font-semibold text-gray-700 mb-2">Họ và Tên</label>
                    <input type="text" name="fullName" value="${user.fullName}" required
                           class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                </div>

                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Email</label>
                        <input type="email" name="email" value="${user.email}" required
                               class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                    </div>
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Số điện thoại</label>
                        <input type="text" name="phone" value="${user.phone}"
                               class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                    </div>
                </div>

                <div>
                    <label class="block font-semibold text-gray-700 mb-2">Địa chỉ</label>
                    <input type="text" name="address" value="${user.address}"
                           class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                </div>

                <div class="grid grid-cols-2 gap-6 pt-2 border-t border-gray-100">
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Vai trò thành viên</label>
                        <select name="roleId" class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-white">
                            <option value="2" ${user.roleId == 2 ? 'selected' : ''}>CUSTOMER (Khách hàng)</option>
                            <option value="3" ${user.roleId == 3 ? 'selected' : ''}>STAFF (Nhân viên vận hành)</option>
                            <option value="4" ${user.roleId == 4 ? 'selected' : ''}>MANAGER (Quản lý nội dung)</option>
                            <option value="1" ${user.roleId == 1 ? 'selected' : ''}>ADMIN (Quản trị viên tối cao)</option>
                        </select>
                    </div>
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Trạng thái hoạt động</label>
                        <div class="flex items-center h-12 gap-3 pl-1">
                            <input type="checkbox" name="isActive" value="true" id="isActive" ${user.active ? 'checked' : ''}
                                   class="w-5 h-5 text-[#0194F3] border-gray-300 rounded focus:ring-[#0194F3]" />
                            <label for="isActive" class="text-sm font-medium text-gray-600 cursor-pointer">Cho phép tài khoản hoạt động</label>
                        </div>
                    </div>
                </div>

                <div class="pt-6 border-t border-gray-100 flex justify-end gap-4">
                    <a href="${pageContext.request.contextPath}/admin/user/list"
                       class="px-6 py-3 border rounded-xl text-gray-600 hover:bg-gray-50 transition-all font-semibold">
                        Hủy bỏ
                    </a>
                    <button type="submit"
                            class="px-8 py-3 bg-[#0194F3] hover:bg-[#0081d5] text-white rounded-xl shadow-md transition-all font-semibold">
                        Lưu Thay Đổi
                    </button>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>
