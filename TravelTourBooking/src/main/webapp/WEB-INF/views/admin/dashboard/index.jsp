<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản trị VoyagerElite - Tổng Quan</title>
    
    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "ocean-blue": "#0194F3",
                        "deep-navy": "#05285D",
                        "surface-gray": "#F2F3F3",
                        "surface-bright": "#f8f9f9",
                        "surface-container": "#edeeee",
                        "outline-variant": "#bfc7d4",
                        "on-surface": "#191c1c",
                        "on-surface-variant": "#3f4752",
                        "action-orange": "#FF5E1F"
                    }
                }
            }
        };
    </script>
    
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .glass-card { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(8px); border: 1px solid rgba(224, 224, 224, 0.5); }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
    
    <!-- Include Sidebar dùng chung -->
    <%@ include file="../layout/sidebar.jsp" %>
    
    <!-- Content chính của Dashboard -->
    <main class="flex-1 ml-[280px] p-8 min-h-screen">
        
        <!-- Topbar -->
        <div class="flex justify-between items-center mb-8">
            <div>
                <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-2">
                    <span class="text-on-surface-variant">Bảng điều khiển</span>
                    <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                    <span class="text-ocean-blue font-semibold">Tổng quan</span>
                </nav>
                <h2 class="text-3xl font-bold text-deep-navy">Tổng Quan Hoạt Động & Doanh Thu</h2>
            </div>
            
            <div class="flex items-center gap-2 bg-white px-4 py-2 rounded-lg border border-outline-variant shadow-sm text-on-surface-variant text-sm font-medium">
                <span class="material-symbols-outlined text-base">calendar_today</span>
                <span>Năm hiện tại: <c:out value="${currentYear}"/></span>
            </div>
        </div>

        <!-- Thống kê tổng quan (Metrics Cards) -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            
            <!-- Tổng người dùng -->
            <div class="glass-card rounded-xl p-6 shadow-sm flex items-center gap-4">
                <div class="p-3 bg-blue-100 text-blue-600 rounded-lg">
                    <span class="material-symbols-outlined text-3xl">groups</span>
                </div>
                <div>
                    <p class="text-sm text-on-surface-variant font-medium">Tổng người dùng</p>
                    <h3 class="text-2xl font-bold text-deep-navy mt-1">
                        <fmt:formatNumber value="${stats.totalUsers}" type="number"/>
                    </h3>
                    <p class="text-xs text-green-600 mt-1 flex items-center gap-1 font-medium">
                        <span class="material-symbols-outlined text-xs">arrow_upward</span> Chủ động
                    </p>
                </div>
            </div>

            <!-- Tổng số tour -->
            <div class="glass-card rounded-xl p-6 shadow-sm flex items-center gap-4">
                <div class="p-3 bg-indigo-100 text-indigo-600 rounded-lg">
                    <span class="material-symbols-outlined text-3xl">explore</span>
                </div>
                <div>
                    <p class="text-sm text-on-surface-variant font-medium">Tổng số Tour</p>
                    <h3 class="text-2xl font-bold text-deep-navy mt-1">
                        <fmt:formatNumber value="${stats.totalTours}" type="number"/>
                    </h3>
                    <p class="text-xs text-indigo-600 mt-1 flex items-center gap-1 font-medium">
                        <span class="material-symbols-outlined text-xs">info</span> Đang kinh doanh
                    </p>
                </div>
            </div>

            <!-- Tổng đơn đặt -->
            <div class="glass-card rounded-xl p-6 shadow-sm flex items-center gap-4">
                <div class="p-3 bg-amber-100 text-amber-600 rounded-lg">
                    <span class="material-symbols-outlined text-3xl">confirmation_number</span>
                </div>
                <div>
                    <p class="text-sm text-on-surface-variant font-medium">Tổng đặt chỗ</p>
                    <h3 class="text-2xl font-bold text-deep-navy mt-1">
                        <fmt:formatNumber value="${stats.totalBookings}" type="number"/>
                    </h3>
                    <p class="text-xs text-amber-600 mt-1 flex items-center gap-1 font-medium">
                        <span class="material-symbols-outlined text-xs">trending_flat</span> Đã ghi nhận
                    </p>
                </div>
            </div>

            <!-- Tổng doanh thu -->
            <div class="glass-card rounded-xl p-6 shadow-sm flex items-center gap-4">
                <div class="p-3 bg-emerald-100 text-emerald-600 rounded-lg">
                    <span class="material-symbols-outlined text-3xl">paid</span>
                </div>
                <div>
                    <p class="text-sm text-on-surface-variant font-medium">Doanh thu thực tế</p>
                    <h3 class="text-2xl font-bold text-deep-navy mt-1">
                        <fmt:formatNumber value="${stats.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </h3>
                    <p class="text-xs text-emerald-600 mt-1 flex items-center gap-1 font-medium">
                        <span class="material-symbols-outlined text-xs">check_circle</span> Trạng thái PAID
                    </p>
                </div>
            </div>
        </div>

        <!-- Biểu đồ phân tích (Charts) -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
            
            <!-- Doanh thu theo Tour (Biểu đồ cột) -->
            <div class="glass-card rounded-xl p-6 shadow-sm">
                <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                    <span class="material-symbols-outlined">bar_chart</span>
                    <h3 class="text-lg font-bold text-deep-navy">Doanh thu theo từng Tour</h3>
                </div>
                <div class="relative w-full h-[320px]">
                    <canvas id="tourRevenueChart"></canvas>
                </div>
            </div>

            <!-- Doanh thu theo tháng (Biểu đồ đường) -->
            <div class="glass-card rounded-xl p-6 shadow-sm">
                <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                    <span class="material-symbols-outlined">timeline</span>
                    <h3 class="text-lg font-bold text-deep-navy">Tình hình doanh thu theo tháng</h3>
                </div>
                <div class="relative w-full h-[320px]">
                    <canvas id="monthlyRevenueChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Bảng thống kê chi tiết -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            
            <!-- Top 5 Tour được đặt nhiều nhất -->
            <div class="glass-card rounded-xl p-6 shadow-sm">
                <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                    <span class="material-symbols-outlined">stars</span>
                    <h3 class="text-lg font-bold text-deep-navy">Top 5 Tour được đặt nhiều nhất</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="border-b border-outline-variant text-sm font-semibold text-on-surface-variant">
                                <th class="pb-3">Tên Tour</th>
                                <th class="pb-3 text-center">Số lượt đặt</th>
                                <th class="pb-3 text-center">Tổng hành khách</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100 text-sm">
                            <c:if test="${empty topTours}">
                                <tr>
                                    <td colspan="3" class="py-4 text-center text-on-surface-variant">Không có dữ liệu thống kê</td>
                                </tr>
                            </c:if>
                            <c:forEach var="item" items="${topTours}">
                                <tr class="hover:bg-slate-50 transition-colors">
                                    <td class="py-3 font-medium text-deep-navy"><c:out value="${item.tourName}"/></td>
                                    <td class="py-3 text-center text-on-surface-variant font-medium"><c:out value="${item.bookingCount}"/></td>
                                    <td class="py-3 text-center font-semibold text-ocean-blue"><c:out value="${item.totalPeople}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Bảng chi tiết Doanh thu theo Tour -->
            <div class="glass-card rounded-xl p-6 shadow-sm">
                <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                    <span class="material-symbols-outlined">analytics</span>
                    <h3 class="text-lg font-bold text-deep-navy">Doanh thu chi tiết theo Tour</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="border-b border-outline-variant text-sm font-semibold text-on-surface-variant">
                                <th class="pb-3">Tên Tour</th>
                                <th class="pb-3 text-right">Doanh thu</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100 text-sm">
                            <c:if test="${empty tourRevenues}">
                                <tr>
                                    <td colspan="2" class="py-4 text-center text-on-surface-variant">Không có dữ liệu doanh thu</td>
                                </tr>
                            </c:if>
                            <c:forEach var="item" items="${tourRevenues}">
                                <tr class="hover:bg-slate-50 transition-colors">
                                    <td class="py-3 font-medium text-deep-navy"><c:out value="${item.tourName}"/></td>
                                    <td class="py-3 text-right font-bold text-emerald-600">
                                        <fmt:formatNumber value="${item.revenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Scripts Khởi Tạo Chart.js -->
