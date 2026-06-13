<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản lý Đặt chỗ - Admin | VoyagerElite</title>

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
        .badge-pending    { background: #FEF3C7; color: #92400E; }
        .badge-confirmed  { background: #D1FAE5; color: #065F46; }
        .badge-cancelled  { background: #FEE2E2; color: #991B1B; }
        .badge-completed  { background: #DBEAFE; color: #1E40AF; }
        .btn-action { display: inline-flex; align-items: center; gap: 4px; padding: 5px 10px;
                      border-radius: 8px; font-size: 12px; font-weight: 500; transition: all .15s; text-decoration: none; border: none; cursor: pointer; }
        .btn-view   { background: #E0F2FE; color: #0369A1; }
        .btn-view:hover   { background: #BAE6FD; }
        .btn-confirm { background: #D1FAE5; color: #065F46; }
        .btn-confirm:hover { filter: brightness(0.92); }
        .btn-complete { background: #0194F3; color: #fff; }
        .btn-complete:hover { filter: brightness(1.1); }
        .btn-cancel { background: #FF5E1F; color: #fff; }
        .btn-cancel:hover { filter: brightness(1.1); }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
    <%@ include file="../layout/sidebar.jsp" %>

    <main class="flex-1 ml-[280px] p-8 min-h-screen">

        <!-- ══ Header ════════════════════════════════════════════════════════ -->
        <div class="flex justify-between items-center mb-6">
            <div>
                <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-1">
                    <span class="material-symbols-outlined text-[14px]">home</span>
                    <span class="text-ocean-blue font-semibold">Quản lý Đặt chỗ</span>
                </nav>
                <h2 class="text-3xl font-bold text-deep-navy">Danh sách Đặt chỗ</h2>
            </div>
            <a href="<c:url value='/booking/create'/>"
               class="flex items-center gap-2 px-5 py-2.5 rounded-lg bg-action-orange text-white font-medium shadow hover:brightness-110 transition-all">
                <span class="material-symbols-outlined text-base">add_circle</span>
                Đặt tour thủ công
            </a>
        </div>

        <!-- ══ Thẻ thống kê tổng quan ════════════════════════════════════════ -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
            <div class="bg-white rounded-xl p-5 glass-card flex flex-col gap-1">
                <span class="material-symbols-outlined text-ocean-blue text-3xl">shopping_cart</span>
                <p class="text-xs font-semibold text-on-surface-variant uppercase tracking-wider">Tổng đơn hàng</p>
                <p class="text-2xl font-bold text-deep-navy">${empty bookings ? 0 : bookings.size()}</p>
            </div>
            <div class="bg-white rounded-xl p-5 glass-card flex flex-col gap-1">
                <span class="material-symbols-outlined text-status-warning text-3xl">pending_actions</span>
                <p class="text-xs font-semibold text-on-surface-variant uppercase tracking-wider">Chờ xác nhận</p>
                <p class="text-2xl font-bold text-deep-navy">
                    <c:set var="pendingCount" value="0"/>
                    <c:forEach var="b" items="${bookings}">
                        <c:if test="${b.bookingStatus == 'PENDING'}">
                            <c:set var="pendingCount" value="${pendingCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${pendingCount}
                </p>
            </div>
            <div class="bg-white rounded-xl p-5 glass-card flex flex-col gap-1 border-l-4 border-ocean-blue">
                <span class="material-symbols-outlined text-status-success text-3xl">check_circle</span>
                <p class="text-xs font-semibold text-on-surface-variant uppercase tracking-wider">Đã xác nhận</p>
                <p class="text-2xl font-bold text-deep-navy">
                    <c:set var="confirmedCount" value="0"/>
                    <c:forEach var="b" items="${bookings}">
                        <c:if test="${b.bookingStatus == 'CONFIRMED'}">
                            <c:set var="confirmedCount" value="${confirmedCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${confirmedCount}
                </p>
            </div>
            <div class="bg-white rounded-xl p-5 glass-card flex flex-col gap-1">
                <span class="material-symbols-outlined text-red-500 text-3xl">cancel</span>
                <p class="text-xs font-semibold text-on-surface-variant uppercase tracking-wider">Đã hủy</p>
                <p class="text-2xl font-bold text-deep-navy">
                    <c:set var="cancelledCount" value="0"/>
                    <c:forEach var="b" items="${bookings}">
                        <c:if test="${b.bookingStatus == 'CANCELLED'}">
                            <c:set var="cancelledCount" value="${cancelledCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${cancelledCount}
                </p>
            </div>
        </div>

        <!-- ══ Bảng danh sách booking ═════════════════════════════════════════ -->
        <section class="glass-card rounded-xl shadow-sm overflow-hidden">

            <!-- Thanh tìm kiếm & lọc -->
            <div class="p-5 border-b border-gray-100 flex flex-wrap items-center gap-3">
                <div class="relative flex-1 min-w-[260px]">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-base">search</span>
                    <input id="searchInput" type="text" placeholder="Tìm kiếm theo tên khách hàng, tour..."
                           onkeyup="filterTable()"
                           class="w-full pl-10 pr-4 py-2 rounded-lg bg-surface-gray border-none text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue"/>
                </div>
                <select id="statusFilter" onchange="filterTable()"
                        class="px-4 py-2 rounded-lg bg-surface-gray border-none text-sm text-on-surface-variant focus:outline-none focus:ring-2 focus:ring-ocean-blue">
                    <option value="">Tất cả trạng thái</option>
                    <option value="PENDING">Chờ xác nhận</option>
                    <option value="CONFIRMED">Đã xác nhận</option>
                    <option value="COMPLETED">Đã hoàn thành</option>
                    <option value="CANCELLED">Đã hủy</option>
                </select>
                <a href="<c:url value='/booking/list'/>"
                   class="flex items-center gap-1 px-4 py-2 rounded-lg border border-outline-variant text-on-surface-variant text-sm hover:bg-surface-container transition-all">
                    <span class="material-symbols-outlined text-base">refresh</span> Làm mới
                </a>
            </div>

            <!-- Bảng dữ liệu -->
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm" id="bookingTable">
                    <thead class="bg-deep-navy text-white text-xs uppercase tracking-wide">
                        <tr>
                            <th class="px-6 py-4">Mã đơn</th>
                            <th class="px-6 py-4">Khách hàng</th>
                            <th class="px-6 py-4">Tour</th>
                            <th class="px-6 py-4">Số khách</th>
                            <th class="px-6 py-4">Tổng tiền</th>
                            <th class="px-6 py-4">Ngày đặt</th>
                            <th class="px-6 py-4 text-center">Trạng thái</th>
                            <th class="px-6 py-4 text-right">Hành động</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100" id="tableBody">
                        <c:if test="${empty bookings}">
                            <tr>
                                <td colspan="8" class="py-16 text-center text-on-surface-variant">
                                    <span class="material-symbols-outlined text-5xl text-outline-variant block mb-3">confirmation_number</span>
                                    <p class="font-semibold">Chưa có đơn đặt chỗ nào.</p>
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach var="booking" items="${bookings}">
                            <tr class="hover:bg-blue-50/40 transition-colors" data-name="${booking.fullName}" data-tour="${booking.tourName}" data-status="${booking.bookingStatus}">

                                <!-- Mã đơn -->
                                <td class="px-6 py-4 font-bold text-ocean-blue">#BK-${booking.bookingId}</td>

                                <!-- Khách hàng -->
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-3">
                                        <div class="w-8 h-8 rounded-full bg-ocean-blue/10 flex items-center justify-center text-ocean-blue font-bold text-xs uppercase">
                                            <c:choose>
                                                <c:when test="${not empty booking.fullName and booking.fullName.length() >= 2}">
                                                    ${booking.fullName.substring(0,1)}
                                                </c:when>
                                                <c:otherwise>?</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <span class="font-semibold text-deep-navy">${booking.fullName}</span>
                                    </div>
                                </td>

                                <!-- Tên Tour -->
                                <td class="px-6 py-4 text-on-surface max-w-[200px]">
                                    <div class="line-clamp-2">${booking.tourName}</div>
                                </td>

                                <!-- Số người -->
                                <td class="px-6 py-4 text-on-surface-variant">${booking.numberOfPeople} người</td>

                                <!-- Tổng tiền -->
                                <td class="px-6 py-4 font-semibold text-action-orange">
                                    <fmt:formatNumber value="${booking.totalPrice}" type="number" groupingUsed="true"/> ₫
                                </td>

                                <!-- Ngày đặt -->
                                <td class="px-6 py-4 text-on-surface-variant">
                                    <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>

                                <!-- Trạng thái -->
                                <td class="px-6 py-4 text-center">
                                    <div class="flex flex-col items-center">
                                        <c:choose>
                                            <c:when test="${booking.bookingStatus == 'PENDING'}">
                                                <span class="px-3 py-1 rounded-full badge-pending text-xs font-bold inline-flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-[13px]">schedule</span> Chờ xác nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${booking.bookingStatus == 'CONFIRMED'}">
                                                <span class="px-3 py-1 rounded-full badge-confirmed text-xs font-bold inline-flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-[13px]">check_circle</span> Đã xác nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${booking.bookingStatus == 'COMPLETED'}">
                                                <span class="px-3 py-1 rounded-full badge-completed text-xs font-bold inline-flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-[13px]">task_alt</span> Hoàn thành
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 rounded-full badge-cancelled text-xs font-bold inline-flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-[13px]">cancel</span> Đã hủy
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${booking.paymentStatus == 'PAID'}">
                                                <span class="text-[10px] text-green-600 font-semibold mt-1 flex items-center gap-0.5">
                                                    <span class="material-symbols-outlined text-[10px]">check</span> Đã thanh toán
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-[10px] text-red-500 font-semibold mt-1 flex items-center gap-0.5">
                                                    <span class="material-symbols-outlined text-[10px]">warning</span> Chưa thanh toán
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>

                                <!-- Hành động -->
                                <td class="px-6 py-4">
                                    <div class="flex justify-end items-center gap-1.5 flex-wrap">
                                        <!-- Xem chi tiết -->
                                        <a class="btn-action btn-view"
                                           href="<c:url value='/booking/detail/${booking.bookingId}'/>"
                                           title="Xem chi tiết">
                                            <span class="material-symbols-outlined text-[15px]">visibility</span>
                                        </a>

                                         <!-- Xác nhận (chỉ khi PENDING) -->
                                         <c:if test="${booking.bookingStatus == 'PENDING'}">
                                             <c:choose>
                                                 <c:when test="${booking.paymentStatus == 'PAID'}">
                                                     <button class="btn-action btn-confirm"
                                                             onclick="showStatusModal(${booking.bookingId}, 'CONFIRMED', '#BK-${booking.bookingId}')"
                                                             title="Xác nhận đặt chỗ">
                                                         <span class="material-symbols-outlined text-[15px]">check_circle</span>
                                                     </button>
                                                 </c:when>
                                                 <c:otherwise>
                                                     <button class="btn-action bg-gray-200 text-gray-400 opacity-40 cursor-not-allowed"
                                                             disabled
                                                             title="Yêu cầu thanh toán thành công (PAID) trước khi xác nhận">
                                                         <span class="material-symbols-outlined text-[15px]">lock</span>
                                                     </button>
                                                 </c:otherwise>
                                             </c:choose>
                                         </c:if>

                                        <!-- Hoàn thành (chỉ khi CONFIRMED) -->
                                        <c:if test="${booking.bookingStatus == 'CONFIRMED'}">
                                            <a class="btn-action btn-complete"
                                               href="<c:url value='/booking/complete/${booking.bookingId}'/>"
                                               title="Đánh dấu hoàn thành">
                                                <span class="material-symbols-outlined text-[15px]">task_alt</span>
                                            </a>
                                        </c:if>

                                        <!-- Hủy (khi PENDING hoặc CONFIRMED) -->
                                        <c:if test="${booking.bookingStatus == 'PENDING' or booking.bookingStatus == 'CONFIRMED'}">
                                            <button class="btn-action btn-cancel"
                                                    onclick="showCancelModal(${booking.bookingId}, '#BK-${booking.bookingId}')"
                                                    title="Hủy đặt chỗ">
                                                <span class="material-symbols-outlined text-[15px]">cancel</span>
                                            </button>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Footer bảng -->
            <div class="p-4 border-t border-gray-100 flex flex-wrap items-center justify-between gap-3">
                <span class="text-sm text-on-surface-variant">
                    Tổng cộng <strong class="text-deep-navy">${empty bookings ? 0 : bookings.size()}</strong> đơn đặt chỗ
                </span>
                <!-- Chú thích luồng trạng thái -->
                <div class="flex items-center gap-2 text-xs text-on-surface-variant flex-wrap">
                    <span class="font-semibold">Luồng trạng thái:</span>
                    <span class="px-2 py-0.5 rounded-full bg-yellow-100 text-yellow-800 font-medium">Chờ xác nhận</span>
                    <span class="material-symbols-outlined text-[14px]">arrow_forward</span>
                    <span class="px-2 py-0.5 rounded-full bg-green-100 text-green-800 font-medium">Đã xác nhận</span>
                    <span class="text-on-surface-variant text-[10px]">(khách đã TT + admin xác nhận)</span>
                    <span class="material-symbols-outlined text-[14px]">arrow_forward</span>
                    <span class="px-2 py-0.5 rounded-full bg-blue-100 text-blue-800 font-medium">Hoàn thành</span>
                    <span class="text-on-surface-variant text-[10px]">(tour đã kết thúc)</span>
                </div>
            </div>
        </section>

    </main>
</div>

<!-- ══ Modal xác nhận hủy ════════════════════════════════════════════════════ -->
<div class="fixed inset-0 bg-black/50 z-[100] hidden items-center justify-center backdrop-blur-sm" id="cancelModal">
    <div class="bg-white rounded-xl max-w-md w-full p-8 shadow-2xl">
        <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-5">
            <span class="material-symbols-outlined text-red-600 text-4xl">warning</span>
        </div>
        <h3 class="font-bold text-xl text-deep-navy text-center mb-2">Xác nhận hủy đặt chỗ</h3>
        <p class="text-center text-on-surface-variant text-sm mb-6">
            Bạn có chắc muốn hủy đơn <span class="font-bold text-deep-navy" id="cancelBookingCode"></span>?
            Hành động này không thể hoàn tác.
        </p>
        <div class="grid grid-cols-2 gap-4">
            <button onclick="hideCancelModal()"
                    class="px-5 py-3 rounded-lg border border-outline-variant text-on-surface font-semibold text-sm hover:bg-surface-gray transition-colors">
                Huỷ bỏ
            </button>
            <a id="cancelConfirmLink" href="#"
               class="px-5 py-3 rounded-lg bg-red-600 text-white font-semibold text-sm text-center hover:bg-red-700 transition-colors">
                Xác nhận hủy
            </a>
        </div>
    </div>
</div>

<!-- ══ Modal đổi trạng thái (xác nhận booking) ══════════════════════════════ -->
<div class="fixed inset-0 bg-black/50 z-[100] hidden items-center justify-center backdrop-blur-sm" id="statusModal">
    <div class="bg-white rounded-xl max-w-md w-full p-8 shadow-2xl">
        <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-5">
            <span class="material-symbols-outlined text-green-600 text-4xl">check_circle</span>
        </div>
        <h3 class="font-bold text-xl text-deep-navy text-center mb-2">Xác nhận đặt chỗ</h3>
        <p class="text-center text-on-surface-variant text-sm mb-6">
            Xác nhận đơn <span class="font-bold text-deep-navy" id="statusBookingCode"></span>?<br/>
            <span class="text-xs text-on-surface-variant mt-1 block">Đảm bảo khách hàng đã thanh toán trước khi xác nhận.</span>
        </p>
        <div class="grid grid-cols-2 gap-4">
            <button onclick="hideStatusModal()"
                    class="px-5 py-3 rounded-lg border border-outline-variant text-on-surface font-semibold text-sm hover:bg-surface-gray transition-colors">
                Huỷ bỏ
            </button>
            <a id="statusConfirmLink" href="#"
               class="px-5 py-3 rounded-lg bg-green-600 text-white font-semibold text-sm text-center hover:bg-green-700 transition-colors">
                Xác nhận
            </a>
        </div>
    </div>
</div>

<script>
    const cancelModal = document.getElementById('cancelModal');
    const statusModal = document.getElementById('statusModal');

    // Modal hủy booking
    function showCancelModal(id, code) {
        document.getElementById('cancelBookingCode').innerText = code;
        document.getElementById('cancelConfirmLink').href = '<c:url value="/booking/cancel/"/>'+id;
        cancelModal.classList.remove('hidden');
        cancelModal.classList.add('flex');
    }
    function hideCancelModal() {
        cancelModal.classList.add('hidden');
        cancelModal.classList.remove('flex');
    }

    // Modal xác nhận booking (PENDING → CONFIRMED)
    // Trỏ đúng tới /booking/confirm/ thay vì /booking/complete/
    function showStatusModal(id, status, code) {
        document.getElementById('statusBookingCode').innerText = code;
        document.getElementById('statusConfirmLink').href = '<c:url value="/booking/confirm/"/>'+id;
        statusModal.classList.remove('hidden');
        statusModal.classList.add('flex');
    }
    function hideStatusModal() {
        statusModal.classList.add('hidden');
        statusModal.classList.remove('flex');
    }

    // Đóng modal khi nhấn Escape
    window.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') { hideCancelModal(); hideStatusModal(); }
    });

    // Lọc bảng phía client-side
    function filterTable() {
        const keyword = document.getElementById('searchInput').value.toLowerCase();
        const status  = document.getElementById('statusFilter').value;
        const rows = document.querySelectorAll('#tableBody tr[data-status]');
        rows.forEach(row => {
            const name  = (row.dataset.name  || '').toLowerCase();
            const tour  = (row.dataset.tour  || '').toLowerCase();
            const rowSt = (row.dataset.status || '');
            const matchKeyword = name.includes(keyword) || tour.includes(keyword);
            const matchStatus  = !status || rowSt === status;
            row.style.display = (matchKeyword && matchStatus) ? '' : 'none';
        });
    }
</script>
</body>
</html>
