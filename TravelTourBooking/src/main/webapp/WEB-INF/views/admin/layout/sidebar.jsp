<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="reqUri" value="${requestScope['jakarta.servlet.forward.request_uri']}" />
<c:if test="${empty reqUri}">
    <c:set var="reqUri" value="${pageContext.request.requestURI}" />
</c:if>

<aside class="h-screen w-[280px] fixed left-0 top-0 bg-[#05285D] shadow-lg flex flex-col py-6 z-50 leading-normal overflow-hidden">

    <div class="px-6    mb-8">
        <h1 class="font-bold text-2xl text-white m-0">Bảng điều khiển Admin</h1>
        <p class="text-white/70 text-sm m-0 mt-1">Logistics Du lịch</p>
    </div>

    <nav class="sidebar-menu overflow-y-auto custom-scrollbar">
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline text-white/80 hover:bg-white/10" href="<c:url value='/'/>">
            <span class="material-symbols-outlined mr-3">home</span>
            <span>Trang chủ (Client)</span>
        </a>

        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${activePage == 'dashboard' ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/dashboard'/>">
            <span class="material-symbols-outlined mr-3">dashboard</span>
            <span>Tổng quan</span>
        </a>

        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${activePage == 'tour' ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/tuormanagement/list'/>">
            <span class="material-symbols-outlined mr-3">explore</span>
            <span>Quản lý Tour</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${activePage == 'destination' ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/destination/list'/>">
            <span class="material-symbols-outlined mr-3">pin_drop</span>
            <span>Quản lý Điểm đến</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${activePage == 'itinerary' ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/itinerary/list'/>">
            <span class="material-symbols-outlined mr-3">schedule</span>
            <span>Quản lý Lịch trình</span>
        </a>
        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${activePage == 'booking' ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" href="<c:url value='/booking/list'/>">
            <span class="material-symbols-outlined mr-3">confirmation_number</span>
            <span>Quản lý Đặt chỗ</span>
        </a>

        <div class="space-y-1">
            <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline text-white/80 hover:bg-white/10" 
               href="javascript:void(0)" onclick="toggleDropdown()">
                <span class="material-symbols-outlined mr-3">analytics</span>
                <span class="flex-1">Báo cáo & Thống kê</span>
                <span class="material-symbols-outlined text-sm">expand_more</span>
            </a>

            <div id="reportDropdown" class="hidden pl-10 space-y-2 pb-2 text-sm">
                <a href="${pageContext.request.contextPath}/admin/report/dashboard" 
                   class="block px-4 py-2 rounded-lg ${activePage == 'report-dashboard' ? 'bg-[#0194F3] text-white shadow-sm' : 'text-white/70 hover:bg-white/10'}">1. Tổng quan hệ thống</a>

                <a href="<c:url value='/admin/report/revenue-time'/>" 
                   class="block px-4 py-2 rounded-lg ${activePage == 'report-revenue' ? 'bg-blue-600 text-white' : 'text-white/60 hover:text-white'}">2. Doanh thu theo thời gian</a>
                <a href="${pageContext.request.contextPath}/admin/report/top-selling-tours" 
                   class="flex items-center p-4 text-gray-600 hover:bg-blue-50 hover:text-blue-600 transition-colors 
                   ${activePage == 'report-top-tours' ? 'bg-blue-100 text-blue-700 font-bold' : ''}">
                    <span class="mr-3"></span> 3. Tour bán chạy nhất
                </a>

            </div>
        </div>

        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${activePage == 'payment' ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" 
           href="<c:url value='/payment/list'/>">
            <span class="material-symbols-outlined mr-3">payments</span>
            <span>Quản lý Thanh toán</span>
        </a>

        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${activePage == 'admin-user' ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" 
           href="<c:url value='/admin/user/list'/>">
            <span class="material-symbols-outlined mr-3">group</span>
            <span>Quản lý Tài khoản</span>
        </a>

        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${activePage == 'admin-voucher' ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" 
           href="<c:url value='/admin/voucher/list'/>">
            <span class="material-symbols-outlined mr-3">loyalty</span>
            <span>Quản lý Voucher</span>
        </a>

        <a class="flex items-center px-4 py-3 rounded-xl transition-all duration-200 no-underline ${activePage == 'setting' ? 'bg-[#0194F3] text-white shadow-lg' : 'text-white/80 hover:bg-white/10'}" 
           href="<c:url value='/system/setting'/>">
            <span class="material-symbols-outlined mr-3">settings</span>
            <span>Cài đặt</span>
        </a>

        <script>
            // 1. Tự bung Dropdown báo cáo nếu URL đang nằm trong nhóm báo cáo
            if (window.location.href.indexOf("/admin/report/") > -1) {
                document.getElementById('reportDropdown').classList.remove('hidden');
            }

            // 2. Tự thêm class active cho các mục mà bạn không sửa được Controller
            // Ví dụ: Nếu URL chứa '/tuormanagement', tự tô màu nút Quản lý Tour
            const currentPath = window.location.pathname;

            // Tạo map các đường dẫn tương ứng với menu
            const menuMap = [
                {path: '/tuormanagement', selector: 'a[href*="/tuormanagement"]'},
                {path: '/destination', selector: 'a[href*="/destination"]'},
                {path: '/itinerary', selector: 'a[href*="/itinerary"]'},
                {path: '/booking', selector: 'a[href*="/booking"]'},
                {path: '/payment', selector: 'a[href*="/payment"]'},
                {path: '/admin/user', selector: 'a[href*="/admin/user"]'},
                {path: '/admin/voucher', selector: 'a[href*="/admin/voucher"]'}
            ];

            menuMap.forEach(item => {
                if (currentPath.includes(item.path)) {
                    const el = document.querySelector(item.selector);
                    if (el) {
                        el.classList.add('bg-[#0194F3]', 'text-white', 'shadow-lg');
                        el.classList.remove('text-white/80');
                    }
                }
            });
        </script>
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

    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById('reportDropdown');
            dropdown.classList.toggle('hidden');
        }

        // Tự động mở dropdown nếu URL đang thuộc về /report
        window.onload = function () {
            if (window.location.href.indexOf('/report') > -1) {
                document.getElementById('reportDropdown').classList.remove('hidden');
            }
        }
    </script>
</aside>
