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
    <title>Chỉnh sửa Voucher | VoyagerElite Admin</title>
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
                <a class="hover:text-[#0194F3]" href="${pageContext.request.contextPath}/admin/voucher/list">Quản lý Voucher</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-[#0194F3] font-semibold">Chỉnh sửa</span>
            </nav>
            <h2 class="text-3xl font-bold text-[#05285D]">Chỉnh sửa Voucher</h2>
        </div>

        <div class="max-w-2xl bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
            <div class="p-6 bg-gray-50 border-b border-gray-100 flex items-center gap-2 text-[#0194F3]">
                <span class="material-symbols-outlined">edit_note</span>
                <h3 class="font-bold text-gray-800 text-lg">Cập nhật thông tin khuyến mại</h3>
            </div>
            
            <form action="${pageContext.request.contextPath}/admin/voucher/edit" method="POST" class="p-8 space-y-6">
                <input type="hidden" name="voucherId" value="${voucher.voucherId}"/>

                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Mã Code Voucher</label>
                        <input type="text" name="code" value="${voucher.code}" required
                               class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] uppercase font-mono tracking-wider bg-gray-50/50" />
                    </div>
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Tỉ lệ giảm giá (%)</label>
                        <input type="number" name="discountPercentage" value="${voucher.discountPercentage}" min="1" max="100" step="0.1" required
                               class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Số tiền giảm tối đa (VNĐ)</label>
                        <input type="number" name="maxDiscountAmount" value="${voucher.maxDiscountAmount}"
                               class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                    </div>
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Giá trị đơn tối thiểu (VNĐ)</label>
                        <input type="number" name="minOrderAmount" value="${voucher.minOrderAmount}" required
                               class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Ngày bắt đầu áp dụng</label>
                        <input type="date" name="startDate" value="${voucher.startDate}" required
                               class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                    </div>
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Ngày kết thúc thời hạn</label>
                        <input type="date" name="endDate" value="${voucher.endDate}" required
                               class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Giới hạn số lượng dùng</label>
                        <input type="number" name="usageLimit" value="${voucher.usageLimit}" required min="1"
                               class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-gray-50/50" />
                    </div>
                    <div>
                        <label class="block font-semibold text-gray-700 mb-2">Trạng thái hoạt động</label>
                        <select name="status" class="w-full h-12 px-4 border rounded-xl outline-none focus:border-[#0194F3] bg-white">
                            <option value="ACTIVE" ${voucher.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE (Kích hoạt)</option>
                            <option value="INACTIVE" ${voucher.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE (Vô hiệu hóa)</option>
                        </select>
                    </div>
                </div>

                <div class="pt-6 border-t border-gray-100 flex justify-end gap-4">
                    <a href="${pageContext.request.contextPath}/admin/voucher/list"
                       class="px-6 py-3 border rounded-xl text-gray-600 hover:bg-gray-50 transition-all font-semibold">
                        Hủy bỏ
                    </a>
                    <button type="submit"
                            class="px-8 py-3 bg-[#0194F3] hover:bg-[#0081d5] text-white rounded-xl shadow-md transition-all font-semibold">
                        Cập nhật Voucher
                    </button>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>
