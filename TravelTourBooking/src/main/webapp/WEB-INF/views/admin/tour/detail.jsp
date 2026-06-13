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
    <title>Quản trị VoyagerElite - Chi tiết Tour</title>
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
    <%@ include file="../layout/sidebar.jsp" %>

<main class="flex-1 ml-[280px] p-8 min-h-screen">
    <div class="flex justify-between items-center mb-8">
        <div>
            <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-2">
                <a class="hover:text-ocean-blue" href="<c:url value='/tuormanagement/list'/>">Quản lý Tour</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-ocean-blue font-semibold">Chi tiết Tour</span>
            </nav>
            <h2 class="text-3xl font-bold text-deep-navy">${tour.tourName}</h2>
        </div>
        <div class="flex gap-4">
            <a class="px-6 py-2.5 rounded-lg bg-surface-container text-on-surface-variant font-medium hover:brightness-95 transition-all" href="<c:url value='/tuormanagement/list'/>">Quay lại</a>
            <a class="px-6 py-2.5 rounded-lg bg-ocean-blue text-white font-medium hover:brightness-110 transition-all" href="<c:url value='/tuormanagement/edit'><c:param name='id' value='${tour.tourId}'/></c:url>">Sửa Tour</a>
        </div>
    </div>

    <div class="grid grid-cols-12 gap-6">
        <div class="col-span-8 space-y-6">
            <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                    <span class="material-symbols-outlined">info</span>
                    <h3 class="text-xl font-semibold">Thông tin chi tiết</h3>
                </div>
                <div class="space-y-4">
                    <div class="grid grid-cols-3 gap-6 py-3 border-b border-outline-variant/30">
                        <span class="font-semibold text-on-surface-variant">ID Tour</span>
                        <span class="col-span-2 text-on-surface font-medium">${tour.tourId}</span>
                    </div>
                    <div class="grid grid-cols-3 gap-6 py-3 border-b border-outline-variant/30">
                        <span class="font-semibold text-on-surface-variant">Tên Tour</span>
                        <span class="col-span-2 text-on-surface font-semibold">${tour.tourName}</span>
                    </div>
                    <div class="grid grid-cols-3 gap-6 py-3 border-b border-outline-variant/30">
                        <span class="font-semibold text-on-surface-variant">Điểm đến</span>
                        <span class="col-span-2 text-on-surface">${tour.destinationName}</span>
                    </div>
                    <div class="grid grid-cols-3 gap-6 py-3 border-b border-outline-variant/30">
                        <span class="font-semibold text-on-surface-variant">Thời lượng</span>
                        <span class="col-span-2 text-on-surface">${tour.durationDays} Ngày</span>
                    </div>
                    <div class="grid grid-cols-3 gap-6 py-3 border-b border-outline-variant/30">
                        <span class="font-semibold text-on-surface-variant">Giá</span>
                        <span class="col-span-2 text-action-orange font-bold">${tour.price} USD</span>
                    </div>
                    <div class="grid grid-cols-3 gap-6 py-3 border-b border-outline-variant/30">
                        <span class="font-semibold text-on-surface-variant">Sức chứa tối đa</span>
                        <span class="col-span-2 text-on-surface">${tour.maxCapacity} Người</span>
                    </div>
                    <div class="grid grid-cols-3 gap-6 py-3 border-b border-outline-variant/30">
                        <span class="font-semibold text-on-surface-variant">Mô tả</span>
                        <span class="col-span-2 text-on-surface-variant leading-relaxed">${tour.description}</span>
                    </div>
                </div>
            </section>

            <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                    <span class="material-symbols-outlined">schedule</span>
                    <h3 class="text-xl font-semibold">Lịch trình chi tiết (Itinerary)</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <thead>
                            <tr class="bg-deep-navy text-white text-left">
                                <th class="p-3 w-24">Ngày</th>
                                <th class="p-3">Hoạt động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="itinerary" items="${itineraries}">
                                <tr class="border-b border-outline-variant hover:bg-surface-bright">
                                    <td class="p-3 font-bold text-ocean-blue">Ngày ${itinerary.dayNumber}</td>
                                    <td class="p-3 text-on-surface-variant whitespace-pre-line">${itinerary.activityDescription}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty itineraries}">
                                <tr>
                                    <td colspan="2" class="p-4 text-center text-on-surface-variant">Chưa có lịch trình được thiết lập cho Tour này.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <div class="col-span-4 space-y-6">
            <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)] overflow-hidden">
                <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                    <span class="material-symbols-outlined">image</span>
                    <h3 class="text-xl font-semibold">Ảnh đại diện</h3>
                </div>
                <div class="rounded-lg overflow-hidden bg-surface-container aspect-video mb-4 flex items-center justify-center border border-outline-variant/30">
                    <c:choose>
                        <c:when test="${not empty tour.imageUrl}">
                            <img class="w-full h-full object-cover" src="<c:url value='/resources/images/${tour.imageUrl}'/>" onerror="this.src='https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?auto=format&fit=crop&w=800&q=80'" alt="${tour.tourName}"/>
                        </c:when>
                        <c:otherwise>
                            <span class="text-on-surface-variant text-sm">Không có hình ảnh</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="text-xs text-on-surface-variant break-all">
                    <strong>Đường dẫn:</strong> ${tour.imageUrl}
                </div>
            </section>

            <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                    <span class="material-symbols-outlined">calendar_today</span>
                    <h3 class="text-xl font-semibold">Thời gian vận hành</h3>
                </div>
                <div class="space-y-4 text-sm">
                    <div class="flex justify-between items-center py-2 border-b border-outline-variant/20">
                        <span class="text-on-surface-variant font-medium">Ngày khởi hành:</span>
                        <span class="text-on-surface font-semibold">${tour.startDate}</span>
                    </div>
                    <div class="flex justify-between items-center py-2 border-b border-outline-variant/20">
                        <span class="text-on-surface-variant font-medium">Ngày kết thúc:</span>
                        <span class="text-on-surface font-semibold">${tour.endDate}</span>
                    </div>
                </div>
            </section>
        </div>
    </div>
</main>
</div>
</body>
</html>
