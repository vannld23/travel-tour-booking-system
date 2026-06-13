<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Tổng quan hệ thống - Admin | VoyagerElite</title>

        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@400,1&display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #F2F3F3;
            }
            .glass-card {
                background: white;
                border: 1px solid #e5e7eb;
            }
        </style>
    </head>
    <body class="bg-surface-gray">
        <div class="flex min-h-screen">
            <%-- Đường dẫn tuyệt đối tới sidebar --%>
            <%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

            <main class="flex-1 ml-[280px] p-8">
                <div class="mb-8">
                    <h2 class="text-3xl font-bold text-gray-800">Tổng quan hệ thống</h2>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">

                    <div class="bg-white rounded-xl p-6 glass-card shadow-sm border-l-4 border-blue-500">
                        <p class="text-xs font-bold text-gray-500 uppercase">Tổng số Tour</p>
                        <p class="text-3xl font-bold text-gray-800">${not empty stats ? stats.totalTours : 0}</p>
                    </div>

                    <div class="bg-white rounded-xl p-6 glass-card shadow-sm border-l-4 border-green-500">
                        <p class="text-xs font-bold text-gray-500 uppercase">Tổng đặt chỗ</p>
                        <p class="text-3xl font-bold text-gray-800">${not empty stats ? stats.totalBookings : 0}</p>
                    </div>

                    <div class="bg-white rounded-xl p-6 glass-card shadow-sm border-l-4 border-purple-500">
                        <p class="text-xs font-bold text-gray-500 uppercase">Tổng doanh thu</p>
                        <p class="text-3xl font-bold text-gray-800">
                            <fmt:formatNumber value="${not empty stats ? stats.totalRevenue : 0}" type="currency" currencySymbol="₫"/>
                        </p>
                    </div>

                    <div class="bg-white rounded-xl p-6 glass-card shadow-sm border-l-4 border-orange-500">
                        <p class="text-xs font-bold text-gray-500 uppercase">Tổng người dùng</p>
                        <p class="text-3xl font-bold text-gray-800">${not empty stats ? stats.totalUsers : 0}</p>
                    </div>
                </div>

                <section class="glass-card rounded-xl p-6 shadow-sm">
                    <h3 class="font-bold text-gray-800 mb-4">Chi tiết báo cáo</h3>
                    <p class="text-sm text-gray-600">Dữ liệu được cập nhật theo thời gian thực từ hệ thống.</p>
                </section>
            </main>
        </div>
    </body>
</html>