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
    <title>Quản trị VoyagerElite - Tạo Tour</title>
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
            <nav class="flex items-center gap-2 text-[#3f4752] text-sm mb-2">
                <a class="hover:text-[#0194F3]" href="<c:url value='/tuormanagement/list'/>">Quản lý Tour</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-[#0194F3] font-semibold">Thêm Tour Mới</span>
            </nav>
            <h2 class="text-3xl font-bold text-[#05285D]">Thêm Tour Mới</h2>
        </div>
        <div class="flex gap-4">
            <a class="px-6 py-2.5 rounded-lg border border-[#bfc7d4] text-[#3f4752]" href="<c:url value='/tuormanagement/list'/>">Hủy bỏ</a>
            <button form="tour-form" class="px-6 py-2.5 rounded-lg bg-[#0194F3] text-white shadow-sm" type="submit">Lưu Tour</button>
        </div>
    </div>

    <form:form id="tour-form" method="post" modelAttribute="tour" action="${pageContext.request.contextPath}/tuormanagement/create">
        <div class="grid grid-cols-12 gap-6">
            <div class="col-span-8 space-y-6">
                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-6 text-[#0194F3]">
                        <span class="material-symbols-outlined">info</span>
                        <h3 class="text-xl font-semibold">Thông tin chung</h3>
                    </div>
                    <div class="space-y-6">
                        <div>
                            <label class="block font-semibold text-[#3f4752] mb-2">Tên Tour</label>
                            <form:input path="tourName" cssClass="w-full h-12 px-4 bg-[#F2F3F3] border-none rounded-lg" placeholder="vd: Khám phá dãy Alps hùng vĩ" />
                            <form:errors path="tourName" cssClass="field-error" />
                        </div>
                        <div class="grid grid-cols-2 gap-6">
                            <div>
                                <label class="block font-semibold text-[#3f4752] mb-2">Điểm đến</label>
                                <form:select path="destinationId" cssClass="w-full h-12 px-4 bg-[#F2F3F3] border-none rounded-lg">
                                    <form:option value="0" label="Chọn điểm đến" />
                                    <form:options items="${destinations}" itemValue="destinationId" itemLabel="destinationName" />
                                </form:select>
                                <form:errors path="destinationId" cssClass="field-error" />
                            </div>
                            <div>
                                <label class="block font-semibold text-[#3f4752] mb-2">Thời lượng</label>
                                <form:input path="durationDays" cssClass="w-full h-12 px-4 bg-[#F2F3F3] border-none rounded-lg" type="number" min="1" />
                                <form:errors path="durationDays" cssClass="field-error" />
                            </div>
                        </div>
                        <div>
                            <label class="block font-semibold text-[#3f4752] mb-2">Mô tả Tour</label>
                            <form:textarea path="description" cssClass="w-full p-4 bg-[#F2F3F3] border-none rounded-lg resize-none" rows="6" />
                        </div>
                    </div>
                </section>

                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-6 text-[#0194F3]">
                        <span class="material-symbols-outlined">payments</span>
                        <h3 class="text-xl font-semibold">Giá cả &amp; Hậu cần</h3>
                    </div>
                    <div class="grid grid-cols-3 gap-6">
                        <div>
                            <label class="block font-semibold text-[#3f4752] mb-2">Giá cơ bản</label>
                            <form:input path="price" cssClass="w-full h-12 px-4 bg-[#F2F3F3] border-none rounded-lg" type="number" step="0.01" min="0" />
                            <form:errors path="price" cssClass="field-error" />
                        </div>
                        <div>
                            <label class="block font-semibold text-[#3f4752] mb-2">Sức chứa tối đa</label>
                            <form:input path="maxCapacity" cssClass="w-full h-12 px-4 bg-[#F2F3F3] border-none rounded-lg" type="number" min="1" />
                            <form:errors path="maxCapacity" cssClass="field-error" />
                        </div>
                        <div>
                            <label class="block font-semibold text-[#3f4752] mb-2">Hạng mục</label>
                            <select class="w-full h-12 px-4 bg-[#F2F3F3] border-none rounded-lg">
                                <option>Sang trọng</option>
                                <option>Phiêu lưu</option>
                                <option>Gia đình</option>
                                <option>Du lịch sinh thái</option>
                            </select>
                        </div>
                    </div>
                </section>
            </div>

            <div class="col-span-4 space-y-6">
                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-6 text-[#0194F3]">
                        <span class="material-symbols-outlined">image</span>
                        <h3 class="text-xl font-semibold">Bộ sưu tập hình ảnh</h3>
                    </div>
                    <div class="border-2 border-dashed border-[#bfc7d4] rounded-xl p-8 text-center bg-[#f8f9f9] mb-6">
                        <p class="font-medium text-[#191c1c] mb-1">Nhập đường dẫn ảnh cho tour</p>
                        <p class="text-sm text-[#3f4752]">Bạn có thể nhập `imageUrl` thủ công</p>
                    </div>
                    <div>
                        <label class="block font-semibold text-[#3f4752] mb-2">Image URL</label>
                        <form:input path="imageUrl" cssClass="w-full h-12 px-4 bg-[#F2F3F3] border-none rounded-lg" placeholder="tour1.jpg" />
                    </div>
                </section>

                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-6 text-[#0194F3]">
                        <span class="material-symbols-outlined">schedule</span>
                        <h3 class="text-xl font-semibold">Ngày bắt đầu</h3>
                    </div>
                    <div class="space-y-4">
                        <div>
                            <label class="block font-semibold text-[#3f4752] mb-2">Start Date</label>
                            <form:input path="startDate" cssClass="w-full h-12 px-4 bg-[#F2F3F3] border-none rounded-lg" type="date" />
                        </div>
                        <div>
                            <label class="block font-semibold text-[#3f4752] mb-2">End Date</label>
                            <form:input path="endDate" cssClass="w-full h-12 px-4 bg-[#F2F3F3] border-none rounded-lg" type="date" />
                        </div>
                    </div>
                </section>

                <!-- Trạng thái hoạt động -->
                <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                    <div class="flex items-center gap-2 mb-4 text-[#0194F3]">
                        <span class="material-symbols-outlined">toggle_on</span>
                        <h3 class="text-xl font-semibold">Trạng thái</h3>
                    </div>
                    <select id="statusStr" name="statusStr"
                            class="w-full px-4 h-12 bg-[#F2F3F3] border-none rounded-lg text-sm focus:ring-2 focus:ring-ocean-blue">
                        <c:forEach var="s" items="${statuses}">
                            <option value="${s.name()}">${s.label}</option>
                        </c:forEach>
                    </select>
                </section>
            </div>
        </div>

        <footer class="mt-8 pt-8 border-t border-[#bfc7d4] flex justify-end gap-4">
            <a class="px-8 py-3 rounded-lg border border-[#bfc7d4] text-[#3f4752]" href="<c:url value='/tuormanagement/list'/>">Hủy bản nháp</a>
            <button class="px-10 py-3 rounded-lg bg-[#FF5E1F] text-white shadow-lg" type="submit">Xuất bản Tour</button>
        </footer>
    </form:form>
</main>
</div>
</body>
</html>
