<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="../layout/header.jsp" %>

<div style="background:#EEF2F6;" class="min-h-screen">

    <div class="max-w-container-max mx-auto px-margin-desktop py-8">

        <!-- Header -->
        <div class="mb-10">

            <h1 class="text-headline-lg font-bold text-deep-navy">
                Đặt Tour
            </h1>

            <p class="text-on-surface-variant mt-2">
                Chọn tour và số lượng khách để tạo đơn đặt tour.
            </p>

        </div>

        <!-- Form -->
        <div class="bg-white border-2 border-slate-300 rounded-xl shadow-md p-8">

            <form action="${pageContext.request.contextPath}/booking/create"
                  method="post"
                  class="space-y-6">

                <!-- Tour -->
                <div>

                    <label class="block mb-2 font-semibold text-deep-navy">
                        Chọn Tour
                    </label>

                    <select id="tourSelect"
                            name="tourId"
                            required
                            onchange="updatePrice()"
                            class="w-full rounded-lg border-2 border-slate-300 p-3">

                        <option value="">
                            -- Chọn tour --
                        </option>

                        <c:forEach var="tour" items="${tours}">

                            <option value="${tour.tourId}"
                                    data-price="${tour.price}">

                                ${tour.tourName}
                                -
                            <fmt:formatNumber value="${tour.price}"
                                              type="number"/> đ

                            </option>

                        </c:forEach>

                    </select>

                </div>

                <!-- Number Of People -->
                <div>

                    <label class="block mb-2 font-semibold text-deep-navy">
                        Số lượng khách
                    </label>

                    <input type="number"
                           id="numberOfPeople"
                           name="numberOfPeople"
                           min="1"
                           value="1"
                           required
                           oninput="updatePrice()"
                           class="w-full rounded-lg border-2 border-slate-300 p-3"/>

                </div>

                <!-- Price Card -->
                <div class="bg-blue-50 border border-blue-200 rounded-lg p-5">

                    <h3 class="font-bold text-deep-navy mb-3">
                        Thông tin thanh toán
                    </h3>

                    <div class="flex justify-between mb-2">

                        <span>Giá tour</span>

                        <span id="tourPrice">
                            0 đ
                        </span>

                    </div>

                    <div class="flex justify-between font-bold text-lg">

                        <span>Tổng tiền</span>

                        <span id="totalPrice"
                              class="text-action-orange">
                            0 đ
                        </span>

                    </div>

                </div>

                <!-- Button -->
                <div class="flex gap-4">

                    <button type="submit"
                            class="px-6 py-3 bg-action-orange text-white rounded-lg font-semibold hover:brightness-110 transition-all">

                        Đặt Tour

                    </button>

                    <a href="${pageContext.request.contextPath}/booking/history"
                       class="px-6 py-3 border border-slate-300 rounded-lg font-semibold hover:bg-slate-100 transition-all">

                        Lịch sử đặt tour

                    </a>

                </div>

            </form>

        </div>

    </div>

</div>

<script>

    function updatePrice() {

        const select =
                document.getElementById(
                        "tourSelect");

        const people =
                parseInt(
                        document.getElementById(
                                "numberOfPeople").value) || 0;

        const option =
                select.options[
                        select.selectedIndex];

        const price =
                parseFloat(
                        option.getAttribute(
                                "data-price")) || 0;

        const total =
                price * people;

        document.getElementById(
                "tourPrice").innerText =
                price.toLocaleString(
                        "vi-VN") + " đ";

        document.getElementById(
                "totalPrice").innerText =
                total.toLocaleString(
                        "vi-VN") + " đ";
    }

</script>

<%@ include file="../layout/footer.jsp" %>