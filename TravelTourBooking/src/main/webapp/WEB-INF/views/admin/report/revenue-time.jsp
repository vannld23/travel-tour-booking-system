<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <title>Doanh thu theo thời gian - Admin | VoyagerElite</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .glass-card { background: white; border: 1px solid #e5e7eb; }
        </style>
    </head>
    <body class="bg-[#F2F3F3]">
        <div class="flex min-h-screen">
            <%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

            <main class="flex-1 ml-[280px] p-8">
                <div class="mb-8 flex justify-between items-center">
                    <h2 class="text-3xl font-bold text-gray-800">Doanh thu theo thời gian</h2>
                    
                    <form action="revenue-time" method="GET" class="flex gap-2">
                        <input type="date" name="startDate" value="${startDate}" class="border rounded-lg px-3 py-2 text-sm outline-none focus:border-blue-500">
                        <input type="date" name="endDate" value="${endDate}" class="border rounded-lg px-3 py-2 text-sm outline-none focus:border-blue-500">
                        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-blue-700">Lọc</button>
                    </form>
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
                        backgroundColor: 'rgba(37, 99, 235, 0.1)',
                        fill: true,
                        tension: 0.3
                    }]
                },
                options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
            });
        </script>
    </body>
</html>