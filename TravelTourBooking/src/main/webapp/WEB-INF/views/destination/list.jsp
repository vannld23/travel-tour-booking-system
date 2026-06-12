<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản trị VoyagerElite - Quản lý Điểm đến</title>

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
        .dest-thumb { width: 56px; height: 56px; object-fit: cover; border-radius: 8px; border: 2px solid #e5e7eb; }
        .dest-thumb-placeholder {
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

        /* Row highlight */
        tbody tr { transition: background .1s; }
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
                    <span class="text-ocean-blue font-semibold">Quản lý Điểm đến</span>
                </nav>
                <h2 class="text-3xl font-bold text-deep-navy">Danh sách Điểm đến</h2>
            </div>
            <a id="btn-add-destination"
               class="flex items-center gap-2 px-5 py-2.5 rounded-lg bg-ocean-blue text-white font-medium shadow hover:brightness-110 transition-all"
               href="<c:url value='/destination/create'/>">
                <span class="material-symbols-outlined text-base">add_location_alt</span>
                Thêm Điểm đến mới
            </a>
        </div>

        <!-- ══ Bộ lọc tìm kiếm ═══════════════════════════════════════════════ -->
        <section class="glass-card rounded-xl p-5 mb-6 shadow-sm">
            <div class="flex items-center gap-2 mb-4 text-ocean-blue">
                <span class="material-symbols-outlined">filter_list</span>
                <h3 class="font-semibold text-on-surface">Tìm kiếm & Bộ lọc</h3>
            </div>

            <form id="form-search" method="get" action="<c:url value='/destination/list'/>" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">

                <!-- Từ khóa -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Từ khóa</label>
                    <div class="relative">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline-variant text-base">search</span>
                        <input id="input-keyword" type="text" name="keyword" value="${filterKeyword}"
                               placeholder="Tên điểm đến, mô tả..."
                               class="w-full pl-9 pr-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue"/>
                    </div>
                </div>

                <!-- Lọc Quốc gia -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Quốc gia</label>
                    <select id="select-country" name="country"
                            class="w-full px-3 py-2 rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue">
                        <option value="">-- Tất cả quốc gia --</option>
                        <c:forEach var="c" items="${countries}">
                            <option value="${c}" ${filterCountry == c ? 'selected' : ''}>${c}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Lọc Thành phố -->
                <div>
                    <label class="block text-xs font-semibold text-on-surface-variant mb-1">Thành phố</label>
                    <input id="input-city" type="text" name="city" value="${filterCity}"
                           placeholder="Tên thành phố..."
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
                <div class="lg:col-span-4 flex gap-3 justify-end">
                    <a id="btn-clear-filter" href="<c:url value='/destination/list'/>"
                       class="flex items-center gap-1 px-4 py-2 rounded-lg border border-outline-variant text-on-surface-variant text-sm hover:bg-surface-container transition-all">
                        <span class="material-symbols-outlined text-base">close</span> Xóa bộ lọc
                    </a>
                    <button id="btn-search" type="submit"
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
                    <span class="material-symbols-outlined">pin_drop</span>
                    <h3 class="text-lg font-semibold text-on-surface">Danh sách Điểm đến</h3>
                </div>
                <span class="text-sm text-on-surface-variant font-medium">
                    Tổng: <strong>${destinations.size()} kết quả</strong>
                </span>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full border-collapse text-sm">
                    <thead>
                        <tr class="bg-deep-navy text-white text-left text-xs uppercase tracking-wide">
                            <th class="p-3 w-14 text-center">Ảnh</th>
                            <th class="p-3">Tên Điểm đến</th>
                            <th class="p-3">Quốc gia</th>
                            <th class="p-3">Thành phố</th>
                            <th class="p-3 text-center">Trạng thái</th>
                            <th class="p-3 text-center">Lượt đặt</th>
                            <th class="p-3 text-center w-44">Hành động</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100">
                        <c:if test="${empty destinations}">
                            <tr>
                                <td colspan="7" class="py-12 text-center text-on-surface-variant">
                                    <span class="material-symbols-outlined text-4xl text-outline-variant block mb-2">search_off</span>
                                    Không tìm thấy điểm đến nào phù hợp.
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach var="dest" items="${destinations}">
                            <tr class="hover:bg-blue-50/40 transition-colors">

                                <!-- Ảnh thumbnail -->
                                <td class="p-3 text-center">
                                    <c:choose>
                                        <c:when test="${not empty dest.imageUrl}">
                                            <img src="${dest.imageUrl}"
                                                 alt="${dest.destinationName}"
                                                 class="dest-thumb mx-auto"
                                                 onerror="this.style.display='none';this.nextElementSibling.style.display='flex'"/>
                                            <div class="dest-thumb-placeholder mx-auto" style="display:none;">
                                                <span class="material-symbols-outlined">broken_image</span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="dest-thumb-placeholder mx-auto">
                                                <span class="material-symbols-outlined">image</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- Tên điểm đến -->
                                <td class="p-3">
                                    <div class="font-semibold text-on-surface">${dest.destinationName}</div>
                                    <div class="text-xs text-on-surface-variant mt-0.5 line-clamp-1 max-w-[200px]">${dest.description}</div>
                                </td>

                                <!-- Quốc gia -->
                                <td class="p-3 text-on-surface-variant">${dest.country}</td>

                                <!-- Thành phố -->
                                <td class="p-3 text-on-surface-variant">${dest.city}</td>

                                <!-- Badge Trạng thái -->
                                <td class="p-3 text-center">
                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold ${dest.statusBadgeClass}">
                                        <c:choose>
                                            <c:when test="${dest.status.name() == 'ACTIVE'}">
                                                <span class="material-symbols-outlined text-[14px]">check_circle</span>
                                            </c:when>
                                            <c:when test="${dest.status.name() == 'INACTIVE'}">
                                                <span class="material-symbols-outlined text-[14px]">cancel</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="material-symbols-outlined text-[14px]">schedule</span>
                                            </c:otherwise>
                                        </c:choose>
                                        ${dest.statusLabel}
                                    </span>
                                </td>

                                <!-- Số lượt đặt tour -->
                                <td class="p-3 text-center">
                                    <span class="inline-flex items-center gap-1 font-bold text-deep-navy">
                                        <span class="material-symbols-outlined text-[16px] text-ocean-blue">confirmation_number</span>
                                        ${dest.bookingCount}
                                    </span>
                                </td>

                                <!-- Các nút hành động -->
                                <td class="p-3">
                                    <div class="flex justify-center items-center gap-1.5">
                                        <!-- Xem chi tiết -->
                                        <a class="btn-action btn-view"
                                           href="<c:url value='/destination/detail'><c:param name='id' value='${dest.destinationId}'/></c:url>"
                                           title="Xem chi tiết">
                                            <span class="material-symbols-outlined text-[15px]">visibility</span>
                                        </a>
                                        <!-- Sửa -->
                                        <a class="btn-action btn-edit"
                                           href="<c:url value='/destination/edit'><c:param name='id' value='${dest.destinationId}'/></c:url>"
                                           title="Chỉnh sửa">
                                            <span class="material-symbols-outlined text-[15px]">edit</span>
                                        </a>
                                        <!-- Xóa -->
                                        <a class="btn-action btn-delete"
                                           href="<c:url value='/destination/delete'><c:param name='id' value='${dest.destinationId}'/></c:url>"
                                           title="Xóa điểm đến">
                                            <span class="material-symbols-outlined text-[15px]">delete</span>
                                        </a>
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
