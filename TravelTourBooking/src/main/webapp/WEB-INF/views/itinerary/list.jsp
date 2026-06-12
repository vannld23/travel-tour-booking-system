<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản trị VoyagerElite - Quản lý Lịch trình</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "ocean-blue":          "#0194F3",
                        "deep-navy":           "#05285D",
                        "surface-gray":        "#F2F3F3",
                        "surface-bright":      "#f8f9f9",
                        "surface-container":   "#edeeee",
                        "outline-variant":     "#bfc7d4",
                        "on-surface":          "#191c1c",
                        "on-surface-variant":  "#3f4752",
                        "action-orange":       "#FF5E1F"
                    }
                }
            }
        };
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .glass-card { background: rgba(255,255,255,0.95); backdrop-filter: blur(8px); border: 1px solid rgba(224,224,224,0.5); }

        /* Badge trạng thái */
        .badge-active   { background: #D1FAE5; color: #065F46; }
        .badge-inactive { background: #FEE2E2; color: #991B1B; }
        .badge-upcoming { background: #FEF3C7; color: #92400E; }

        /* Action buttons */
        .btn-action { display: inline-flex; align-items: center; gap: 4px; padding: 6px 10px;
                      border-radius: 8px; font-size: 12px; font-weight: 500; transition: all .15s; text-decoration: none; }
        .btn-view   { background: #E0F2FE; color: #0369A1; }
        .btn-view:hover   { background: #BAE6FD; }
        .btn-edit   { background: #0194F3; color: #fff; }
        .btn-edit:hover   { filter: brightness(1.1); }
        .btn-delete { background: #FF5E1F; color: #fff; }
        .btn-delete:hover { filter: brightness(1.1); }

        /* Sortable headers */
        .sort-header { cursor: pointer; user-select: none; transition: background .15s; }
        .sort-header:hover { background-color: rgba(255,255,255,0.1); }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
    <%@ include file="../layout/sidebar.jsp" %>

    <main class="flex-1 ml-[280px] p-8 min-h-screen">

        <!-- ══ Header ════════════════════════════════════════════════════════ -->
        <div class="flex justify-between items-center mb-6">
            <div>
                <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-1">
                    <span class="material-symbols-outlined text-[14px]">home</span>
                    <span class="text-ocean-blue font-semibold">Quản lý Lịch trình</span>
                </nav>
                <h2 class="text-3xl font-bold text-deep-navy">Danh sách Lịch trình Tour</h2>
            </div>
            <a id="btn-add-itinerary"
               class="flex items-center gap-2 px-5 py-2.5 rounded-lg bg-ocean-blue text-white font-medium shadow hover:brightness-110 transition-all"
               href="<c:url value='/itinerary/create'/>">
                <span class="material-symbols-outlined text-base">add_circle</span>
                Thêm Lịch trình mới
            </a>
        </div>

        <!-- ══ Bộ lọc tìm kiếm ═══════════════════════════════════════════════ -->
        <section class="glass-card rounded-xl p-5 mb-6 shadow-sm">
            <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                <span class="material-symbols-outlined">filter_list</span>
                <h3 class="font-semibold text-on-surface">Tìm kiếm & Bộ lọc Lịch trình</h3>
            </div>

            <form id="form-search" method="get" action="<c:url value='/itinerary/list'/>" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                <!-- Inputs ẩn giữ trạng thái phân trang, sắp xếp -->
                <input type="hidden" id="input-page" name="page" value="${currentPage}"/>
                <input type="hidden" id="input-sortBy" name="sortBy" value="${sortBy}"/>
                <input type="hidden" id="input-sortDir" name="sortDir" value="${sortDir}"/>

                <!-- Lọc Tour -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Tour Du lịch</label>
                    <select id="select-tour" name="tourId"
                            class="w-full px-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue">
                        <option value="">-- Tất cả Tour --</option>
                        <c:forEach var="t" items="${tours}">
                            <option value="${t.tourId}" ${filterTourId == t.tourId ? 'selected' : ''}>
                                ${t.tourName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Lọc số ngày -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Ngày số</label>
                    <input id="input-dayNumber" type="number" name="dayNumber" value="${filterDayNumber}"
                           placeholder="vd: 1, 2..." min="1"
                           class="w-full px-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue"/>
                </div>

                <!-- Lọc từ khóa hoạt động -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Từ khóa hoạt động</label>
                    <div class="relative">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline-variant text-base">search</span>
                        <input id="input-keyword" type="text" name="keyword" value="${filterKeyword}"
                               placeholder="Tìm hoạt động..."
                               class="w-full pl-9 pr-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue"/>
                    </div>
                </div>

                <!-- Lọc Trạng thái -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Trạng thái</label>
                    <select id="select-status" name="status"
                            class="w-full px-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue">
                        <option value="">-- Tất cả trạng thái --</option>
                        <c:forEach var="s" items="${statuses}">
                            <option value="${s.name()}" ${filterStatus == s.name() ? 'selected' : ''}>
                                ${s.label}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Nút tìm và xóa bộ lọc -->
                <div class="lg:col-span-4 flex gap-3 justify-end mt-2">
                    <a id="btn-clear-filter" href="<c:url value='/itinerary/list'/>"
                       class="flex items-center gap-1 px-4 py-2 rounded-lg border border-outline-variant text-on-surface-variant text-sm hover:bg-surface-container transition-all">
                        <span class="material-symbols-outlined text-base">close</span> Xóa bộ lọc
                    </a>
                    <button id="btn-search" type="submit" onclick="document.getElementById('input-page').value = 1;"
                            class="flex items-center gap-2 px-5 py-2 rounded-lg bg-deep-navy text-white text-sm font-semibold hover:brightness-110 transition-all">
                        <span class="material-symbols-outlined text-base">search</span> Tìm kiếm
                    </button>
                </div>
            </form>
        </section>

        <!-- ══ Bảng danh sách ════════════════════════════════════════════════ -->
        <section class="glass-card rounded-xl p-6 shadow-sm">
            <div class="flex items-center justify-between mb-4">
                <div class="flex items-center gap-2 text-ocean-blue">
                    <span class="material-symbols-outlined">calendar_month</span>
                    <h3 class="text-lg font-semibold text-on-surface">Chi tiết Lịch trình</h3>
                </div>
                <span class="text-sm text-on-surface-variant font-medium">
                    Hiển thị <strong>${itineraries.size()}</strong> / <strong>${totalItems}</strong> kết quả
                </span>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full border-collapse text-sm">
                    <thead>
                        <tr class="bg-deep-navy text-white text-left text-xs uppercase tracking-wide">
                            <th class="p-3 sort-header w-20" onclick="changeSort('itineraryId')">
                                <div class="flex items-center gap-1">
                                    ID
                                    <span class="material-symbols-outlined text-sm">
                                        ${sortBy == 'itineraryId' ? (sortDir == 'ASC' ? 'arrow_upward' : 'arrow_downward') : 'import_export'}
                                    </span>
                                </div>
                            </th>
                            <th class="p-3 sort-header" onclick="changeSort('tourName')">
                                <div class="flex items-center gap-1">
                                    Tour Du lịch &amp; Điểm đến
                                    <span class="material-symbols-outlined text-sm">
                                        ${sortBy == 'tourName' ? (sortDir == 'ASC' ? 'arrow_upward' : 'arrow_downward') : 'import_export'}
                                    </span>
                                </div>
                            </th>
                            <th class="p-3 sort-header w-32 text-center" onclick="changeSort('dayNumber')">
                                <div class="flex items-center justify-center gap-1">
                                    Ngày thứ
                                    <span class="material-symbols-outlined text-sm">
                                        ${sortBy == 'dayNumber' ? (sortDir == 'ASC' ? 'arrow_upward' : 'arrow_downward') : 'import_export'}
                                    </span>
                                </div>
                            </th>
                            <th class="p-3 sort-header" onclick="changeSort('activityDescription')">
                                <div class="flex items-center gap-1">
                                    Mô tả hoạt động
                                    <span class="material-symbols-outlined text-sm">
                                        ${sortBy == 'activityDescription' ? (sortDir == 'ASC' ? 'arrow_upward' : 'arrow_downward') : 'import_export'}
                                    </span>
                                </div>
                            </th>
                            <th class="p-3 text-center w-36">Trạng thái</th>
                            <th class="p-3 text-center w-32">Hành động</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100">
                        <c:if test="${empty itineraries}">
                            <tr>
                                <td colspan="6" class="py-12 text-center text-on-surface-variant">
                                    <span class="material-symbols-outlined text-4xl text-outline-variant block mb-2">calendar_today</span>
                                    Chưa có lịch trình nào được thiết lập phù hợp.
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach var="it" items="${itineraries}">
                            <tr class="hover:bg-blue-50/40 transition-colors">
                                <!-- ID -->
                                <td class="p-3 text-on-surface-variant font-medium">${it.itineraryId}</td>

                                <!-- Tour Name + Destination Name -->
                                <td class="p-3">
                                    <div class="font-semibold text-on-surface">${it.tourName}</div>
                                    <div class="text-xs text-ocean-blue flex items-center gap-0.5 mt-0.5">
                                        <span class="material-symbols-outlined text-[13px]">pin_drop</span>
                                        ${not empty it.destinationName ? it.destinationName : 'Chưa định vị'}
                                    </div>
                                </td>

                                <!-- Day Number -->
                                <td class="p-3 text-center">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full bg-surface-container text-deep-navy font-bold text-xs">
                                        Ngày ${it.dayNumber}
                                    </span>
                                </td>

                                <!-- Activity Description (Truncated & View button) -->
                                <td class="p-3">
                                    <div class="flex flex-col gap-1 max-w-[320px]">
                                        <p class="text-on-surface-variant line-clamp-2 leading-relaxed text-xs">
                                            ${it.activityDescription}
                                        </p>
                                        <button type="button"
                                                onclick="openActivityModal('${it.dayNumber}', '${it.tourName}', '${it.destinationName}', `${it.activityDescription}`)"
                                                class="text-xs text-ocean-blue hover:underline font-medium text-left flex items-center gap-0.5 self-start">
                                            <span class="material-symbols-outlined text-sm">visibility</span> Xem chi tiết
                                        </button>
                                    </div>
                                </td>

                                <!-- Trạng thái -->
                                <td class="p-3 text-center">
                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold ${it.statusBadgeClass}">
                                        <c:choose>
                                            <c:when test="${it.status.name() == 'ACTIVE'}">
                                                <span class="material-symbols-outlined text-[14px]">check_circle</span>
                                            </c:when>
                                            <c:when test="${it.status.name() == 'INACTIVE'}">
                                                <span class="material-symbols-outlined text-[14px]">cancel</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="material-symbols-outlined text-[14px]">schedule</span>
                                            </c:otherwise>
                                        </c:choose>
                                        ${it.statusLabel}
                                    </span>
                                </td>

                                <!-- Nút hành động -->
                                <td class="p-3">
                                    <div class="flex justify-center items-center gap-1.5">
                                        <!-- Sửa -->
                                        <a class="btn-action btn-edit"
                                           href="<c:url value='/itinerary/edit'><c:param name='id' value='${it.itineraryId}'/></c:url>"
                                           title="Chỉnh sửa">
                                            <span class="material-symbols-outlined text-[15px]">edit</span>
                                        </a>
                                        <!-- Xóa -->
                                        <a class="btn-action btn-delete"
                                           href="<c:url value='/itinerary/delete'><c:param name='id' value='${it.itineraryId}'/></c:url>"
                                           title="Xóa lịch trình">
                                            <span class="material-symbols-outlined text-[15px]">delete</span>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- ══ PHÂN TRANG (Pagination UI) ══════════════════════════════════ -->
            <c:if test="${totalPages > 1}">
                <div class="flex items-center justify-between border-t border-gray-100 px-4 py-3 mt-6 sm:px-6">
                    <div class="flex flex-1 justify-between sm:hidden">
                        <button onclick="changePage(${currentPage - 1})" ${currentPage == 1 ? 'disabled' : ''}
                                class="relative inline-flex items-center rounded-md border border-outline-variant bg-white px-4 py-2 text-sm font-medium text-on-surface hover:bg-surface-bright disabled:opacity-50">
                            Trước
                        </button>
                        <button onclick="changePage(${currentPage + 1})" ${currentPage == totalPages ? 'disabled' : ''}
                                class="relative ml-3 inline-flex items-center rounded-md border border-outline-variant bg-white px-4 py-2 text-sm font-medium text-on-surface hover:bg-surface-bright disabled:opacity-50">
                            Sau
                        </button>
                    </div>
                    <div class="hidden sm:flex sm:flex-1 sm:items-center sm:justify-between">
                        <div>
                            <p class="text-xs text-on-surface-variant">
                                Trang <span class="font-semibold">${currentPage}</span> / <span class="font-semibold">${totalPages}</span> trang
                            </p>
                        </div>
                        <div>
                            <nav class="isolate inline-flex -space-x-px rounded-md shadow-sm" aria-label="Pagination">
                                <!-- Nút Trước -->
                                <button type="button" onclick="changePage(${currentPage - 1})" ${currentPage == 1 ? 'disabled' : ''}
                                        class="relative inline-flex items-center rounded-l-md px-2 py-2 text-on-surface-variant ring-1 ring-inset ring-outline-variant hover:bg-surface-bright focus:z-20 focus:outline-offset-0 disabled:opacity-50">
                                    <span class="material-symbols-outlined text-base">chevron_left</span>
                                </button>
                                
                                <!-- Số trang -->
                                <c:forEach var="p" begin="1" end="${totalPages}">
                                    <button type="button" onclick="changePage(${p})"
                                            class="relative inline-flex items-center px-4 py-2 text-sm font-semibold ${p == currentPage ? 'z-10 bg-ocean-blue text-white focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-ocean-blue' : 'text-on-surface ring-1 ring-inset ring-outline-variant hover:bg-surface-bright focus:z-20 focus:outline-offset-0'}">
                                        ${p}
                                    </button>
                                </c:forEach>
                                
                                <!-- Nút Sau -->
                                <button type="button" onclick="changePage(${currentPage + 1})" ${currentPage == totalPages ? 'disabled' : ''}
                                        class="relative inline-flex items-center rounded-r-md px-2 py-2 text-on-surface-variant ring-1 ring-inset ring-outline-variant hover:bg-surface-bright focus:z-20 focus:outline-offset-0 disabled:opacity-50">
                                    <span class="material-symbols-outlined text-base">chevron_right</span>
                                </button>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:if>

        </section>

    </main>
</div>

<!-- ══ POPUP MODAL XEM CHI TIẾT HOẠT ĐỘNG ════════════════════════════════ -->
<div id="activity-modal" class="fixed inset-0 z-50 hidden overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <!-- Overlay nền tối -->
        <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onclick="closeActivityModal()"></div>

        <!-- Căn giữa modal -->
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

        <!-- Card Modal chính -->
        <div class="inline-block align-middle bg-white rounded-xl text-left overflow-hidden shadow-2xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full border border-gray-100">
            <div class="bg-deep-navy px-6 py-4 flex justify-between items-center text-white">
                <div class="flex items-center gap-2">
                    <span class="material-symbols-outlined text-xl">calendar_today</span>
                    <h3 class="text-base font-bold" id="modal-title-day">Hoạt động Ngày</h3>
                </div>
                <button type="button" class="text-gray-400 hover:text-white transition-colors" onclick="closeActivityModal()">
                    <span class="material-symbols-outlined text-xl">close</span>
                </button>
            </div>
            
            <div class="bg-white px-6 pt-5 pb-4 sm:p-6 space-y-4">
                <div>
                    <h4 class="text-xs font-semibold text-on-surface-variant uppercase tracking-wider">Tour Du lịch</h4>
                    <p class="text-sm font-bold text-deep-navy mt-0.5" id="modal-tour-name"></p>
                </div>

                <div>
                    <h4 class="text-xs font-semibold text-on-surface-variant uppercase tracking-wider">Điểm đến địa phương</h4>
                    <p class="text-sm text-on-surface font-medium mt-0.5 flex items-center gap-1">
                        <span class="material-symbols-outlined text-[15px] text-ocean-blue">pin_drop</span>
                        <span id="modal-destination-name"></span>
                    </p>
                </div>

                <hr class="border-gray-100"/>

                <div>
                    <h4 class="text-xs font-semibold text-on-surface-variant uppercase tracking-wider">Nội dung chi tiết hoạt động</h4>
                    <p class="text-sm text-on-surface-variant leading-relaxed mt-2 whitespace-pre-line bg-surface-gray p-4 rounded-lg border border-gray-200" id="modal-description"></p>
                </div>
            </div>
            
            <div class="bg-surface-gray px-6 py-3 flex justify-end">
                <button type="button" onclick="closeActivityModal()"
                        class="px-5 py-2 rounded-lg bg-deep-navy text-white text-sm font-semibold hover:brightness-110 transition-all">
                    Đóng lại
                </button>
            </div>
        </div>
    </div>
</div>

<!-- ══ SCRIPT ĐIỀU HƯỚNG & ĐIỀU KHIỂN MODAL POPUP ═══════════════════════ -->
<script>
    function changePage(pageNum) {
        if (pageNum < 1 || pageNum > ${totalPages}) return;
        document.getElementById('input-page').value = pageNum;
        document.getElementById('form-search').submit();
    }

    function changeSort(column) {
        var currentSortBy = "${sortBy}";
        var currentSortDir = "${sortDir}";
        var newSortDir = "ASC";
        
        if (currentSortBy === column) {
            newSortDir = (currentSortDir === "ASC") ? "DESC" : "ASC";
        }
        
        document.getElementById('input-sortBy').value = column;
        document.getElementById('input-sortDir').value = newSortDir;
        document.getElementById('input-page').value = 1; // Reset về trang 1
        document.getElementById('form-search').submit();
    }

    // Modal popup logic
    function openActivityModal(day, tour, destination, description) {
        document.getElementById('modal-title-day').textContent = "Hoạt động Ngày " + day;
        document.getElementById('modal-tour-name').textContent = tour;
        document.getElementById('modal-destination-name').textContent = destination ? destination : "Chưa xác định";
        document.getElementById('modal-description').textContent = description;
        
        var modal = document.getElementById('activity-modal');
        modal.classList.remove('hidden');
        document.body.style.overflow = 'hidden'; // Ngăn cuộn trang chính
    }

    function closeActivityModal() {
        var modal = document.getElementById('activity-modal');
        modal.classList.add('hidden');
        document.body.style.overflow = 'auto'; // Cho phép cuộn lại
    }
</script>
</body>
</html>
