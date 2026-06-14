<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản lý Thanh toán - Admin | VoyagerElite</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "ocean-blue":         "#0194F3",
                        "deep-navy":          "#05285D",
                        "surface-gray":       "#F2F3F3",
                        "surface-bright":     "#f8f9f9",
                        "surface-container":  "#edeeee",
                        "outline-variant":    "#bfc7d4",
                        "on-surface":         "#191c1c",
                        "on-surface-variant": "#3f4752",
                        "action-orange":      "#FF5E1F",
                        "status-success":     "#00BA4A",
                        "status-warning":     "#F39C12"
                    }
                }
            }
        };
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .glass-card { background: rgba(255,255,255,0.95); backdrop-filter: blur(8px); border: 1px solid rgba(224,224,224,0.5); }
        .card-hover:hover { box-shadow: 0px 8px 24px rgba(0, 0, 0, 0.08); transform: scale(1.02); transition: all 0.2s ease-in-out; }
    </style>
</head>
<body class="bg-surface-gray min-h-screen text-on-surface">
<div class="flex min-h-screen">
    <%@ include file="../layout/sidebar.jsp" %>

    <!-- Main Content Canvas -->
    <main class="ml-[280px] flex-1 p-8 min-h-screen">
        <!-- Header -->
        <header class="mb-8 flex justify-between items-end">
            <div>
                <nav class="flex text-xs text-on-surface-variant gap-2 mb-1">
                    <span class="material-symbols-outlined text-[14px]">home</span>
                    <span>Admin</span>
                    <span>/</span>
                    <span class="text-ocean-blue font-semibold">Thanh toán</span>
                </nav>
                <h2 class="text-3xl font-bold text-deep-navy">Quản lý Thanh toán - Admin</h2>
            </div>
            <div class="flex gap-4">
                <a href="<c:url value='/payment/add'/>" 
                   class="flex items-center gap-2 px-5 py-2.5 rounded-lg bg-action-orange text-white font-medium shadow hover:brightness-110 transition-all">
                    <span class="material-symbols-outlined text-base">add_circle</span>
                    Tạo thanh toán mới
                </a>
            </div>
        </header>

        <!-- Financial Overview Cards -->
        <section class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <!-- Doanh thu tháng -->
            <div class="bg-white p-6 rounded-xl shadow-sm border-l-4 border-ocean-blue glass-card card-hover">
                <div class="flex justify-between items-start mb-4">
                    <div class="p-2 bg-ocean-blue/10 rounded-lg">
                        <span class="material-symbols-outlined text-ocean-blue">payments</span>
                    </div>
                </div>
                <p class="text-on-surface-variant text-sm font-semibold mb-1">Doanh thu tháng này</p>
                <h3 class="text-2xl font-bold text-deep-navy">
                    <c:set var="totalRevenue" value="0"/>
                    <c:forEach var="p" items="${payments}">
                        <c:if test="${p.paymentStatus == 'PAID'}">
                            <c:set var="totalRevenue" value="${totalRevenue + p.amount}"/>
                        </c:if>
                    </c:forEach>
                    <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>₫
                </h3>
            </div>
            <!-- Đơn đã thanh toán -->
            <div class="bg-white p-6 rounded-xl shadow-sm border-l-4 border-status-success glass-card card-hover">
                <div class="flex justify-between items-start mb-4">
                    <div class="p-2 bg-status-success/10 rounded-lg">
                        <span class="material-symbols-outlined text-status-success">check_circle</span>
                    </div>
                </div>
                <p class="text-on-surface-variant text-sm font-semibold mb-1">Đơn đã thanh toán</p>
                <h3 class="text-2xl font-bold text-deep-navy">
                    <c:set var="paidCount" value="0"/>
                    <c:forEach var="p" items="${payments}">
                        <c:if test="${p.paymentStatus == 'PAID'}">
                            <c:set var="paidCount" value="${paidCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${paidCount}
                </h3>
            </div>
            <!-- Đơn đang xử lý -->
            <div class="bg-white p-6 rounded-xl shadow-sm border-l-4 border-status-warning glass-card card-hover">
                <div class="flex justify-between items-start mb-4">
                    <div class="p-2 bg-status-warning/10 rounded-lg">
                        <span class="material-symbols-outlined text-status-warning">hourglass_empty</span>
                    </div>
                </div>
                <p class="text-on-surface-variant text-sm font-semibold mb-1">Đơn đang xử lý</p>
                <h3 class="text-2xl font-bold text-deep-navy">
                    <c:set var="pendingCount" value="0"/>
                    <c:forEach var="p" items="${payments}">
                        <c:if test="${p.paymentStatus == 'PENDING'}">
                            <c:set var="pendingCount" value="${pendingCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${pendingCount}
                </h3>
            </div>
        </section>

        <!-- Filters Section -->
        <section class="bg-white p-5 rounded-xl shadow-sm mb-6 glass-card">
            <div class="flex flex-wrap items-center gap-4">
                <div class="flex-1 min-w-[240px] relative">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-base">search</span>
                    <input id="searchInput" onkeyup="filterTable()" class="w-full pl-10 pr-4 py-2 bg-surface-gray border-none rounded-lg focus:ring-2 focus:ring-ocean-blue text-sm" placeholder="Tìm kiếm mã giao dịch, khách hàng..." type="text"/>
                </div>
                <div class="flex items-center gap-3">
                    <label class="text-sm text-on-surface-variant font-semibold">Phương thức:</label>
                    <select id="methodFilter" onchange="filterTable()" class="bg-surface-gray border-none rounded-lg px-4 py-2 text-sm text-on-surface-variant focus:ring-2 focus:ring-ocean-blue">
                        <option value="">Tất cả</option>
                        <option value="VISA">Thẻ Visa</option>
                        <option value="BANK_TRANSFER">Chuyển khoản</option>
                        <option value="MOMO">Ví MoMo</option>
                    </select>
                </div>
                <div class="flex items-center gap-3">
                    <label class="text-sm text-on-surface-variant font-semibold">Trạng thái:</label>
                    <select id="statusFilter" onchange="filterTable()" class="bg-surface-gray border-none rounded-lg px-4 py-2 text-sm text-on-surface-variant focus:ring-2 focus:ring-ocean-blue">
                        <option value="">Tất cả</option>
                        <option value="PAID">Thành công</option>
                        <option value="PENDING">Đang xử lý</option>
                        <option value="FAILED">Thất bại</option>
                    </select>
                </div>
                <a href="<c:url value='/payment/list'/>" class="bg-deep-navy text-white px-6 py-2 rounded-lg font-semibold text-sm hover:opacity-90 transition-opacity">
                    Làm mới
                </a>
            </div>
        </section>

        <!-- Transaction History Table -->
        <section class="bg-white rounded-xl shadow-sm overflow-hidden glass-card">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse text-sm" id="paymentTable">
                    <thead class="bg-deep-navy text-white text-xs uppercase tracking-wide">
                        <tr>
                            <th class="px-6 py-4 font-semibold">Mã giao dịch</th>
                            <th class="px-6 py-4 font-semibold">Mã đơn hàng</th>
                            <th class="px-6 py-4 font-semibold">Khách hàng</th>
                            <th class="px-6 py-4 font-semibold">Phương thức</th>
                            <th class="px-6 py-4 font-semibold">Số tiền</th>
                            <th class="px-6 py-4 font-semibold">Ngày thanh toán</th>
                            <th class="px-6 py-4 font-semibold text-center">Trạng thái</th>
                            <th class="px-6 py-4 text-right">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100" id="tableBody">
                        <c:if test="${empty payments}">
                            <tr>
                                <td colspan="8" class="py-16 text-center text-on-surface-variant">
                                    <span class="material-symbols-outlined text-5xl text-outline-variant block mb-3">payments</span>
                                    <p class="font-semibold">Chưa có giao dịch thanh toán nào.</p>
                                </td>
                            </tr>
                        </c:if>
                        <c:forEach var="p" items="${payments}">
                            <tr class="hover:bg-blue-50/40 transition-colors" data-name="${p.fullName}" data-id="#TXN-${p.paymentId}" data-method="${p.paymentMethod}" data-status="${p.paymentStatus}">
                                <td class="px-6 py-4 font-bold text-ocean-blue">#TXN-${p.paymentId}</td>
                                <td class="px-6 py-4 font-semibold text-deep-navy">#BK-${p.bookingId}</td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-3">
                                        <div class="w-8 h-8 rounded-full bg-ocean-blue/10 flex items-center justify-center text-ocean-blue font-bold text-xs uppercase">
                                            <c:choose>
                                                <c:when test="${not empty p.fullName and p.fullName.length() >= 2}">
                                                    ${p.fullName.substring(0,1)}
                                                </c:when>
                                                <c:otherwise>?</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <span class="font-semibold text-deep-navy">${p.fullName}</span>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-2">
                                        <c:choose>
                                            <c:when test="${p.paymentMethod == 'CASH'}">
                                                <span class="material-symbols-outlined text-[#1A1F71] text-base">credit_card</span>
                                                <span class="font-medium">Thẻ Visa</span>
                                            </c:when>
                                            <c:when test="${p.paymentMethod == 'MOMO'}">
                                                <span class="material-symbols-outlined text-[#A50064] text-base">account_balance_wallet</span>
                                                <span class="font-medium">Ví MoMo</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="material-symbols-outlined text-ocean-blue text-base">account_balance</span>
                                                <span class="font-medium">Chuyển khoản</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td class="px-6 py-4 font-semibold text-action-orange">
                                    <fmt:formatNumber value="${p.amount}" type="number" groupingUsed="true"/>₫
                                </td>
                                <td class="px-6 py-4 text-on-surface-variant">
                                    <fmt:formatDate value="${p.paymentDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <c:choose>
                                        <c:when test="${p.paymentStatus == 'PAID'}">
                                            <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-green-100 text-green-800 text-xs font-bold">
                                                <span class="w-1.5 h-1.5 rounded-full bg-green-600"></span> Thành công
                                            </span>
                                        </c:when>
                                        <c:when test="${p.paymentStatus == 'PENDING'}">
                                            <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-yellow-100 text-yellow-800 text-xs font-bold">
                                                <span class="w-1.5 h-1.5 rounded-full bg-yellow-600"></span> Đang xử lý
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-red-100 text-red-800 text-xs font-bold">
                                                <span class="w-1.5 h-1.5 rounded-full bg-red-600"></span> Thất bại
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <div class="flex justify-end gap-2">
                                        <a href="<c:url value='/payment/detail/${p.paymentId}'/>" class="p-2 text-on-surface-variant hover:text-ocean-blue transition-colors" title="Xem chi tiết">
                                            <span class="material-symbols-outlined text-base">visibility</span>
                                        </a>
                                        <c:if test="${p.paymentStatus == 'PENDING'}">
                                            <a href="<c:url value='/payment/confirm/${p.paymentId}'/>" class="p-2 text-status-success hover:scale-110 transition-transform" title="Xác nhận thanh toán">
                                                <span class="material-symbols-outlined text-base">check_circle</span>
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- Pagination info -->
            <div class="px-6 py-4 bg-gray-50 flex items-center justify-between border-t border-gray-100 text-xs text-on-surface-variant">
                <span>Tổng cộng <strong>${empty payments ? 0 : payments.size()}</strong> giao dịch thanh toán</span>
            </div>
        </section>
    </main>
</div>

<script>
    function filterTable() {
        const keyword = document.getElementById('searchInput').value.toLowerCase();
        const method = document.getElementById('methodFilter').value;
        const status = document.getElementById('statusFilter').value;
        const rows = document.querySelectorAll('#tableBody tr[data-status]');
        
        rows.forEach(row => {
            const name = (row.dataset.name || '').toLowerCase();
            const id = (row.dataset.id || '').toLowerCase();
            const rowMethod = row.dataset.method || '';
            const rowStatus = row.dataset.status || '';
            
            const matchKeyword = name.includes(keyword) || id.includes(keyword);
            const matchMethod = !method || rowMethod.includes(method);
            const matchStatus = !status || rowStatus === status;
            
            if (matchKeyword && matchMethod && matchStatus) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }
</script>
</body>
</html>
