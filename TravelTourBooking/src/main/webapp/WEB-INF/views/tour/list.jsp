<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <title>Quản trị VoyagerElite - Quản lý Tour</title>
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
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .glass-card { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(8px); border: 1px solid rgba(224, 224, 224, 0.5); }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
<aside class="h-screen w-[280px] fixed left-0 top-0 bg-deep-navy shadow-lg flex flex-col py-6 z-50">
    <div class="px-6 mb-8">
        <h1 class="font-bold text-2xl text-white">Bảng điều khiển Admin</h1>
        <p class="text-white/70 text-sm mt-1">Logistics Du lịch</p>
    </div>
    <nav class="flex-1 px-3 space-y-2">
        <a class="flex items-center px-4 py-3 text-white/80 hover:bg-white/10 rounded-xl transition-colors" href="<c:url value='/dashboard'/>">
            <span class="material-symbols-outlined mr-3 text-ocean-blue">dashboard</span>
            <span>Tổng quan</span>
        </a>
        <a class="flex items-center px-4 py-3 bg-ocean-blue text-white rounded-xl transition-all duration-200" href="<c:url value='/tuormanagement/list'/>">
            <span class="material-symbols-outlined mr-3">explore</span>
            <span>Quản lý Tour</span>
        </a>
        <a class="flex items-center px-4 py-3 text-white/80 hover:bg-white/10 rounded-xl transition-colors" href="<c:url value='/booking/list'/>">
            <span class="material-symbols-outlined mr-3">confirmation_number</span>
            <span>Quản lý Đặt chỗ</span>
        </a>
        <a class="flex items-center px-4 py-3 text-white/80 hover:bg-white/10 rounded-xl transition-colors" href="<c:url value='/report/revenue'/>">
            <span class="material-symbols-outlined mr-3">analytics</span>
            <span>Báo cáo</span>
        </a>
        <a class="flex items-center px-4 py-3 text-white/80 hover:bg-white/10 rounded-xl transition-colors" href="<c:url value='/system/setting'/>">
            <span class="material-symbols-outlined mr-3">settings</span>
            <span>Cài đặt</span>
        </a>
    </nav>
</aside>

<main class="flex-1 ml-[280px] p-8 min-h-screen">
    <div class="flex justify-between items-center mb-8">
        <div>
            <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-2">
                <span class="text-ocean-blue font-semibold">Quản lý Tour</span>
            </nav>
            <h2 class="text-3xl font-bold text-deep-navy">Danh sách Tour</h2>
        </div>
        <a class="px-6 py-2.5 rounded-lg bg-ocean-blue text-white font-medium shadow-sm hover:brightness-110 transition-all" href="<c:url value='/tuormanagement/create'/>">Thêm Tour Mới</a>
    </div>

    <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
        <div class="flex items-center gap-2 mb-6 text-ocean-blue">
            <span class="material-symbols-outlined">explore</span>
            <h3 class="text-xl font-semibold">Tour Management</h3>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full border-collapse">
                <thead>
                    <tr class="bg-deep-navy text-white">
                        <th class="text-left p-3">ID</th>
                        <th class="text-left p-3">Tên Tour</th>
                        <th class="text-left p-3">Điểm đến</th>
                        <th class="text-left p-3">Giá</th>
                        <th class="text-left p-3">Số ngày</th>
                        <th class="text-left p-3">Sức chứa</th>
                        <th class="text-left p-3">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tour" items="${tours}">
                        <tr class="border-b border-outline-variant hover:bg-surface-bright">
                            <td class="p-3">${tour.tourId}</td>
                            <td class="p-3 font-semibold text-on-surface">${tour.tourName}</td>
                            <td class="p-3">${tour.destinationName}</td>
                            <td class="p-3">${tour.price}</td>
                            <td class="p-3">${tour.durationDays}</td>
                            <td class="p-3">${tour.maxCapacity}</td>
                            <td class="p-3">
                                <div class="flex flex-wrap gap-2">
                                    <a class="px-3 py-2 rounded-lg bg-surface-container text-on-surface-variant text-sm" href="<c:url value='/tuormanagement/detail'><c:param name='id' value='${tour.tourId}'/></c:url>">Chi tiết</a>
                                    <a class="px-3 py-2 rounded-lg bg-ocean-blue text-white text-sm" href="<c:url value='/tuormanagement/edit'><c:param name='id' value='${tour.tourId}'/></c:url>">Sửa</a>
                                    <a class="px-3 py-2 rounded-lg bg-action-orange text-white text-sm" href="<c:url value='/tuormanagement/delete'><c:param name='id' value='${tour.tourId}'/></c:url>">Xóa</a>
                                </div>
                            </td>
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
