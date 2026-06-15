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
                        <p class="text-3xl font-bold text-gray-800">${stats.totalTours}</p>
                    </div>

                    <div class="bg-white rounded-xl p-6 glass-card shadow-sm border-l-4 border-green-500">
                        <p class="text-xs font-bold text-gray-500 uppercase">Tổng đặt chỗ</p>
                        <p class="text-3xl font-bold text-gray-800">${stats.totalBookings}</p>
                    </div>

                    <div class="bg-white rounded-xl p-6 glass-card shadow-sm border-l-4 border-purple-500">
                        <p class="text-xs font-bold text-gray-500 uppercase">Tổng doanh thu</p>
                        <p class="text-3xl font-bold text-gray-800">
                            <fmt:formatNumber value="${stats.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </p>
                    </div>

                    <div class="bg-white rounded-xl p-6 glass-card shadow-sm border-l-4 border-orange-500">
                        <p class="text-xs font-bold text-gray-500 uppercase">Tổng người dùng</p>
                        <p class="text-3xl font-bold text-gray-800">${stats.totalUsers}</p>
                    </div>
                </div>

                <section class="glass-card rounded-xl p-6 shadow-sm mt-8">
                    <h3 class="font-bold text-gray-800 mb-4">Top 5 Tour bán chạy nhất</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="text-gray-400 text-sm border-b">
                                    <th class="pb-3 font-medium">Tên Tour</th>
                                    <th class="pb-3 font-medium text-center">Số lượng đặt</th>
                                    <th class="pb-3 font-medium text-right">Tổng hành khách</th>
                                </tr>
                            </thead>
                            <tbody class="text-gray-700">
                                <c:forEach items="${topTours}" var="tour">
                                    <tr class="border-b last:border-none">
                                        <td class="py-4 font-medium">${tour.tourName}</td>
                                        <td class="py-4 text-center">${tour.bookingCount}</td>
                                        <td class="py-4 text-right">${tour.totalPeople}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </section>
            </main>
        </div>
    </body>
</html>