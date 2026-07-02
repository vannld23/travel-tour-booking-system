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
    <title>Quản lý Voucher | VoyagerElite Admin</title>
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
                <h2 class="text-3xl font-bold text-[#05285D]">Quản lý Voucher</h2>
                <p class="text-gray-500 text-sm mt-1">Quản lý mã giảm giá và chương trình khuyến mãi đặt tour</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/voucher/create"
               class="flex items-center gap-2 px-5 py-3 bg-[#0194F3] hover:bg-[#0081d5] text-white font-semibold rounded-xl shadow-md transition-all">
                <span class="material-symbols-outlined text-lg">add_circle</span>
                Tạo Voucher Mới
            </a>
        </div>

        <div class="glass-card rounded-xl shadow-sm overflow-hidden bg-white">
            <div class="p-6 border-b border-gray-100 flex justify-between items-center">
                <h3 class="font-bold text-gray-800 text-lg">Danh sách Voucher</h3>
            </div>
            
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-gray-50 border-b border-gray-100 text-gray-500 text-xs font-semibold uppercase">
                            <th class="py-4 px-6">Mã Code</th>
                            <th class="py-4 px-6">Giảm Giá</th>
                            <th class="py-4 px-6">Giảm Tối Đa</th>
                            <th class="py-4 px-6">Đơn Hàng Tối Thiểu</th>
                            <th class="py-4 px-6">Thời Hạn</th>
                            <th class="py-4 px-6">Lượt Dùng</th>
                            <th class="py-4 px-6">Trạng thái</th>
                            <th class="py-4 px-6 text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 text-sm text-gray-700">
                        <c:choose>
                            <c:when test="${not empty vouchers}">
                                <c:forEach var="v" items="${vouchers}">
                                    <tr class="hover:bg-gray-50/50 transition-colors">
                                        <td class="py-4 px-6 font-mono font-bold text-gray-900 tracking-wider">
                                            <span class="px-2 py-1 bg-yellow-100 text-yellow-800 rounded text-xs border border-yellow-200">${v.code}</span>
                                        </td>
                                        <td class="py-4 px-6 text-emerald-600 font-semibold">Giảm ${v.discountPercentage}%</td>
                                        <td class="py-4 px-6">
                                            <c:choose>
                                                <c:when test="${empty v.maxDiscountAmount || v.maxDiscountAmount == 0}">
                                                    Không giới hạn
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:formatNumber value="${v.maxDiscountAmount}" type="currency" currencySymbol="₫"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="py-4 px-6">
                                            <fmt:formatNumber value="${v.minOrderAmount}" type="currency" currencySymbol="₫"/>
                                        </td>
                                        <td class="py-4 px-6 text-xs text-gray-500">
                                            Từ: <fmt:formatDate value="${v.startDate}" pattern="dd/MM/yyyy"/><br/>
                                            Đến: <fmt:formatDate value="${v.endDate}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td class="py-4 px-6 font-medium">${v.usedCount} / ${v.usageLimit}</td>
                                        <td class="py-4 px-6">
                                            <c:choose>
                                                <c:when test="${v.status == 'ACTIVE'}">
                                                    <span class="inline-flex items-center gap-1 text-green-700 bg-green-50 px-2.5 py-1 rounded-full text-xs font-semibold">
                                                        ● Hoạt động
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center gap-1 text-gray-500 bg-gray-100 px-2.5 py-1 rounded-full text-xs font-semibold">
                                                        ● Vô hiệu hóa
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="py-4 px-6 text-center">
                                            <div class="flex items-center justify-center gap-3">
                                                <a href="${pageContext.request.contextPath}/admin/voucher/edit?id=${v.voucherId}"
                                                   class="text-[#0194F3] hover:text-[#0074c2] font-semibold transition-colors flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-base">edit</span> Sửa
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/voucher/delete?id=${v.voucherId}"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa Voucher này?')"
                                                   class="text-red-600 hover:text-red-700 font-semibold transition-colors flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-base">delete</span> Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="text-center py-12 text-gray-400 font-medium">Chưa có mã Voucher nào được tạo.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
</body>
</html>
