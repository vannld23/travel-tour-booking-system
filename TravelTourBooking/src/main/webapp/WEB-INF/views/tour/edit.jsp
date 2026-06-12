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
    <title>Quản trị VoyagerElite - Quản lý Tour</title>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "ocean-blue": "#0194F3",
                        "surface-gray": "#F2F3F3",
                        "deep-navy": "#05285D",
                        "surface-bright": "#f8f9f9",
                        "surface-container": "#edeeee",
                        "outline-variant": "#bfc7d4",
                        "on-surface": "#191c1c",
                        "on-surface-variant": "#3f4752",
                        "on-background": "#191c1c",
                        "action-orange": "#FF5E1F",
                        "status-success": "#00BA4A"
                    }
                }
            }
        };
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .glass-card { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(8px); border: 1px solid rgba(224, 224, 224, 0.5); }
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #0194F3 !important;
            box-shadow: 0 0 0 3px rgba(1, 148, 243, 0.1);
        }
        .field-error { color: #dc2626; font-size: 12px; margin-top: 6px; display: block; }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex">
<aside class="h-full w-64 fixed left-0 top-0 bg-deep-navy shadow-lg flex flex-col py-6 z-50">
    <div class="px-6 mb-8">
        <h1 class="font-headline-md text-headline-md font-bold text-white">VoyagerElite</h1>
        <p class="text-white/70 font-label-sm text-label-sm mt-1">Bảng quản trị Tour</p>
    </div>
</aside>

<main class="flex-1 ml-64 p-8 min-h-screen">
    <div class="flex justify-between items-center mb-8">
        <div>
            <nav class="flex items-center gap-2 text-on-surface-variant font-label-sm text-label-sm mb-2">
                <a class="hover:text-ocean-blue" href="<c:url value='/tour/list'/>">Quản lý Tour</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-ocean-blue font-semibold">Chỉnh sửa Tour</span>
            </nav>
            <h2 class="font-headline-lg text-headline-lg text-deep-navy">Chỉnh sửa Tour</h2>
        </div>
        <div class="flex gap-4">
            <a class="px-6 py-2.5 rounded-lg border border-outline-variant text-on-surface-variant font-label-md text-label-md hover:bg-surface-container transition-all" href="<c:url value='/tour/list'/>">Hủy bỏ</a>
            <button form="tour-form" class="px-6 py-2.5 rounded-lg bg-ocean-blue text-white font-label-md text-label-md shadow-sm hover:brightness-110 active:scale-95 transition-all" type="submit">Lưu Tour</button>
        </div>
    </div>

    <div class="grid grid-cols-12 gap-gutter">
        <div class="col-span-8 space-y-gutter">
            <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                    <span class="material-symbols-outlined">info</span>
                    <h3 class="font-headline-md text-headline-md">Thông tin chung</h3>
                </div>

                <form:form id="tour-form" method="post" modelAttribute="tour" action="${pageContext.request.contextPath}/tour/edit">
                    <form:hidden path="tourId" />
                    <div class="space-y-6">
                        <div>
                            <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Tên Tour</label>
                            <form:input path="tourName" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md" />
                            <form:errors path="tourName" cssClass="field-error" />
                        </div>
                        <div class="grid grid-cols-2 gap-6">
                            <div>
                                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Điểm đến</label>
                                <form:select path="destinationId" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md appearance-none">
                                    <form:option value="0" label="Chọn điểm đến" />
                                    <form:options items="${destinations}" itemValue="destinationId" itemLabel="destinationName" />
                                </form:select>
                                <form:errors path="destinationId" cssClass="field-error" />
                            </div>
                            <div>
                                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Thời lượng</label>
                                <form:input path="durationDays" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md" type="number" min="1" />
                                <form:errors path="durationDays" cssClass="field-error" />
                            </div>
                        </div>
                        <div>
                            <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Mô tả Tour</label>
                            <form:textarea path="description" cssClass="w-full p-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md resize-none" rows="6" />
                        </div>
                    </div>
                </form:form>
            </section>

            <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                    <span class="material-symbols-outlined">payments</span>
                    <h3 class="font-headline-md text-headline-md">Giá cả &amp; Hậu cần</h3>
                </div>
                <div class="grid grid-cols-3 gap-6">
                    <div>
                        <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Giá cơ bản</label>
                        <form:input form="tour-form" path="price" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md" type="number" step="0.01" min="0" />
                        <form:errors path="price" cssClass="field-error" />
                    </div>
                    <div>
                        <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Sức chứa tối đa</label>
                        <form:input form="tour-form" path="maxCapacity" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md" type="number" min="1" />
                        <form:errors path="maxCapacity" cssClass="field-error" />
                    </div>
                    <div>
                        <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Hạng mục</label>
                        <select form="tour-form" class="w-full h-12 px-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md">
                            <option>Sang trọng</option>
                            <option>Phiêu lưu</option>
                            <option>Gia đình</option>
                            <option>Du lịch sinh thái</option>
                        </select>
                    </div>
                </div>
            </section>
        </div>

        <div class="col-span-4 space-y-gutter">
            <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)] h-full">
                <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                    <span class="material-symbols-outlined">image</span>
                    <h3 class="font-headline-md text-headline-md">Bộ sưu tập hình ảnh</h3>
                </div>
                <div class="border-2 border-dashed border-outline-variant rounded-xl p-8 flex flex-col items-center justify-center text-center bg-surface-bright mb-6">
                    <div class="w-16 h-16 bg-ocean-blue/10 text-ocean-blue rounded-full flex items-center justify-center mb-4">
                        <span class="material-symbols-outlined text-[32px]">cloud_upload</span>
                    </div>
                    <p class="font-label-md text-label-md text-on-surface mb-1">Nhập đường dẫn ảnh cho tour</p>
                    <p class="font-label-sm text-label-sm text-on-surface-variant">Lưu ý: bạn có thể nhập `imageUrl` thủ công</p>
                </div>
                <div>
                    <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Image URL</label>
                    <form:input form="tour-form" path="imageUrl" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md" />
                </div>
            </section>

            <section class="glass-card rounded-xl p-6 shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
                <div class="flex items-center gap-2 mb-6 text-ocean-blue">
                    <span class="material-symbols-outlined">schedule</span>
                    <h3 class="font-headline-md text-headline-md">Ngày bắt đầu</h3>
                </div>
                <div class="space-y-4">
                    <div>
                        <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Start Date</label>
                        <form:input form="tour-form" path="startDate" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md" type="date" />
                    </div>
                    <div>
                        <label class="block font-label-md text-label-md text-on-surface-variant mb-2">End Date</label>
                        <form:input form="tour-form" path="endDate" cssClass="w-full h-12 px-4 bg-surface-gray border-none rounded-lg text-body-md font-body-md" type="date" />
                    </div>
                </div>
            </section>
        </div>
    </div>

    <footer class="mt-8 pt-8 border-t border-outline-variant flex justify-end gap-4">
        <a class="px-8 py-3 rounded-lg border border-outline-variant text-on-surface-variant font-label-md text-label-md hover:bg-surface-container transition-all" href="<c:url value='/tour/list'/>">Hủy bản nháp</a>
        <button form="tour-form" class="px-10 py-3 rounded-lg bg-action-orange text-white font-label-md text-label-md shadow-lg hover:shadow-xl hover:-translate-y-0.5 active:translate-y-0 transition-all flex items-center gap-2" type="submit">
            <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">save</span>
            Xuất bản Tour
        </button>
    </footer>
</main>
</div>
</body>
</html>