<script>
    // Dữ liệu từ Java được đổ xuống thông qua JSTL forEach và EL expressions.

    // 1. Dữ liệu Biểu đồ cột (Doanh thu theo Tour)
    const tourLabels = [
        <c:forEach var="item" items="${tourRevenues}" varStatus="status">
            "${item.tourName}"${status.last ? '' : ','}
        </c:forEach>
    ];
    const tourRevenueData = [
        <c:forEach var="item" items="${tourRevenues}" varStatus="status">
            ${item.revenue}${status.last ? '' : ','}
        </c:forEach>
    ];

    // Khởi tạo Bar Chart
    const ctxTour = document.getElementById('tourRevenueChart').getContext('2d');
    new Chart(ctxTour, {
        type: 'bar',
        data: {
            labels: tourLabels,
            datasets: [{
                label: 'Doanh thu (VNĐ)',
                data: tourRevenueData,
                backgroundColor: 'rgba(1, 148, 243, 0.75)',
                borderColor: '#0194F3',
                borderWidth: 1.5,
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString('vi-VN') + ' ₫';
                        }
                    }
                }
            }
        }
    });

    // 2. Dữ liệu Biểu đồ đường (Doanh thu theo tháng)
    const monthLabels = [
        <c:forEach var="item" items="${monthlyRevenues}" varStatus="status">
            "Tháng ${item.month}"${status.last ? '' : ','}
        </c:forEach>
    ];
    const monthlyRevenueData = [
        <c:forEach var="item" items="${monthlyRevenues}" varStatus="status">
            ${item.revenue}${status.last ? '' : ','}
        </c:forEach>
    ];

    // Khởi tạo Line Chart
    const ctxMonth = document.getElementById('monthlyRevenueChart').getContext('2d');
    new Chart(ctxMonth, {
        type: 'line',
        data: {
            labels: monthLabels,
            datasets: [{
                label: 'Doanh thu theo tháng (VNĐ)',
                data: monthlyRevenueData,
                fill: true,
                backgroundColor: 'rgba(16, 185, 129, 0.1)',
                borderColor: '#10B981',
                borderWidth: 3,
                tension: 0.3,
                pointBackgroundColor: '#10B981',
                pointHoverRadius: 7
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString('vi-VN') + ' ₫';
                        }
                    }
                }
            }
        }
    });
</script>
</body>
</html>
