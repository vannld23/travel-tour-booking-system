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
    <title>Quản trị VoyagerElite - Sửa Điểm Đến</title>
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
                <a class="hover:text-ocean-blue" href="<c:url value='/destination/list'/>">Quản lý Điểm đến</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-ocean-blue font-semibold">Chỉnh sửa Điểm Đến</span>
            </nav>
            <h2 class="text-3xl font-bold text-deep-navy">Chỉnh sửa Điểm Đến</h2>
        </div>
        <div class="flex gap-4">
            <a class="px-6 py-2.5 rounded-lg border border-outline-variant text-on-surface-variant font-medium hover:brightness-95 transition-all" href="<c:url value='/destination/list'/>">Hủy bỏ</a>
            <button form="destination-form" class="px-6 py-2.5 rounded-lg bg-ocean-blue text-white font-medium shadow-sm hover:brightness-110 transition-all" type="submit">Lưu thay đổi</button>
        </div>
    </div>

    <form:form id="destination-form" method="post" modelAttribute="destination" action="${pageContext.request.contextPath}/destination/edit">
        <form:hidden path="destinationId" />
        <div class="grid grid-cols-12 gap-6">
            <div class="col-span-8 space-y-6">
                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                        <span class="material-symbols-outlined">info</span>
                        <h3 class="text-xl font-semibold">Thông tin chung</h3>
                    </div>
                    <div class="space-y-6">
                        <div>
                            <label class="block font-semibold text-on-surface-variant mb-2">Tên Điểm đến</label>
                            <form:input path="destinationName" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg focus:ring-2 focus:ring-ocean-blue" />
                            <form:errors path="destinationName" cssClass="field-error" />
                        </div>
                        <div class="grid grid-cols-2 gap-6">
                            <div>
                                <label class="block font-semibold text-on-surface-variant mb-2">Quốc gia</label>
                                <form:input path="country" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg focus:ring-2 focus:ring-ocean-blue" />
                            </div>
                            <div>
                                <label class="block font-semibold text-on-surface-variant mb-2">Thành phố</label>
                                <form:input path="city" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg focus:ring-2 focus:ring-ocean-blue" />
                            </div>
                        </div>
                        <div>
                            <label class="block font-semibold text-on-surface-variant mb-2">Mô tả Điểm đến</label>
                            <form:textarea path="description" cssClass="w-full p-4 bg-surface-gray border-none rounded-lg resize-none focus:ring-2 focus:ring-ocean-blue" rows="6" />
                        </div>
                    </div>
                </section>
            </div>

            <div class="col-span-4 space-y-6">
                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                        <span class="material-symbols-outlined">image</span>
                        <h3 class="text-xl font-semibold">Ảnh Điểm đến</h3>
                    </div>
                    <div class="border-2 border-dashed border-outline-variant rounded-xl p-8 text-center bg-surface-bright mb-6">
                        <p class="font-medium text-on-surface mb-1">Nhập đường dẫn ảnh</p>
                        <p class="text-sm text-on-surface-variant">Ví dụ: `paris.jpg` hoặc URL ảnh</p>
                    </div>
                    <div>
                        <label class="block font-semibold text-on-surface-variant mb-2">Image URL</label>
                        <form:input path="imageUrl" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg focus:ring-2 focus:ring-ocean-blue" />
                    </div>
                </section>

                <!-- Trạng thái điểm đến -->
                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                        <span class="material-symbols-outlined">toggle_on</span>
                        <h3 class="text-xl font-semibold">Trạng thái</h3>
                    </div>
                    <select id="statusStr" name="statusStr"
                            class="w-full px-4 py-3 bg-surface-gray border-none rounded-lg text-sm focus:ring-2 focus:ring-ocean-blue">
                        <c:forEach var="s" items="${statuses}">
                            <%-- Pre-select trạng thái hiện tại của điểm đến --%>
                            <option value="${s.name()}" ${destination.status.name() == s.name() ? 'selected' : ''}>
                                ${s.label}
                            </option>
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
