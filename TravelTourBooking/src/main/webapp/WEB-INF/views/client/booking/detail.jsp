<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="../layout/header.jsp" %>

<div style="background:#EEF2F6;" class="min-h-screen">

    <div class="max-w-container-max mx-auto px-margin-desktop py-8">

        <div class="mb-8">

            <a href="${pageContext.request.contextPath}/booking/history"
               class="inline-flex items-center gap-2 text-ocean-blue font-semibold hover:underline">

                <span class="material-symbols-outlined">
                    arrow_back
                </span>

                Quay lại lịch sử

            </a>

        </div>

        <div class="bg-white border-2 border-slate-400 rounded-xl shadow-lg overflow-hidden">

            <div class="bg-deep-navy p-6">

                <h1 class="text-3xl font-bold text-white">
                    ${booking.tourName}
                </h1>

            </div>

            <div class="p-8">

                <div class="grid md:grid-cols-2 gap-6">

                    <div class="bg-blue-50 border border-blue-200 rounded-lg p-5">

                        <h3 class="font-bold text-deep-navy mb-4">
                            Thông tin đặt tour
                        </h3>

                        <div class="space-y-3">

                            <div class="flex justify-between">
                                <span>Mã booking</span>
                                <strong>BK-${booking.bookingId}</strong>
                            </div>

                            <div class="flex justify-between">
                                <span>Khách hàng</span>
                                <strong>${booking.fullName}</strong>
                            </div>

                            <div class="flex justify-between">
                                <span>Số khách</span>
                                <strong>${booking.numberOfPeople}</strong>
                            </div>

                            <div class="flex justify-between">
                                <span>Ngày đặt</span>

                                <strong>
                                    <fmt:formatDate
                                        value="${booking.bookingDate}"
                                        pattern="dd/MM/yyyy"/>
                                </strong>
                            </div>

                        </div>

                    </div>

                    <div class="bg-orange-100 border-2 border-orange-300 rounded-lg p-5">

                        <h3 class="font-bold text-deep-navy mb-4">
                            Thanh toán
                        </h3>

                        <div class="space-y-3">

                            <div class="flex justify-between">
                                <span>Trạng thái thanh toán</span>

                                <strong>
                                    ${booking.paymentStatus}
                                </strong>
                            </div>

                            <div class="flex justify-between items-center">

                                <span>Tổng tiền</span>

                                <span class="text-3xl font-bold text-action-orange">

                                    <fmt:formatNumber
                                        value="${booking.totalPrice}"
                                        type="number"/>

                                    đ

                                </span>

                            </div>

                        </div>

                    </div>

                </div>

                <div class="mt-8 flex justify-center">

                    <c:choose>

                        <c:when test="${booking.bookingStatus == 'PENDING'}">

                            <span class="px-6 py-3 rounded-full bg-yellow-100 text-yellow-700 border border-yellow-300 font-bold">
                                Chờ xác nhận
                            </span>

                        </c:when>

                        <c:when test="${booking.bookingStatus == 'CONFIRMED'}">

                            <span class="px-6 py-3 rounded-full bg-blue-100 text-blue-700 border border-blue-300 font-bold">
                                Đã xác nhận
                            </span>

                        </c:when>

                        <c:when test="${booking.bookingStatus == 'COMPLETED'}">

                            <span class="px-6 py-3 rounded-full bg-green-100 text-green-700 border border-green-300 font-bold">
                                Hoàn thành
                            </span>

                        </c:when>

                        <c:otherwise>

                            <span class="px-6 py-3 rounded-full bg-red-100 text-red-700 border border-red-300 font-bold">
                                Đã hủy
                            </span>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </div>

    </div>

</div>

<%@ include file="../layout/footer.jsp" %>