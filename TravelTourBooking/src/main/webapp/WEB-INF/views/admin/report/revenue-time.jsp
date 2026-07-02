<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <title>Doanh thu theo thời gian - Admin | VoyagerElite</title>
        <!-- Fonts & Icons -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
        
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body { font-family: 'Inter', sans-serif; }
            .glass-card {
                background: white;
                border: 1px solid #e5e7eb;
            }
        </style>
    </head>
    <body class="bg-[#F2F3F3]">
        <div class="flex min-h-screen">
            <%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

            <main class="flex-1 ml-[280px] p-8">
                <div class="mb-8 flex justify-between items-center">
                    <h2 class="text-3xl font-bold text-gray-800">Doanh thu theo thời gian</h2>
                    <div class="flex items-center gap-3">
                        <form action="revenue-time" method="GET" class="flex gap-2">
                            <input type="date" name="startDate" value="${startDate}" class="border rounded-lg px-3 py-2 text-sm outline-none focus:border-blue-500">
                            <input type="date" name="endDate" value="${endDate}" class="border rounded-lg px-3 py-2 text-sm outline-none focus:border-blue-500">
                            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-blue-700">Lọc</button>
                        </form>
                        <a href="<c:url value='/export/revenue/excel'/>"
                           class="flex items-center gap-2 px-4 py-2 bg-emerald-600 text-white text-sm font-semibold rounded-lg hover:bg-emerald-700 transition-all shadow">
                            ⬇ Xuất Excel
                        </a>
                    </div>
                </div>

                <div class="glass-card rounded-xl p-6 shadow-sm mb-8">
                    <canvas id="revenueChart" height="100"></canvas>
                </div>

                <div class="glass-card rounded-xl p-6 shadow-sm">
                    <h3 class="font-bold text-gray-800 mb-4">Chi tiết dữ liệu</h3>
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="text-gray-500 border-b">
                                <th class="pb-3 text-sm">Thời gian</th>
                                <th class="pb-3 text-sm">Doanh thu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${revenueList}">
                                <tr class="border-b last:border-none">
                                    <td class="py-4 font-medium text-gray-700">${item.period}</td>
                                    <td class="py-4 text-blue-600 font-bold">
                                        <fmt:formatNumber value="${item.totalRevenue}" type="currency" currencySymbol="₫"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>

        <script>
            const ctx = document.getElementById('revenueChart').getContext('2d');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: [<c:forEach items="${revenueList}" var="item">"${item.period}",</c:forEach>],
                            datasets: [{
                                    label: 'Doanh thu (VNĐ)',
                                    data: [<c:forEach items="${revenueList}" var="item">${item.totalRevenue},</c:forEach>],
                                    borderColor: '#2563eb',
                                    backgroundColor: '#2563eb', // Màu của dấu chấm
                                    pointRadius: 4, // Kích thước dấu chấm (làm nó to và rõ hơn)
                                    pointHoverRadius: 8, // Kích thước khi di chuột vào
                                    fill: true,
                                    tension: 0.3
                                }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {position: 'bottom'}
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function (value) {
                                    return '₫' + value.toLocaleString();
                                }
                            }
                        }
                    }
                }
            });
        </script>
    </body>
</html>