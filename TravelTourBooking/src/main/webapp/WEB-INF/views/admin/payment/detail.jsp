<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Chi tiết Thanh toán #TXN-${payment.paymentId} | VoyagerElite Admin</title>

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
        .info-row { display: flex; padding: 14px 0; border-bottom: 1px solid #f0f0f0; align-items: flex-start; }
        .info-label { width: 200px; flex-shrink: 0; font-size: 13px; font-weight: 600; color: #3f4752; }
        .info-value { font-size: 14px; color: #191c1c; }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
    <%@ include file="../layout/sidebar.jsp" %>

    <main class="flex-1 ml-[280px] p-8 min-h-screen">
        <!-- Breadcrumb & Header -->
        <div class="mb-6">
            <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-2">
                <span class="material-symbols-outlined text-[14px]">home</span>
                <a href="<c:url value='/payment/list'/>" class="text-ocean-blue hover:underline font-medium">Quản lý Thanh toán</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-on-surface font-semibold">Chi tiết #TXN-${payment.paymentId}</span>
            </nav>
            <div class="flex justify-between items-center">
                <h2 class="text-3xl font-bold text-deep-navy">Chi tiết Thanh toán</h2>
                <a href="<c:url value='/payment/list'/>"
                   class="flex items-center gap-2 px-4 py-2 rounded-lg border border-outline-variant text-on-surface text-sm hover:bg-surface-container transition-all">
                    <span class="material-symbols-outlined text-base">arrow_back</span>
                    Quay lại danh sách
                </a>
            </div>
        </div>

        <c:if test="${empty payment}">
            <div class="glass-card rounded-xl p-16 text-center">
                <span class="material-symbols-outlined text-5xl text-outline-variant block mb-3">search_off</span>
                <p class="text-on-surface-variant font-semibold">Không tìm thấy thông tin giao dịch thanh toán.</p>
                <a href="<c:url value='/payment/list'/>" class="mt-4 inline-block text-ocean-blue hover:underline text-sm">
                    ← Quay lại danh sách
                </a>
            </div>
        </c:if>

        <c:if test="${not empty payment}">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Cột trái: thông tin thanh toán -->
                <div class="lg:col-span-2 space-y-6">
                    <section class="glass-card rounded-xl p-6 shadow-sm">
                        <div class="flex items-center gap-3 mb-5 pb-3 border-b border-gray-100">
                            <span class="material-symbols-outlined text-ocean-blue">payments</span>
                            <h3 class="text-lg font-bold text-on-surface">Thông tin Giao dịch</h3>
                            <span class="ml-auto text-xl font-bold text-ocean-blue">#TXN-${payment.paymentId}</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Trạng thái</span>
                            <c:choose>
                                <c:when test="${payment.paymentStatus == 'PAID'}">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-green-100 text-green-800 text-xs font-bold">
                                        <span class="w-1.5 h-1.5 rounded-full bg-green-600"></span> Thành công
                                    </span>
                                </c:when>
                                <c:when test="${payment.paymentStatus == 'PENDING'}">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-yellow-100 text-yellow-800 text-xs font-bold">
                                        <span class="w-1.5 h-1.5 rounded-full bg-yellow-600"></span> Đang xử lý
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-red-100 text-red-800 text-xs font-bold">
                                        <span class="w-1.5 h-1.5 rounded-full bg-red-600"></span> Thất bại
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Mã đơn hàng</span>
                            <span class="info-value font-semibold text-ocean-blue">#BK-${payment.bookingId}</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Tên khách khách hàng</span>
                            <span class="info-value font-semibold">${payment.fullName}</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Tour đăng ký</span>
                            <span class="info-value">${payment.tourName}</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Phương thức thanh toán</span>
                            <span class="info-value font-semibold">${payment.paymentMethod}</span>
                        </div>

                        <div class="info-row font-semibold">
                            <span class="info-label">Số tiền thanh toán</span>
                            <span class="info-value font-bold text-action-orange text-lg">
                                <fmt:formatNumber value="${payment.amount}" type="number" groupingUsed="true"/>₫
                            </span>
                        </div>

                        <div class="info-row" style="border-bottom:none;">
                            <span class="info-label">Ngày thanh toán</span>
                            <span class="info-value">
                                <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </span>
                        </div>
                    </section>
                </div>

                <!-- Cột phải: hành động -->
                <div class="space-y-4">
                    <section class="glass-card rounded-xl p-6 shadow-sm">
                        <div class="flex items-center gap-2 mb-4 pb-3 border-b border-gray-100">
                            <span class="material-symbols-outlined text-ocean-blue">admin_panel_settings</span>
                            <h3 class="text-base font-bold text-on-surface">Thao tác quản trị</h3>
                        </div>

                        <div class="space-y-3">
                            <c:if test="${payment.paymentStatus == 'PENDING'}">
                                <a href="<c:url value='/payment/confirm/${payment.paymentId}'/>"
                                   class="flex items-center justify-center gap-2 w-full px-4 py-3 rounded-lg bg-green-600 text-white font-semibold text-sm hover:bg-green-700 transition-colors">
                                    <span class="material-symbols-outlined text-base">check_circle</span>
                                    Xác nhận thanh toán
                                </a>
                            </c:if>

                            <a href="<c:url value='/payment/list'/>"
                               class="flex items-center justify-center gap-2 w-full px-4 py-3 rounded-lg border border-outline-variant text-on-surface font-semibold text-sm hover:bg-surface-container transition-colors">
                                <span class="material-symbols-outlined text-base">arrow_back</span>
                                Quay lại danh sách
                            </a>
                        </div>
                    </section>
                </div>
            </div>
        </c:if>
    </main>
</div>
</body>
</html>
