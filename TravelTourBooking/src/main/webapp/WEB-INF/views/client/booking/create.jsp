<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="../layout/header.jsp" %>

<div style="background:#EEF2F6;" class="min-h-screen">

    <div class="max-w-container-max mx-auto px-margin-desktop py-10">

        <div class="mb-8">

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
                            src="${selectedTour.imageUrl}"
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
                                            Tiền mặt
                                        </div>

                                        <div class="text-sm text-slate-500">
                                            Thanh toán tại văn phòng
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