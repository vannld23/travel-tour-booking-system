<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Chi tiết Đặt chỗ #BK-${booking.bookingId} | VoyagerElite Admin</title>

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
        .info-row { display: flex; padding: 14px 0; border-bottom: 1px solid #f0f0f0; align-items: flex-start; }
        .info-label { width: 200px; flex-shrink: 0; font-size: 13px; font-weight: 600; color: #3f4752; }
        .info-value { font-size: 14px; color: #191c1c; }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
    <%@ include file="../layout/sidebar.jsp" %>

    <main class="flex-1 ml-[280px] p-8 min-h-screen">

        <!-- ══ Breadcrumb & Header ══════════════════════════════════════════ -->
        <div class="mb-6">
            <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-2">
                <span class="material-symbols-outlined text-[14px]">home</span>
                <a href="<c:url value='/booking/list'/>" class="text-ocean-blue hover:underline font-medium">Quản lý Đặt chỗ</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-on-surface font-semibold">Chi tiết #BK-${booking.bookingId}</span>
            </nav>
            <div class="flex justify-between items-center">
                <h2 class="text-3xl font-bold text-deep-navy">Chi tiết Đặt chỗ</h2>
                <a href="<c:url value='/booking/list'/>"
                   class="flex items-center gap-2 px-4 py-2 rounded-lg border border-outline-variant text-on-surface text-sm hover:bg-surface-container transition-all">
                    <span class="material-symbols-outlined text-base">arrow_back</span>
                    Quay lại danh sách
                </a>
            </div>
        </div>

        <c:if test="${empty booking}">
            <div class="glass-card rounded-xl p-16 text-center">
                <span class="material-symbols-outlined text-5xl text-outline-variant block mb-3">search_off</span>
                <p class="text-on-surface-variant font-semibold">Không tìm thấy đơn đặt chỗ.</p>
                <a href="<c:url value='/booking/list'/>" class="mt-4 inline-block text-ocean-blue hover:underline text-sm">
                    ← Quay lại danh sách
                </a>
            </div>
        </c:if>

        <c:if test="${not empty booking}">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

                <!-- ── Cột trái: thông tin đặt chỗ ────────────────────────── -->
                <div class="lg:col-span-2 space-y-6">

                    <!-- Thông tin đặt chỗ -->
                    <section class="glass-card rounded-xl p-6 shadow-sm">
                        <div class="flex items-center gap-3 mb-5 pb-3 border-b border-gray-100">
                            <span class="material-symbols-outlined text-ocean-blue">confirmation_number</span>
                            <h3 class="text-lg font-bold text-on-surface">Thông tin Đặt chỗ</h3>
                            <span class="ml-auto text-xl font-bold text-ocean-blue">#BK-${booking.bookingId}</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Trạng thái</span>
                            <c:choose>
                                <c:when test="${booking.bookingStatus == 'PENDING'}">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full badge-pending text-xs font-bold">
                                        <span class="material-symbols-outlined text-[13px]">schedule</span> Chờ xác nhận
                                    </span>
                                </c:when>
                                <c:when test="${booking.bookingStatus == 'CONFIRMED'}">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full badge-confirmed text-xs font-bold">
                                        <span class="material-symbols-outlined text-[13px]">check_circle</span> Đã xác nhận
                                    </span>
                                </c:when>
                                <c:when test="${booking.bookingStatus == 'COMPLETED'}">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full badge-completed text-xs font-bold">
                                        <span class="material-symbols-outlined text-[13px]">task_alt</span> Hoàn thành
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full badge-cancelled text-xs font-bold">
                                        <span class="material-symbols-outlined text-[13px]">cancel</span> Đã hủy
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Tên khách hàng</span>
                            <span class="info-value font-semibold">${booking.fullName}</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Tour đặt</span>
                            <span class="info-value font-semibold text-ocean-blue">${booking.tourName}</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Số người</span>
                            <span class="info-value">${booking.numberOfPeople} người</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Tổng tiền</span>
                            <span class="info-value font-bold text-action-orange text-lg">
                                <fmt:formatNumber value="${booking.totalPrice}" type="number" groupingUsed="true"/> ₫
                            </span>
                        </div>

                        <div class="info-row" style="border-bottom:none;">
                            <span class="info-label">Ngày đặt</span>
                            <span class="info-value">
                                <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </span>
                        </div>
                    </section>

                </div>

                <!-- ── Cột phải: nút hành động ──────────────────────────── -->
                <div class="space-y-4">

                    <!-- Hành động admin -->
                    <section class="glass-card rounded-xl p-6 shadow-sm">
                        <div class="flex items-center gap-2 mb-4 pb-3 border-b border-gray-100">
                            <span class="material-symbols-outlined text-ocean-blue">admin_panel_settings</span>
                            <h3 class="text-base font-bold text-on-surface">Hành động Admin</h3>
                        </div>

                        <div class="space-y-3">
                            <!-- Xác nhận booking -->
                            <c:if test="${booking.bookingStatus == 'PENDING'}">
                                <a href="<c:url value='/booking/confirm/${booking.bookingId}'/>"
                                   class="flex items-center justify-center gap-2 w-full px-4 py-3 rounded-lg bg-green-600 text-white font-semibold text-sm hover:bg-green-700 transition-colors">
                                    <span class="material-symbols-outlined text-base">check_circle</span>
                                    Xác nhận đặt chỗ
                                </a>
                            </c:if>

                            <!-- Hoàn thành -->
                            <c:if test="${booking.bookingStatus == 'CONFIRMED'}">
                                <a href="<c:url value='/booking/complete/${booking.bookingId}'/>"
                                   class="flex items-center justify-center gap-2 w-full px-4 py-3 rounded-lg bg-ocean-blue text-white font-semibold text-sm hover:brightness-110 transition-all">
                                    <span class="material-symbols-outlined text-base">task_alt</span>
                                    Đánh dấu Hoàn thành
                                </a>
                            </c:if>

                            <!-- Hủy booking -->
                            <c:if test="${booking.bookingStatus == 'PENDING' or booking.bookingStatus == 'CONFIRMED'}">
                                <a href="<c:url value='/booking/cancel/${booking.bookingId}'/>"
                                   onclick="return confirm('Xác nhận hủy đơn #BK-${booking.bookingId}? Hành động này không thể hoàn tác.')"
                                   class="flex items-center justify-center gap-2 w-full px-4 py-3 rounded-lg bg-red-600 text-white font-semibold text-sm hover:bg-red-700 transition-colors">
                                    <span class="material-symbols-outlined text-base">cancel</span>
                                    Hủy đặt chỗ
                                </a>
                            </c:if>

                            <!-- Quay lại -->
                            <a href="<c:url value='/booking/list'/>"
                               class="flex items-center justify-center gap-2 w-full px-4 py-3 rounded-lg border border-outline-variant text-on-surface font-semibold text-sm hover:bg-surface-container transition-colors">
                                <span class="material-symbols-outlined text-base">arrow_back</span>
                                Quay lại danh sách
                            </a>
                        </div>
                    </section>

                    <!-- Thông tin ID -->
                    <section class="glass-card rounded-xl p-5 shadow-sm">
                        <p class="text-xs text-on-surface-variant font-semibold uppercase tracking-wider mb-3">Thông tin hệ thống</p>
                        <div class="space-y-2 text-sm">
                            <div class="flex justify-between">
                                <span class="text-on-surface-variant">Booking ID</span>
                                <span class="font-bold text-deep-navy">${booking.bookingId}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-on-surface-variant">User ID</span>
                                <span class="font-bold text-deep-navy">${booking.userId}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-on-surface-variant">Tour ID</span>
                                <span class="font-bold text-deep-navy">${booking.tourId}</span>
                            </div>
                        </div>
                    </section>

                </div>
            </div>
        </c:if>

    </main>
</div>
</body>
</html>
