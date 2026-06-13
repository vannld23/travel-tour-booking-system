<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Đặt Tour Thủ Công - VoyagerElite Admin</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "ocean-blue":         "#0194F3",
                        "deep-navy":          "#05285D",
                        "surface-gray":       "#F2F3F3",
                        "surface-bright":     "#f8f9f9",
                        "surface-container":  "#edeeee",
                        "outline-variant":    "#bfc7d4",
                        "on-surface":         "#191c1c",
                        "on-surface-variant": "#3f4752",
                        "action-orange":      "#FF5E1F",
                        "status-success":     "#00BA4A",
                        "status-warning":     "#F39C12"
                    }
                }
            }
        };
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .glass-card { background: rgba(255,255,255,0.95); backdrop-filter: blur(8px); border: 1px solid rgba(224,224,224,0.5); }
        input:focus, select:focus {
            outline: none;
            border-color: #0194F3;
            box-shadow: 0 0 0 2px rgba(1, 148, 243, 0.1);
        }
    </style>
</head>
<body class="bg-surface-gray min-h-screen text-on-surface">
<div class="flex min-h-screen">
    <%@ include file="../../admin/layout/sidebar.jsp" %>

    <!-- Main Content Canvas -->
    <main class="ml-[280px] flex-1 pt-16 min-h-screen">
        <!-- TopAppBar -->
        <header class="flex justify-between items-center w-[calc(100%-280px)] px-8 h-16 bg-white border-b border-outline-variant fixed top-0 right-0 z-30">
            <div class="flex items-center gap-4">
                <h2 class="text-xl font-bold text-deep-navy">Tạo Đơn Đặt Tour Thủ Công</h2>
            </div>
            <div class="flex items-center gap-6">
                <div class="flex items-center gap-4 text-on-surface-variant">
                    <div class="flex items-center gap-2 cursor-pointer hover:bg-gray-100 p-1 rounded-lg transition-colors">
                        <div class="w-8 h-8 rounded-full bg-ocean-blue flex items-center justify-center text-white font-bold text-xs">
                            AD
                        </div>
                        <span class="text-sm font-semibold hidden md:block">Admin User</span>
                    </div>
                </div>
            </div>
        </header>

        <div class="max-w-5xl mx-auto p-8">
            <form action="<c:url value='/booking/create'/>" method="POST" class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Left Column: Form Details -->
                <div class="lg:col-span-2 space-y-6">
                    <!-- 1. Thông tin Tour -->
                    <section class="bg-white rounded-xl p-8 glass-card border border-outline-variant/30 shadow-sm">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="w-10 h-10 bg-ocean-blue/10 text-ocean-blue rounded-full flex items-center justify-center">
                                <span class="material-symbols-outlined">map</span>
                            </div>
                            <h3 class="text-lg font-bold text-deep-navy">1. Thông tin Tour</h3>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="md:col-span-2">
                                <label class="block text-sm font-semibold mb-2 text-on-surface-variant">Chọn Tour du lịch</label>
                                <select id="tourSelect" name="tourId" required onchange="calculateTotal()"
                                        class="w-full p-3 bg-surface-bright border border-outline-variant rounded-lg text-sm focus:bg-white transition-all">
                                    <option value="">-- Chọn tour du lịch --</option>
                                    <c:forEach var="tour" items="${tours}">
                                        <option value="${tour.tourId}" data-price="${tour.price}" data-date="${tour.startDate}">
                                            ${tour.tourName} - <fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold mb-2 text-on-surface-variant">Ngày khởi hành</label>
                                <input id="startDateInput" class="w-full p-3 bg-surface-bright border border-outline-variant rounded-lg text-sm focus:bg-white transition-all" type="text" readonly placeholder="Chọn tour để xem ngày khởi hành"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold mb-2 text-on-surface-variant">Số lượng khách hàng</label>
                                <input id="peopleInput" name="numberOfPeople" class="w-full p-3 bg-surface-bright border border-outline-variant rounded-lg text-sm focus:bg-white transition-all" min="1" type="number" value="1" required oninput="calculateTotal()"/>
                            </div>
                        </div>
                    </section>

                    <!-- 2. Thông tin Khách hàng -->
                    <section class="bg-white rounded-xl p-8 glass-card border border-outline-variant/30 shadow-sm">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="w-10 h-10 bg-ocean-blue/10 text-ocean-blue rounded-full flex items-center justify-center">
                                <span class="material-symbols-outlined">person</span>
                            </div>
                            <h3 class="text-lg font-bold text-deep-navy">2. Thông tin Người đặt</h3>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="md:col-span-2">
                                <label class="block text-sm font-semibold mb-2 text-on-surface-variant">Chọn khách hàng từ danh sách</label>
                                <select id="userSelect" name="userId" required onchange="updateCustomerDetails()"
                                        class="w-full p-3 bg-surface-bright border border-outline-variant rounded-lg text-sm focus:bg-white transition-all">
                                    <option value="">-- Chọn khách hàng đặt tour --</option>
                                    <c:forEach var="user" items="${users}">
                                        <option value="${user.userId}" data-phone="${user.phone}" data-email="${user.email}" data-fullname="${user.fullName}">
                                            ${user.fullName} (${user.email})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold mb-2 text-on-surface-variant">Số điện thoại</label>
                                <input id="phoneInput" class="w-full p-3 bg-surface-bright border border-outline-variant rounded-lg text-sm focus:bg-white cursor-not-allowed" type="text" readonly placeholder="Tự động điền"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold mb-2 text-on-surface-variant">Email</label>
                                <input id="emailInput" class="w-full p-3 bg-surface-bright border border-outline-variant rounded-lg text-sm focus:bg-white cursor-not-allowed" type="email" readonly placeholder="Tự động điền"/>
                            </div>
                        </div>
                    </section>

                    <!-- 3. Ghi chú & Trạng thái -->
                    <section class="bg-white rounded-xl p-8 glass-card border border-outline-variant/30 shadow-sm">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="w-10 h-10 bg-ocean-blue/10 text-ocean-blue rounded-full flex items-center justify-center">
                                <span class="material-symbols-outlined">info</span>
                            </div>
                            <h3 class="text-lg font-bold text-deep-navy">3. Thiết lập mặc định</h3>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-semibold mb-2 text-on-surface-variant">Trạng thái đặt chỗ ban đầu</label>
                                <select name="bookingStatus" class="w-full p-3 bg-gray-100 border border-outline-variant rounded-lg text-sm focus:bg-white transition-all cursor-not-allowed" readonly>
                                    <option value="PENDING" selected>Chờ xác nhận (Chưa thanh toán)</option>
                                </select>
                            </div>
                            <div class="flex items-center">
                                <p class="text-xs text-on-surface-variant leading-relaxed italic mt-6">
                                    * Đơn hàng đặt thủ công sẽ được đặt ở trạng thái <strong>Chờ xác nhận</strong>. Sau khi khách hàng thanh toán thành công, Admin có thể tiến hành xác nhận đơn.
                                </p>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- Right Column: Payment & Summary -->
                <div class="space-y-6">
                    <!-- 4. Tổng kết chi phí -->
                    <section class="bg-deep-navy text-white rounded-xl p-6 shadow-xl relative overflow-hidden">
                        <!-- Subtle background pattern decoration -->
                        <div class="absolute -right-10 -bottom-10 opacity-10">
                            <span class="material-symbols-outlined text-[160px]">travel_explore</span>
                        </div>
                        <h3 class="text-base font-bold mb-6 flex items-center gap-2 relative z-10">
                            <span class="material-symbols-outlined">receipt_long</span>
                            Tổng kết đơn hàng
                        </h3>
                        <div class="space-y-4 relative z-10">
                            <div class="flex justify-between text-sm text-surface-gray/80">
                                <span>Giá tour / khách</span>
                                <span id="tourPriceLabel" class="font-semibold text-white">0đ</span>
                            </div>
                            <div class="flex justify-between text-sm text-surface-gray/80">
                                <span>Số lượng khách</span>
                                <span id="peopleCountLabel" class="font-semibold text-white">1 người</span>
                            </div>
                            <div class="pt-4 border-t border-white/20 mt-4">
                                <div class="flex justify-between items-end">
                                    <span class="text-xs text-surface-gray/70 uppercase tracking-wider">Tổng cộng</span>
                                    <span id="totalPriceLabel" class="text-2xl font-bold text-action-orange">0đ</span>
                                </div>
                            </div>
                        </div>
                        <div class="mt-8 space-y-3 relative z-10">
                            <button type="submit"
                                    class="w-full bg-action-orange hover:bg-orange-600 text-white font-bold py-4 rounded-lg shadow-lg active:scale-[0.98] transition-all flex items-center justify-center gap-2">
                                <span class="material-symbols-outlined">check_circle</span>
                                TẠO ĐƠN ĐẶT TOUR
                            </button>
                            <a href="<c:url value='/booking/list'/>"
                               class="block text-center w-full bg-white/10 hover:bg-white/20 text-white font-medium py-3 rounded-lg transition-all">
                                Hủy bỏ
                            </a>
                        </div>
                    </section>

                    <!-- Help Tooltip -->
                    <div class="bg-blue-50/50 p-4 rounded-lg border border-blue-100 flex gap-3 text-sm">
                        <span class="material-symbols-outlined text-ocean-blue">info</span>
                        <p class="text-xs text-on-surface-variant leading-relaxed">
                            Lưu ý: Sau khi tạo đơn, hệ thống sẽ lưu thông tin với trạng thái <strong>Chờ xác nhận</strong>. Admin có thể xem chi tiết hoặc đổi trạng thái đơn đặt chỗ tại màn hình quản lý.
                        </p>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>

