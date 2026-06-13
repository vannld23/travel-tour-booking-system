<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <title>Quản trị VoyagerElite - Tạo Lịch Trình</title>
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
        input:focus, select:focus, textarea:focus { outline: none; border-color: #0194F3 !important; box-shadow: 0 0 0 3px rgba(1, 148, 243, 0.1); }
        .field-error { color: #dc2626; font-size: 12px; margin-top: 6px; display: block; }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
    <%@ include file="../layout/sidebar.jsp" %>

<main class="flex-1 ml-[280px] p-8 min-h-screen">
    <div class="flex justify-between items-center mb-8">
        <div>
            <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-2">
                <a class="hover:text-ocean-blue" href="<c:url value='/itinerary/list'/>">Quản lý Lịch trình</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-ocean-blue font-semibold">Thêm Lịch Trình Mới</span>
            </nav>
            <h2 class="text-3xl font-bold text-deep-navy">Thêm Lịch Trình Mới</h2>
        </div>
        <div class="flex gap-4">
            <a class="px-6 py-2.5 rounded-lg border border-outline-variant text-on-surface-variant font-medium hover:brightness-95 transition-all" href="<c:url value='/itinerary/list'/>">Hủy bỏ</a>
            <button form="itinerary-form" class="px-6 py-2.5 rounded-lg bg-ocean-blue text-white font-medium shadow-sm hover:brightness-110 transition-all" type="submit">Lưu Lịch Trình</button>
        </div>
    </div>

    <form:form id="itinerary-form" method="post" modelAttribute="itinerary" action="${pageContext.request.contextPath}/itinerary/create">
        <div class="grid grid-cols-12 gap-6">
            <div class="col-span-8 space-y-6">
                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                        <span class="material-symbols-outlined">info</span>
                        <h3 class="text-xl font-semibold">Thông tin Lịch trình</h3>
                    </div>
                    <div class="space-y-6">
                        <div>
                            <label class="block font-semibold text-on-surface-variant mb-2">Chọn Tour</label>
                            <form:select path="tourId" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg focus:ring-2 focus:ring-ocean-blue">
                                <form:option value="0" label="-- Chọn Tour --" />
                                <form:options items="${tours}" itemValue="tourId" itemLabel="tourName" />
                            </form:select>
                            <form:errors path="tourId" cssClass="field-error" />
                        </div>
                        <div>
                            <label class="block font-semibold text-on-surface-variant mb-2">Ngày thứ mấy (Day Number)</label>
                            <form:input path="dayNumber" type="number" min="1" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg focus:ring-2 focus:ring-ocean-blue" placeholder="vd: 1, 2, 3..." />
                            <form:errors path="dayNumber" cssClass="field-error" />
                        </div>
                        <div>
                            <label class="block font-semibold text-on-surface-variant mb-2">Mô tả hoạt động</label>
                            <form:textarea path="activityDescription" cssClass="w-full p-4 bg-surface-gray border-none rounded-lg resize-none focus:ring-2 focus:ring-ocean-blue" rows="6" placeholder="Mô tả các hoạt động cụ thể diễn ra trong ngày này..." />
                            <form:errors path="activityDescription" cssClass="field-error" />
                        </div>
                    </div>
                </section>
            </div>

            <div class="col-span-4 space-y-6">
                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                        <span class="material-symbols-outlined">help</span>
                        <h3 class="text-xl font-semibold">Trợ giúp</h3>
                    </div>
                    <div class="text-sm text-on-surface-variant leading-relaxed space-y-2">
                        <p><strong>Ngày thứ mấy:</strong> Nhập số nguyên dương thể hiện thứ tự ngày của hoạt động trong chuyến đi.</p>
                        <p><strong>Mô tả hoạt động:</strong> Ghi rõ lịch trình buổi sáng, trưa, tối để khách hàng có thông tin chi tiết nhất.</p>
                    </div>
                </section>

                <!-- Trạng thái hoạt động -->
                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                        <span class="material-symbols-outlined">toggle_on</span>
                        <h3 class="text-xl font-semibold">Trạng thái</h3>
                    </div>
                    <select id="statusStr" name="statusStr"
                            class="w-full px-4 h-12 bg-surface-gray border-none rounded-lg text-sm focus:ring-2 focus:ring-ocean-blue">
                        <c:forEach var="s" items="${statuses}">
                            <option value="${s.name()}">${s.label}</option>
                        </c:forEach>
                    </select>
                </section>
            </div>
        </div>
    </form:form>
</main>
</div>
</body>
</html>
