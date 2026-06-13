<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="../layout/header.jsp" %>

<div style="background:#EEF2F6;" class="min-h-screen">

    <div class="max-w-container-max mx-auto px-margin-desktop py-8">

        <div class="mb-8">

            <a href="${pageContext.request.contextPath}/payment/history"
               class="inline-flex items-center gap-2 text-ocean-blue font-semibold hover:underline">

                <span class="material-symbols-outlined">
                    arrow_back
                </span>

                Quay lại lịch sử thanh toán

            </a>

        </div>

        <div class="bg-white border-2 border-slate-400 rounded-xl shadow-lg overflow-hidden">

            <!-- Header -->
            <div class="bg-deep-navy p-6">

                <h1 class="text-3xl font-bold text-white">
                    ${payment.tourName}
                </h1>

            </div>

            <div class="p-8">

                <div class="grid md:grid-cols-2 gap-6">

                    <!-- Thông tin giao dịch -->
                    <div class="bg-blue-50 border border-blue-200 rounded-lg p-5">

                        <h3 class="font-bold text-deep-navy mb-4">
                            Thông tin giao dịch
                        </h3>

                        <div class="space-y-3">

                            <div class="flex justify-between">
                                <span>Mã thanh toán</span>
                                <strong>PM-${payment.paymentId}</strong>
                            </div>

                            <div class="flex justify-between">
                                <span>Mã booking</span>
                                <strong>BK-${payment.bookingId}</strong>
                            </div>

                            <div class="flex justify-between">
                                <span>Khách hàng</span>
                                <strong>${payment.fullName}</strong>
                            </div>

                            <div class="flex justify-between">
                                <span>Ngày thanh toán</span>

                                <strong>
                                    <fmt:formatDate
                                            value="${payment.paymentDate}"
                                            pattern="dd/MM/yyyy"/>
                                </strong>
                            </div>

                        </div>

                    </div>

                    <!-- Thông tin thanh toán -->
                    <div class="bg-orange-100 border-2 border-orange-300 rounded-lg p-5">

                        <h3 class="font-bold text-deep-navy mb-4">
                            Thông tin thanh toán
                        </h3>

                        <div class="space-y-3">

                            <div class="flex justify-between">
                                <span>Phương thức</span>

                                <strong>
                                    ${payment.paymentMethod}
                                </strong>
                            </div>

                            <div class="flex justify-between items-center">

                                <span>Số tiền</span>

                                <span class="text-3xl font-bold text-action-orange">

                                    <fmt:formatNumber
                                            value="${payment.amount}"
                                            type="number"/>

                                    đ

                                </span>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- Status -->
                <div class="mt-8 flex justify-center">

                    <c:choose>

                        <c:when test="${payment.paymentStatus == 'PAID'}">

                            <span class="px-6 py-3 rounded-full bg-green-100 text-green-700 border border-green-300 font-bold">
                                Đã thanh toán
                            </span>

                        </c:when>

                        <c:otherwise>

                            <span class="px-6 py-3 rounded-full bg-yellow-100 text-yellow-700 border border-yellow-300 font-bold">
                                Chờ thanh toán
                            </span>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </div>

    </div>

</div>

<%@ include file="../layout/footer.jsp" %>