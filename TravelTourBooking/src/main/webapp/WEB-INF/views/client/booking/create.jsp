<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="../layout/header.jsp" %>

<div style="background:#EEF2F6;" class="min-h-screen">

    <div class="max-w-container-max mx-auto px-margin-desktop py-10">

        <div class="mb-8">

            <a href="javascript:history.back()"
               class="inline-flex items-center gap-2 mb-5 px-4 py-2 bg-white border-2 border-slate-300 rounded-lg font-semibold text-deep-navy hover:bg-slate-100 transition-all">

                <span class="material-symbols-outlined">
                    arrow_back
                </span>

                Quay lại

            </a>

            <h1 class="text-headline-lg font-bold text-deep-navy">
                Đặt Tour
            </h1>

            <p class="text-on-surface-variant mt-2">
                Xác nhận thông tin và hoàn tất đăng ký tour của bạn.
            </p>

        </div>

        <form method="post"
              action="${pageContext.request.contextPath}/booking/create">

            <div class="grid lg:grid-cols-3 gap-8">

                <!-- TOUR INFO -->
                <div class="lg:col-span-2">

                    <div class="bg-white border-2 border-slate-300 rounded-xl overflow-hidden shadow-md">

                        <img
                            src="${pageContext.request.contextPath}/resources/images/${selectedTour.imageUrl}"
                            onerror="if(this.src.indexOf('https://images.unsplash.com') === -1) { 
                                var name = '${selectedTour.tourName.toLowerCase()}';
                                if(name.includes('da lat') || name.includes('đà lạt')) {
                                    this.src = '${pageContext.request.contextPath}/resources/images/da_lat.jpg';
                                } else if(name.includes('da nang') || name.includes('đà nẵng')) {
                                    this.src = '${pageContext.request.contextPath}/resources/images/da_nang.jpg';
                                } else if(name.includes('hue') || name.includes('huế')) {
                                    this.src = '${pageContext.request.contextPath}/resources/images/Hue.jpg';
                                } else {
                                    this.src = 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?auto=format&fit=crop&w=800&q=80';
                                }
                            }"
                            alt="${selectedTour.tourName}"
                            class="w-full h-[320px] object-cover">

                        <div class="p-6">

                            <input type="hidden"
                                   name="tourId"
                                   value="${selectedTour.tourId}">

                            <h2 class="text-3xl font-bold text-deep-navy">
                                ${selectedTour.tourName}
                            </h2>

                            <div class="grid md:grid-cols-2 gap-4 mt-5">

                                <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">

                                    <div class="text-sm text-slate-500">
                                        Thời lượng
                                    </div>

                                    <div class="font-semibold text-deep-navy mt-1">
                                        ${selectedTour.durationDays} ngày
                                    </div>

                                </div>

                                <div class="bg-green-50 border border-green-200 rounded-lg p-4">

                                    <div class="text-sm text-slate-500">
                                        Sức chứa tối đa
                                    </div>

                                    <div class="font-semibold text-deep-navy mt-1">
                                        ${selectedTour.maxCapacity} khách
                                    </div>

                                </div>

                            </div>

                            <div class="grid md:grid-cols-2 gap-4 mt-4">

                                <div class="bg-orange-50 border border-orange-200 rounded-lg p-4">

                                    <div class="text-sm text-slate-500">
                                        Ngày khởi hành
                                    </div>

                                    <div class="font-semibold text-deep-navy mt-1">
                                        ${selectedTour.startDate}
                                    </div>

                                </div>

                                <div class="bg-purple-50 border border-purple-200 rounded-lg p-4">

                                    <div class="text-sm text-slate-500">
                                        Ngày kết thúc
                                    </div>

                                    <div class="font-semibold text-deep-navy mt-1">
                                        ${selectedTour.endDate}
                                    </div>

                                </div>

                            </div>

                            <div class="mt-6">

                                <h3 class="font-bold text-xl text-deep-navy mb-3">
                                    Mô tả tour
                                </h3>

                                <p class="text-slate-600 leading-relaxed">
                                    ${selectedTour.description}
                                </p>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- BOOKING CARD -->
                <div>

                    <div class="bg-white border-2 border-slate-300 rounded-xl shadow-md p-6 sticky top-24">

                        <h3 class="text-xl font-bold text-deep-navy mb-6">
                            Thông tin đặt tour
                        </h3>
                        <div class="bg-green-50 border-2 border-green-200 rounded-lg p-4 mb-5">

                            <div class="text-sm text-slate-500">
                                Số chỗ còn lại
                            </div>

                            <div class="font-bold text-green-700 text-lg mt-1">
                                ${remainingSlots} khách
                            </div>

                        </div>
                        <c:if test="${error == 'full'}">

                            <div class="mb-5 p-4 rounded-lg
                                 bg-red-50
                                 border-2 border-red-300
                                 text-red-700 font-medium">

                                ❌ Tour chỉ còn ${remainingSlots} chỗ trống.
                                Vui lòng giảm số lượng khách.

                            </div>

                        </c:if>

                        <div class="mb-5">

                            <label class="block font-semibold mb-2">
                                Số lượng khách
                            </label>

                            <input
                                type="number"
                                id="people"
                                name="numberOfPeople"
                                value="1"
                                min="1"
                                max="${remainingSlots}"
                                required
                                class="w-full border-2 border-slate-300 rounded-lg px-4 py-3">

                        </div>

                        <div class="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-4">

                            <div class="text-sm text-slate-500">
                                Giá mỗi khách
                            </div>

                            <div class="text-xl font-bold text-deep-navy mt-1">

                                <fmt:formatNumber
                                    value="${selectedTour.price}"
                                    type="number"/>

                                đ

                            </div>

                        </div>
                        <!-- PAYMENT METHOD -->

                        <div class="mb-5">

                            <label class="block font-semibold mb-3">
                                Phương thức thanh toán
                            </label>

                            <div class="space-y-3">

                                <label class="flex items-center gap-3 p-4 border-2 border-slate-300 rounded-lg cursor-pointer hover:border-blue-400 transition-all">

                                    <input
                                        type="radio"
                                        name="paymentMethod"
                                        checked>

                                    <span class="material-symbols-outlined text-blue-600">
                                        account_balance
                                    </span>

                                    <div>

                                        <div class="font-semibold">
                                            Chuyển khoản ngân hàng
                                        </div>

                                        <div class="text-sm text-slate-500">
                                            Thanh toán qua tài khoản ngân hàng
                                        </div>

                                    </div>

                                </label>

                                <label class="flex items-center gap-3 p-4 border-2 border-slate-300 rounded-lg cursor-pointer hover:border-green-400 transition-all">

                                    <input
                                        type="radio"
                                        name="paymentMethod">

                                    <span class="material-symbols-outlined text-green-600">
                                        payments
                                    </span>

                                    <div>

                                        <div class="font-semibold">
                                            Visa
                                        </div>

                                        <div class="text-sm text-slate-500">
                                            Thanh toán qua thẻ quốc tế VISA, MASTER CARD,...
                                        </div>

                                    </div>

                                </label>

                                <label class="flex items-center gap-3 p-4 border-2 border-slate-300 rounded-lg cursor-pointer hover:border-purple-400 transition-all">

                                    <input
                                        type="radio"
                                        name="paymentMethod">

                                    <span class="material-symbols-outlined text-purple-600">
                                        account_balance_wallet
                                    </span>

                                    <div>

                                        <div class="font-semibold">
                                            Ví điện tử
                                        </div>

                                        <div class="text-sm text-slate-500">
                                            Momo, ZaloPay, ShopeePay...
                                        </div>

                                    </div>

                                </label>

                            </div>

                        </div>

                        <!-- PAYMENT NOTICE -->

                        <div class="bg-sky-50 border-2 border-sky-200 rounded-lg p-4 mb-6">

                            <div class="font-semibold text-sky-800 mb-2">
                                Thông tin thanh toán
                            </div>

                            <ul class="text-sm text-slate-600 space-y-1">

                                <li>• Sau khi đặt tour, nhân viên sẽ liên hệ xác nhận.</li>

                                <li>• Hình thức thanh toán sẽ được hướng dẫn chi tiết.</li>

                                <li>• Booking chỉ được xác nhận khi thanh toán thành công.</li>

                            </ul>

                        </div>

                        <div class="bg-orange-100 border-2 border-orange-300 rounded-lg p-4 mb-6">

                            <div class="text-sm text-slate-500">
                                Tổng thanh toán
                            </div>

                            <div id="totalPrice"
                                 class="text-3xl font-bold text-action-orange mt-2">

                                <fmt:formatNumber
                                    value="${selectedTour.price}"
                                    type="number"/>

                                đ

                            </div>

                        </div>

                        <button
                            type="submit"
                            class="w-full bg-action-orange text-white py-4 rounded-lg font-bold hover:brightness-110 transition-all">

                            Xác nhận đặt tour

                        </button>

                    </div>

                </div>

            </div>

        </form>
        <!-- TOUR GỢI Ý -->

        <div class="mt-12">

            <h2 class="text-3xl font-bold text-deep-navy mb-6">
                Khám phá thêm tour khác
            </h2>

            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">

                <c:forEach var="tour" items="${relatedTours}">

                    <c:if test="${tour.tourId != selectedTour.tourId}">

                        <div class="bg-white border-2 border-slate-300 rounded-xl overflow-hidden shadow-md hover:shadow-xl hover:-translate-y-1 transition-all">

                            <img src="${pageContext.request.contextPath}/resources/images/${tour.imageUrl}"
                                 onerror="if(this.src.indexOf('https://images.unsplash.com') === -1) {
                                      var name = '${tour.tourName.toLowerCase()}';
                                      if(name.includes('da lat') || name.includes('đà lạt')) {
                                          this.src = '${pageContext.request.contextPath}/resources/images/da_lat.jpg';
                                      } else if(name.includes('da nang') || name.includes('đà nẵng')) {
                                          this.src = '${pageContext.request.contextPath}/resources/images/da_nang.jpg';
                                      } else if(name.includes('hue') || name.includes('huế')) {
                                          this.src = '${pageContext.request.contextPath}/resources/images/Hue.jpg';
                                      } else {
                                          this.src = 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?auto=format&fit=crop&w=800&q=80';
                                      }
                                  }"
                                 alt="${tour.tourName}"
                                 class="w-full h-52 object-cover">

                            <div class="p-5">

                                <h3 class="font-bold text-xl text-deep-navy mb-2">
                                    ${tour.tourName}
                                </h3>

                                <p class="text-slate-500 mb-4">
                                    ${tour.durationDays} ngày
                                </p>

                                <div class="flex justify-between items-center">

                                    <span class="text-action-orange text-lg font-bold">

                                        <fmt:formatNumber
                                            value="${tour.price}"
                                            type="number"/>

                                        đ

                                    </span>

                                    <a href="${pageContext.request.contextPath}/booking/create?tourId=${tour.tourId}"
                                       class="px-4 py-2 rounded-lg bg-ocean-blue text-white font-semibold hover:brightness-110">

                                        Xem tour

                                    </a>

                                </div>

                            </div>

                        </div>

                    </c:if>

                </c:forEach>

            </div>

        </div>

    </div>

</div>

<script>

    const price =
    ${selectedTour.price};

    const peopleInput =
            document.getElementById("people");

    const totalPrice =
            document.getElementById("totalPrice");

    function updateTotal() {

        const people =
                parseInt(
                        peopleInput.value || 1);

        const total =
                people * price;

        totalPrice.innerText =
                total.toLocaleString('vi-VN') + ' đ';
    }

    peopleInput.addEventListener(
            "input",
            updateTotal);

    updateTotal();

</script>

<%@ include file="../layout/footer.jsp" %>