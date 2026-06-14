<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Tạo thanh toán mới | VoyagerElite Admin</title>

        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
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
                            "action-orange": "#FF5E1F",
                            "status-success": "#00BA4A",
                            "status-warning": "#F39C12"
                        }
                    }
                }
            };
        </script>
        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #F2F3F3;
            }
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
            .glass-card {
                background: rgba(255,255,255,0.95);
                backdrop-filter: blur(8px);
                border: 1px solid rgba(224,224,224,0.5);
            }
        </style>
    </head>
    <body class="bg-surface-gray">
        <div class="flex min-h-screen">
            <%@ include file="../layout/sidebar.jsp" %>

            <main class="flex-1 ml-[280px] p-8 min-h-screen">
                <!-- Breadcrumb & Header -->
                <div class="mb-6">
                    <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-2">
                        <span class="material-symbols-outlined text-[14px]">home</span>
                        <a href="<c:url value='/payment/list'/>" class="text-ocean-blue hover:underline font-medium">Quản lý Thanh toán</a>
                        <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                        <span class="text-on-surface font-semibold">Tạo thanh toán mới</span>
                    </nav>
                    <div class="flex justify-between items-center">
                        <h2 class="text-3xl font-bold text-deep-navy">Tạo thanh toán mới</h2>
                        <a href="<c:url value='/payment/list'/>"
                           class="flex items-center gap-2 px-4 py-2 rounded-lg border border-outline-variant text-on-surface text-sm hover:bg-surface-container transition-all">
                            <span class="material-symbols-outlined text-base">arrow_back</span>
                            Quay lại danh sách
                        </a>
                    </div>
                </div>

                <div class="max-w-2xl mx-auto">
                    <section class="glass-card rounded-xl p-8 shadow-sm">
                        <div class="flex items-center gap-3 mb-6 pb-3 border-b border-gray-100">
                            <span class="material-symbols-outlined text-ocean-blue">add_card</span>
                            <h3 class="text-lg font-bold text-on-surface">Thông tin thanh toán</h3>
                        </div>

                        <form action="<c:url value='/payment/add'/>" method="POST" class="space-y-6">
                            <!-- Chọn đơn hàng -->
                            <div>
                                <label class="block text-sm font-semibold text-on-surface-variant mb-2">Chọn đơn hàng (Chưa thanh toán)</label>
                                <select id="bookingSelect" name="bookingId" required onchange="updateBookingDetails()"
                                        class="w-full rounded-lg border border-outline-variant bg-surface-bright text-sm focus:outline-none focus:ring-2 focus:ring-ocean-blue py-2.5 px-3">
                                    <option value="">-- Chọn đơn hàng --</option>
                                    <c:forEach var="b" items="${bookings}">
                                        <option value="${b.bookingId}" data-price="${b.totalPrice}" data-name="${b.fullName}" data-tour="${b.tourName}">
                                            #BK-${b.bookingId} - ${b.fullName} (${b.tourName})
                                        </option>
                                    </c:forEach>
                                </select>
                                <c:if test="${empty bookings}">
                                    <p class="text-xs text-red-500 mt-1.5 flex items-center gap-1">
                                        <span class="material-symbols-outlined text-xs">info</span>
                                        Không có đơn hàng nào chưa có thanh toán.
                                    </p>
                                </c:if>
                            </div>

                            <!-- Thông tin chi tiết đơn hàng (Hiển thị động) -->
                            <div id="detailsCard" class="hidden bg-blue-50/50 border border-blue-100 rounded-lg p-4 space-y-2 text-sm">
                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">Khách hàng:</span>
                                    <span id="detailName" class="font-semibold text-deep-navy"></span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">Tour:</span>
                                    <span id="detailTour" class="font-semibold text-deep-navy"></span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">Số tiền cần thanh toán:</span>
                                    <span id="detailPrice" class="font-bold text-action-orange text-base"></span>
                                </div>
                            </div>

                            <!-- Phương thức thanh toán -->
                            <div>
                                <label class="block text-sm font-semibold text-on-surface-variant mb-2">Phương thức thanh toán</label>
                                <select name="paymentMethod" required>
                                    <option value="CASH">Thanh toán bằng thẻ Visa</option>
                                    <option value="BANK_TRANSFER">Chuyển khoản ngân hàng</option>
                                    <option value="MOMO">Ví MoMo</option>
                                </select>
                            </div>

                            <!-- Nút submit -->
                            <div class="flex gap-4 pt-4">
                                <button type="submit" ${empty bookings ? 'disabled' : ''}
                                        class="flex-1 bg-action-orange text-white py-3 rounded-lg font-semibold text-sm hover:brightness-110 transition-all disabled:opacity-50 disabled:cursor-not-allowed">
                                    Tạo giao dịch thanh toán
                                </button>
                                <a href="<c:url value='/payment/list'/>"
                                   class="flex-1 border border-outline-variant text-center py-3 rounded-lg font-semibold text-sm hover:bg-surface-container transition-colors text-on-surface">
                                    Hủy bỏ
                                </a>
                            </div>
                        </form>
                    </section>
                </div>
            </main>
        </div>

        <script>
            function updateBookingDetails() {
                const select = document.getElementById('bookingSelect');
                const card = document.getElementById('detailsCard');
                const selectedOption = select.options[select.selectedIndex];

                if (select.value === "") {
                    card.classList.add('hidden');
                    return;
                }

                const name = selectedOption.getAttribute('data-name');
                const tour = selectedOption.getAttribute('data-tour');
                const price = parseFloat(selectedOption.getAttribute('data-price'));

                document.getElementById('detailName').innerText = name;
                document.getElementById('detailTour').innerText = tour;

                // Định dạng tiền tệ VND
                const formattedPrice = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(price);
                document.getElementById('detailPrice').innerText = formattedPrice;

                card.classList.remove('hidden');
            }
        </script>
    </body>
</html>
