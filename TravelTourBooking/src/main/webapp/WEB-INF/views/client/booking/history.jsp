<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="../layout/header.jsp" %>

<div style="background:#EEF2F6;" class="min-h-screen">
    <div class="max-w-container-max mx-auto px-margin-desktop py-8">

        <div class="mb-10">
            <h1 class="text-headline-lg font-bold text-deep-navy">
                Lịch sử đặt tour
            </h1>

            <p class="text-on-surface-variant mt-2">
                Theo dõi trạng thái và thông tin các tour bạn đã đặt.
            </p>
        </div>

        <c:choose>

            <c:when test="${empty bookings}">

                <div class="bg-[#FCFCFD] border-2 border-slate-300 rounded-xl shadow-md hover:shadow-xl hover:-translate-y-1 transition-all duration-300 p-6">

                    <span class="material-symbols-outlined text-6xl text-outline">
                        travel
                    </span>

                    <h3 class="mt-4 text-xl font-bold text-deep-navy">
                        Chưa có đơn đặt tour
                    </h3>

                    <p class="text-on-surface-variant mt-2">
                        Bạn chưa có lịch sử đặt tour nào.
                    </p>

                    <a href="${pageContext.request.contextPath}/"
                       class="inline-flex items-center gap-2 mt-6 px-5 py-3 rounded-lg bg-action-orange text-white font-semibold hover:brightness-110 transition-all">

                        Khám phá tour

                        <span class="material-symbols-outlined">
                            arrow_forward
                        </span>

                    </a>

                </div>

            </c:when>

            <c:otherwise>

                <div class="grid md:grid-cols-2 xl:grid-cols-3 gap-8">

                    <c:forEach var="booking" items="${bookings}">

                        <div class="bg-white
                             border-2 border-slate-400
                             rounded-xl
                             shadow-lg
                             hover:shadow-2xl
                             hover:-translate-y-1
                             transition-all
                             duration-300
                             p-6">

                            <div class="border-b border-surface-container-highest pb-4 mb-4">

                                <h3 class="font-bold text-2xl text-deep-navy">
                                    ${booking.tourName}
                                </h3>

                            </div>

                            <div class="space-y-3 text-body-lg bg-blue-50 border border-blue-200 rounded-lg p-4">

                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">
                                        Mã booking
                                    </span>

                                    <span class="font-semibold text-deep-navy">
                                        BK-${booking.bookingId}
                                    </span>
                                </div>

                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">
                                        Số khách
                                    </span>

                                    <span class="font-semibold">
                                        ${booking.numberOfPeople}
                                    </span>
                                </div>

                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">
                                        Ngày đặt
                                    </span>

                                    <span class="font-semibold">
                                        <fmt:formatDate
                                            value="${booking.bookingDate}"
                                            pattern="dd/MM/yyyy"/>
                                    </span>
                                </div>

                            </div>

                            <div class="mt-6 p-4 rounded-lg bg-orange-100 border-2 border-orange-300">

                                <p class="text-sm text-on-surface-variant mb-1">
                                    Tổng thanh toán
                                </p>

                                <p class="text-3xl font-bold text-action-orange">

                                    <fmt:formatNumber
                                        value="${booking.totalPrice}"
                                        type="number"/>

                                    đ

                                </p>

                            </div>

                            <div class="mt-5 flex justify-center">

                                <c:choose>
                                    <c:when test="${booking.bookingStatus == 'PENDING'}">

                                        <span class="inline-flex px-4 py-2 rounded-full bg-yellow-100 text-yellow-700 font-semibold text-sm border border-yellow-300">
                                            Chờ xác nhận
                                        </span>

                                    </c:when>

                                    <c:when test="${booking.bookingStatus == 'CONFIRMED'}">

                                        <span class="inline-flex px-4 py-2 rounded-full bg-blue-100 text-blue-700 font-semibold text-sm border border-blue-300">
                                            Đã xác nhận
                                        </span>

                                    </c:when>

                                    <c:when test="${booking.bookingStatus == 'COMPLETED'}">

                                        <span class="inline-flex px-4 py-2 rounded-full bg-green-100 text-green-700 font-semibold text-sm border border-green-300">
                                            Hoàn thành
                                        </span>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="inline-flex px-4 py-2 rounded-full bg-red-100 text-red-700 font-semibold text-sm border border-red-300">
                                            Đã hủy
                                        </span>

                                    </c:otherwise>
                                </c:choose>

                            </div>

                            <div class="mt-6">

                                <a href="${pageContext.request.contextPath}/booking/history/detail/${booking.bookingId}"
                                   class="inline-flex items-center gap-2 px-4 py-2 rounded-lg border border-ocean-blue text-ocean-blue font-semibold hover:bg-ocean-blue hover:text-white transition-all">

                                    Xem chi tiết

                                    <span class="material-symbols-outlined text-base">
                                        arrow_forward
                                    </span>

                                </a>

                            </div>

                        </div>

                    </c:forEach>

                </div>

            </c:otherwise>

        </c:choose>

    </div>

</div>

</div>

<%@ include file="../layout/footer.jsp" %>