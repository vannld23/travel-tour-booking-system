<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản trị VoyagerElite - Quản lý Tour</title>

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

        /* Thumbnail hình ảnh trong bảng */
        .tour-thumb { width: 56px; height: 56px; object-fit: cover; border-radius: 8px; border: 2px solid #e5e7eb; }
        .tour-thumb-placeholder {
            width: 56px; height: 56px; border-radius: 8px; border: 2px dashed #bfc7d4;
            display: flex; align-items: center; justify-content: center; color: #bfc7d4; font-size: 24px;
        }

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
                    <span class="text-ocean-blue font-semibold">Quản lý Tour</span>
                </nav>
                <h2 class="text-3xl font-bold text-deep-navy">Danh sách Tour Du lịch</h2>
            </div>
            <a id="btn-add-tour"
               class="flex items-center gap-2 px-5 py-2.5 rounded-lg bg-ocean-blue text-white font-medium shadow hover:brightness-110 transition-all"
               href="<c:url value='/tuormanagement/create'/>">
                <span class="material-symbols-outlined text-base">add_circle</span>
                Thêm Tour mới
            </a>
        </div>

        <!-- ══ Bộ lọc tìm kiếm ═══════════════════════════════════════════════ -->
        <section class="glass-card rounded-xl p-5 mb-6 shadow-sm">
            <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                <span class="material-symbols-outlined">filter_list</span>
                <h3 class="font-semibold text-on-surface">Tìm kiếm & Bộ lọc nâng cao</h3>
            </div>

            <form id="form-search" method="get" action="<c:url value='/tuormanagement/list'/>" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-4">
                <!-- Inputs ẩn giữ trạng thái phân trang, sắp xếp -->
                <input type="hidden" id="input-page" name="page" value="${currentPage}"/>
                <input type="hidden" id="input-sortBy" name="sortBy" value="${sortBy}"/>
                <input type="hidden" id="input-sortDir" name="sortDir" value="${sortDir}"/>

                <!-- Từ khóa -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Từ khóa</label>
                    <div class="relative">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline-variant text-base">search</span>
                        <input id="input-keyword" type="text" name="keyword" value="${filterKeyword}"
                               placeholder="Tên tour, mô tả..."
                               class="w-full pl-9 pr-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue"/>
                    </div>
                </div>

                <!-- Lọc Điểm đến -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Điểm đến</label>
                    <select id="select-destination" name="destinationId"
                            class="w-full px-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue">
                        <option value="">-- Tất cả điểm đến --</option>
                        <c:forEach var="dest" items="${destinations}">
                            <option value="${dest.destinationId}" ${filterDestinationId == dest.destinationId ? 'selected' : ''}>
                                ${dest.destinationName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Giá tối đa -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Giá tối đa ($)</label>
                    <input id="input-maxPrice" type="number" name="maxPrice" value="${filterMaxPrice}"
                           placeholder="vd: 5000" min="0" step="0.01"
                           class="w-full px-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue"/>
                </div>

                <!-- Số ngày tối đa -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Số ngày tối đa</label>
                    <input id="input-maxDurationDays" type="number" name="maxDurationDays" value="${filterMaxDurationDays}"
                           placeholder="vd: 7" min="1"
                           class="w-full px-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue"/>
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
                <div class="lg:col-span-5 flex gap-3 justify-end mt-2">
                    <a id="btn-clear-filter" href="<c:url value='/tuormanagement/list'/>"
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
                    <span class="material-symbols-outlined">explore</span>
                    <h3 class="text-lg font-semibold text-on-surface">Danh sách Tour</h3>
                </div>
                <span class="text-sm text-on-surface-variant font-medium">
                    Hiển thị <strong>${tours.size()}</strong> / <strong>${totalItems}</strong> kết quả
                </span>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full border-collapse text-sm">
                    <thead>
                        <tr class="bg-deep-navy text-white text-left text-xs uppercase tracking-wide">
                            <th class="p-3 w-14 text-center">Ảnh</th>
                            <th class="p-3 sort-header" onclick="changeSort('tourName')">
                                <div class="flex items-center gap-1">
                                    Tên Tour
                                    <span class="material-symbols-outlined text-sm">
                                        ${sortBy == 'tourName' ? (sortDir == 'ASC' ? 'arrow_upward' : 'arrow_downward') : 'import_export'}
                                    </span>
                                </div>
                            </th>
                            <th class="p-3 sort-header" onclick="changeSort('destinationName')">
                                <div class="flex items-center gap-1">
                                    Điểm đến
                                    <span class="material-symbols-outlined text-sm">
                                        ${sortBy == 'destinationName' ? (sortDir == 'ASC' ? 'arrow_upward' : 'arrow_downward') : 'import_export'}
                                    </span>
                                </div>
                            </th>
                            <th class="p-3 sort-header" onclick="changeSort('price')">
                                <div class="flex items-center gap-1">
                                    Giá
                                    <span class="material-symbols-outlined text-sm">
                                        ${sortBy == 'price' ? (sortDir == 'ASC' ? 'arrow_upward' : 'arrow_downward') : 'import_export'}
                                    </span>
                                </div>
                            </th>
                            <th class="p-3 sort-header" onclick="changeSort('durationDays')">
                                <div class="flex items-center gap-1">
                                    Số ngày
                                    <span class="material-symbols-outlined text-sm">
                                        ${sortBy == 'durationDays' ? (sortDir == 'ASC' ? 'arrow_upward' : 'arrow_downward') : 'import_export'}
                                    </span>
                                </div>
                            </th>
                            <th class="p-3 text-center sort-header" onclick="changeSort('bookingCount')">
                                <div class="flex items-center justify-center gap-1">
                                    Đơn đặt
                                    <span class="material-symbols-outlined text-sm">
                                        ${sortBy == 'bookingCount' ? (sortDir == 'ASC' ? 'arrow_upward' : 'arrow_downward') : 'import_export'}
                                    </span>
                                </div>
                            </th>
                            <th class="p-3 text-center">Trạng thái</th>
                            <th class="p-3 text-center w-40">Hành động</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100">
                        <c:if test="${empty tours}">
                            <tr>
                                <td colspan="8" class="py-12 text-center text-on-surface-variant">
                                    <span class="material-symbols-outlined text-4xl text-outline-variant block mb-2">explore_off</span>
                                    Không tìm thấy tour du lịch nào phù hợp.
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach var="tour" items="${tours}">
                            <tr class="hover:bg-blue-50/40 transition-colors">

                                <!-- Ảnh thumbnail -->
                                <td class="p-3 text-center">
                                    <c:choose>
                                        <c:when test="${not empty tour.imageUrl}">
                                            <img src="${tour.imageUrl}"
                                                 alt="${tour.tourName}"
                                                 class="tour-thumb mx-auto"
                                                 onerror="this.style.display='none';this.nextElementSibling.style.display='flex'"/>
                                            <div class="tour-thumb-placeholder mx-auto" style="display:none;">
                                                <span class="material-symbols-outlined">broken_image</span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="tour-thumb-placeholder mx-auto">
                                                <span class="material-symbols-outlined">image</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- Tên tour -->
                                <td class="p-3">
                                    <div class="font-semibold text-on-surface">${tour.tourName}</div>
                                    <div class="text-xs text-on-surface-variant mt-0.5 max-w-[250px] line-clamp-1">${tour.description}</div>
                                </td>

                                <!-- Điểm đến -->
                                <td class="p-3 text-on-surface-variant">${tour.destinationName}</td>

                                <!-- Giá -->
                                <td class="p-3 font-semibold text-deep-navy">
                                    <fmt:formatNumber value="${tour.price}" type="currency" currencySymbol="$"/>
                                </td>

                                <!-- Số ngày -->
                                <td class="p-3 text-on-surface-variant">${tour.durationDays} ngày</td>

                                <!-- Số lượt đặt tour -->
                                <td class="p-3 text-center">
                                    <span class="inline-flex items-center gap-1 font-bold text-deep-navy">
                                        <span class="material-symbols-outlined text-[16px] text-ocean-blue">confirmation_number</span>
                                        ${tour.bookingCount}
                                    </span>
                                </td>

                                <!-- Badge Trạng thái -->
                                <td class="p-3 text-center">
                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold ${tour.statusBadgeClass}">
                                        <c:choose>
                                            <c:when test="${tour.status.name() == 'ACTIVE'}">
                                                <span class="material-symbols-outlined text-[14px]">check_circle</span>
                                            </c:when>
                                            <c:when test="${tour.status.name() == 'INACTIVE'}">
                                                <span class="material-symbols-outlined text-[14px]">cancel</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="material-symbols-outlined text-[14px]">schedule</span>
                                            </c:otherwise>
                                        </c:choose>
                                        ${tour.statusLabel}
                                    </span>
                                </td>

                                <!-- Các nút hành động -->
                                <td class="p-3">
                                    <div class="flex justify-center items-center gap-1.5">
                                        <!-- Xem chi tiết -->
                                        <a class="btn-action btn-view"
                                           href="<c:url value='/tuormanagement/detail'><c:param name='id' value='${tour.tourId}'/></c:url>"
                                           title="Xem chi tiết">
                                            <span class="material-symbols-outlined text-[15px]">visibility</span>
                                        </a>
                                        <!-- Sửa -->
                                        <a class="btn-action btn-edit"
                                           href="<c:url value='/tuormanagement/edit'><c:param name='id' value='${tour.tourId}'/></c:url>"
                                           title="Chỉnh sửa">
                                            <span class="material-symbols-outlined text-[15px]">edit</span>
                                        </a>
                                        <!-- Xóa -->
                                        <a class="btn-action btn-delete"
                                           href="<c:url value='/tuormanagement/delete'><c:param name='id' value='${tour.tourId}'/></c:url>"
                                           title="Xóa tour">
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

<!-- ══ SCRIPT ĐIỀU HƯỚNG PHÂN TRANG & SẮP XẾP ═══════════════════════════ -->
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
</script>
</body>
</html>
