<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="reqUri" value="${requestScope['jakarta.servlet.forward.request_uri']}" />
<c:if test="${empty reqUri}">
    <c:set var="reqUri" value="${pageContext.request.requestURI}" />
</c:if>

<aside class="h-screen w-[280px] fixed left-0 top-0 bg-[#05285D] shadow-lg flex flex-col py-6 z-50 leading-normal">
    <div class="px-6 mb-8">
        <h1 class="font-bold text-2xl text-white m-0">Bảng điều khiển Admin</h1>
        <p class="text-white/70 text-sm m-0 mt-1">Logistics Du lịch</p>
    </div>

    <nav class="flex-1 px-3 space-y-2">
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${fn:contains(reqUri, '/dashboard') ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/dashboard'/>">
            <span class="material-symbols-outlined mr-3">dashboard</span>
            <span>Tổng quan</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${fn:contains(reqUri, '/tuormanagement') ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/tuormanagement/list'/>">
            <span class="material-symbols-outlined mr-3">explore</span>
            <span>Quản lý Tour</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${fn:contains(reqUri, '/destination') ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/destination/list'/>">
            <span class="material-symbols-outlined mr-3">pin_drop</span>
            <span>Quản lý Điểm đến</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${fn:contains(reqUri, '/itinerary') ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/itinerary/list'/>">
            <span class="material-symbols-outlined mr-3">schedule</span>
            <span>Quản lý Lịch trình</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${fn:contains(reqUri, '/booking') ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/booking/list'/>">
            <span class="material-symbols-outlined mr-3">confirmation_number</span>
            <span>Quản lý Đặt chỗ</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${fn:contains(reqUri, '/report') ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/report/revenue'/>">
            <span class="material-symbols-outlined mr-3">analytics</span>
            <span>Báo cáo</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${fn:contains(reqUri, '/payment') ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/payment/list'/>">
            <span class="material-symbols-outlined mr-3">payments</span>
            <span>Quản lý Thanh toán</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${fn:contains(reqUri, '/system') or fn:contains(reqUri, '/setting') ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/system/setting'/>">
            <span class="material-symbols-outlined mr-3">settings</span>
            <span>Cài đặt</span>
        </a>
    </nav>

    <div class="px-4 mt-auto">
        <div class="flex items-center gap-3 p-3 rounded-xl bg-white/10 border border-white/10">
            <div class="w-10 h-10 rounded-full bg-gradient-to-tr from-[#7ac8ff] to-[#2e8cff] flex items-center justify-center font-bold text-white">
                QT
            </div>
            <div class="flex flex-col">
                <span class="font-semibold text-white text-sm">Quản trị viên</span>
                <span class="text-white/70 text-xs">Logistics Du lịch</span>
            </div>
        </div>
    </div>
</aside>
