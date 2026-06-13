<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="../layout/header.jsp" %>

<div style="background:#EEF2F6;" class="min-h-screen">

    <div class="max-w-container-max mx-auto px-margin-desktop py-8">

        <div class="mb-10">

            <h1 class="text-headline-lg font-bold text-deep-navy">
                Lịch sử thanh toán
            </h1>

            <p class="text-on-surface-variant mt-2">
                Theo dõi các giao dịch thanh toán cho những tour đã đặt.
            </p>

        </div>

        <c:choose>

            <c:when test="${empty payments}">

                <div class="bg-white border-2 border-slate-400 rounded-xl p-12 text-center shadow-lg">

                    <span class="material-symbols-outlined text-6xl text-outline">
                        payments
                    </span>

                    <h3 class="mt-4 text-xl font-bold text-deep-navy">
                        Chưa có giao dịch thanh toán
                    </h3>

                    <p class="text-on-surface-variant mt-2">
                        Bạn chưa thực hiện thanh toán nào.
                    </p>

                </div>

            </c:when>

            <c:otherwise>

                <div class="grid md:grid-cols-2 xl:grid-cols-3 gap-8">

                    <c:forEach var="payment" items="${payments}">

                        <div class="bg-white
                                    border-2 border-slate-400
                                    rounded-xl
                                    shadow-lg
                                    hover:shadow-2xl
                                    hover:-translate-y-1
                                    transition-all
                                    duration-300
                                    p-6">

                            <div class="bg-deep-navy rounded-lg p-4 mb-5">

                                <h3 class="font-bold text-2xl text-white">
                                    ${payment.tourName}
                                </h3>

                            </div>

                            <div class="space-y-3 bg-blue-50 border border-blue-200 rounded-lg p-4">

                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">
                                        Mã thanh toán
                                    </span>

                                    <span class="font-semibold">
                                        PM-${payment.paymentId}
                                    </span>
                                </div>

                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">
                                        Mã booking
                                    </span>

                                    <span class="font-semibold">
                                        BK-${payment.bookingId}
                                    </span>
                                </div>

                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">
                                        Phương thức
                                    </span>

                                    <span class="font-semibold">
                                        ${payment.paymentMethod}
                                    </span>
                                </div>

                                <div class="flex justify-between">
                                    <span class="text-on-surface-variant">
                                        Ngày thanh toán
                                    </span>

                                    <span class="font-semibold">

                                        <fmt:formatDate
                                                value="${payment.paymentDate}"
                                                pattern="dd/MM/yyyy"/>

                                    </span>
                                </div>

                            </div>

                            <div class="mt-6 p-4 rounded-lg bg-orange-100 border-2 border-orange-300">

                                <p class="text-sm text-on-surface-variant mb-1">
                                    Số tiền thanh toán
                                </p>

                                <p class="text-3xl font-bold text-action-orange">

                                    <fmt:formatNumber
                                            value="${payment.amount}"
                                            type="number"/>

                                    đ

                                </p>

                            </div>

                            <div class="mt-5 flex justify-center">

                                <c:choose>

                                    <c:when test="${payment.paymentStatus == 'PAID'}">

                                        <span class="px-4 py-2 rounded-full bg-green-100 text-green-700 border border-green-300 font-semibold">
                                            Đã thanh toán
                                        </span>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="px-4 py-2 rounded-full bg-yellow-100 text-yellow-700 border border-yellow-300 font-semibold">
                                            Chờ thanh toán
                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </div>

                            <div class="mt-6">

                                <a href="${pageContext.request.contextPath}/payment/history/detail/${payment.paymentId}"
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

<%@ include file="../layout/footer.jsp" %>