<script>
    // Cập nhật thông tin khách hàng từ dropdown
    function updateCustomerDetails() {
        const select = document.getElementById('userSelect');
        const selectedOption = select.options[select.selectedIndex];

        if (select.value === "") {
            document.getElementById('phoneInput').value = "";
            document.getElementById('emailInput').value = "";
            return;
        }

        const phone = selectedOption.getAttribute('data-phone');
        const email = selectedOption.getAttribute('data-email');

        document.getElementById('phoneInput').value = phone ? phone : "Chưa cập nhật";
        document.getElementById('emailInput').value = email ? email : "";
    }

    // Tính toán tổng số tiền dựa trên đơn giá tour và số lượng khách
    function calculateTotal() {
        const tourSelect = document.getElementById('tourSelect');
        const selectedOption = tourSelect.options[tourSelect.selectedIndex];
        
        if (tourSelect.value === "") {
            document.getElementById('startDateInput').value = "";
            document.getElementById('tourPriceLabel').innerText = "0đ";
            document.getElementById('totalPriceLabel').innerText = "0đ";
            return;
        }

        const price = parseFloat(selectedOption.getAttribute('data-price'));
        const date = selectedOption.getAttribute('data-date');
        const numPeople = parseInt(document.getElementById('peopleInput').value) || 1;

        // Hiển thị ngày khởi hành
        document.getElementById('startDateInput').value = date ? date : "Chưa cập nhật";

        // Định dạng VND
        const formatter = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' });
        
        document.getElementById('tourPriceLabel').innerText = formatter.format(price);
        document.getElementById('peopleCountLabel').innerText = numPeople + " người";
        
        const total = price * numPeople;
        document.getElementById('totalPriceLabel').innerText = formatter.format(total);
    }
</script>
</body>
</html>
