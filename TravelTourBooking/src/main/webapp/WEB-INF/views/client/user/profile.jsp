<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Thông tin cá nhân - VoyagerElite" />
<%@ include file="../layout/header.jsp" %>

<div class="bg-[#f8f9f9] min-h-screen py-12">
    <div class="max-w-container-max mx-auto px-margin-desktop">
        <!-- Breadcrumb -->
        <div class="flex items-center gap-2 text-sm text-on-surface-variant mb-6">
            <a href="<c:url value='/'/>" class="hover:text-ocean-blue transition-colors flex items-center gap-1">
                <span class="material-symbols-outlined text-[18px]">home</span> Trang chủ
            </a>
            <span class="material-symbols-outlined text-[16px] text-outline">chevron_right</span>
            <span class="font-medium text-deep-navy">Thông tin cá nhân</span>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            <!-- Left Sidebar -->
            <div class="lg:col-span-4 space-y-6">
                <!-- User Summary Card -->
                <div class="bg-white rounded-2xl border border-outline-variant/30 p-6 shadow-sm text-center">
                    <div class="flex flex-col items-center">
                        <div class="w-24 h-24 rounded-full bg-gradient-to-tr from-ocean-blue to-primary flex items-center justify-center text-white text-3xl font-extrabold shadow-md mb-4 relative group">
                            ${user.fullName.substring(0,1).toUpperCase()}
                            <div class="absolute inset-0 bg-black/40 rounded-full opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center cursor-pointer">
                                <span class="material-symbols-outlined text-white text-2xl">photo_camera</span>
                            </div>
                        </div>
                        <h3 class="font-headline-md text-headline-md text-deep-navy font-bold">${user.fullName}</h3>
                        <p class="text-on-surface-variant text-sm mt-1 mb-3">${user.email}</p>
                        
                        <div class="flex items-center gap-2 bg-yellow-400/20 text-yellow-700 text-xs font-bold px-3 py-1.5 rounded-full w-fit">
                            <span class="material-symbols-outlined text-[16px] text-yellow-500" style="font-variation-settings:'FILL' 1;">stars</span>
                            VoyagerElite Member
                        </div>
                    </div>
                </div>

                <!-- Dashboard Menu -->
                <div class="bg-white rounded-2xl border border-outline-variant/30 overflow-hidden shadow-sm">
                    <div class="py-2">
                        <a href="<c:url value='/user/profile'/>"
                           class="flex items-center gap-3 px-6 py-4 bg-primary/5 text-primary border-l-4 border-primary font-semibold transition-colors">
                            <span class="material-symbols-outlined text-[20px]" style="font-variation-settings:'FILL' 1;">account_circle</span>
                            <span class="text-sm">Thông tin cá nhân</span>
                        </a>

                        <c:if test="${user.roleId == 1}">
                            <a href="<c:url value='/admin/dashboard'/>"
                               class="flex items-center gap-3 px-6 py-4 text-deep-navy hover:bg-surface-container-low transition-colors group">
                                <span class="material-symbols-outlined text-[20px] text-ocean-blue" style="font-variation-settings:'FILL' 1;">admin_panel_settings</span>
                                <span class="text-sm font-medium group-hover:text-ocean-blue transition-colors">Trang quản trị</span>
                                <span class="ml-auto bg-red-500 text-white text-[10px] font-bold px-2 py-0.5 rounded-full">Admin</span>
                            </a>
                        </c:if>

                        <a href="<c:url value='/booking/my-bookings'/>"
                           class="flex items-center gap-3 px-6 py-4 text-deep-navy hover:bg-surface-container-low transition-colors group">
                            <span class="material-symbols-outlined text-[20px] text-[#7B61FF]" style="font-variation-settings:'FILL' 1;">confirmation_number</span>
                            <span class="text-sm font-medium group-hover:text-ocean-blue transition-colors">Đặt chỗ của tôi</span>
                        </a>

                        <a href="<c:url value='/payment/history'/>"
                           class="flex items-center gap-3 px-6 py-4 text-deep-navy hover:bg-surface-container-low transition-colors group">
                            <span class="material-symbols-outlined text-[20px] text-[#00A896]" style="font-variation-settings:'FILL' 1;">receipt_long</span>
                            <span class="text-sm font-medium group-hover:text-ocean-blue transition-colors">Lịch sử giao dịch</span>
                        </a>

                        <a href="<c:url value='/deals'/>"
                           class="flex items-center gap-3 px-6 py-4 text-deep-navy hover:bg-surface-container-low transition-colors group">
                            <span class="material-symbols-outlined text-[20px] text-action-orange" style="font-variation-settings:'FILL' 1;">local_offer</span>
                            <span class="text-sm font-medium group-hover:text-ocean-blue transition-colors">Khuyến mãi</span>
                        </a>

                        <a href="<c:url value='/auth/change-password'/>"
                           class="flex items-center gap-3 px-6 py-4 text-deep-navy hover:bg-surface-container-low transition-colors group">
                            <span class="material-symbols-outlined text-[20px] text-on-surface-variant" style="font-variation-settings:'FILL' 1;">lock</span>
                            <span class="text-sm font-medium group-hover:text-ocean-blue transition-colors">Đổi mật khẩu</span>
                        </a>

                        <div class="mx-6 border-t border-outline-variant/20 my-1"></div>

                        <a href="<c:url value='/auth/logout'/>"
                           class="flex items-center gap-3 px-6 py-4 text-red-500 hover:bg-red-50 transition-colors group">
                            <span class="material-symbols-outlined text-[20px]">logout</span>
                            <span class="text-sm font-medium group-hover:text-red-600 transition-colors">Đăng xuất</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Right Detail Form -->
            <div class="lg:col-span-8">
                <div class="bg-white rounded-2xl border border-outline-variant/30 p-6 md:p-8 shadow-sm">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-outline-variant/20 pb-6 mb-8">
                        <div>
                            <h2 class="font-headline-lg text-headline-md text-deep-navy font-bold">Thông tin cá nhân</h2>
                            <p class="text-on-surface-variant text-sm mt-1">Cập nhật thông tin chi tiết tài khoản của bạn tại đây.</p>
                        </div>
                        <div class="text-xs text-on-surface-variant bg-surface-container-low px-3 py-1.5 rounded-lg w-fit">
                            Ngày tham gia: <span class="font-semibold text-deep-navy">${user.createdAt}</span>
                        </div>
                    </div>

                    <!-- Alerts -->
                    <c:if test="${not empty success}">
                        <div class="flex items-center gap-3 bg-green-50 border border-green-200 text-green-800 p-4 rounded-xl mb-6">
                            <span class="material-symbols-outlined text-green-600">check_circle</span>
                            <p class="text-sm font-semibold">${success}</p>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="flex items-center gap-3 bg-red-50 border border-red-200 text-red-800 p-4 rounded-xl mb-6">
                            <span class="material-symbols-outlined text-red-600">error</span>
                            <p class="text-sm font-semibold">${error}</p>
                        </div>
                    </c:if>

                    <form action="<c:url value='/user/profile'/>" method="post" class="space-y-6 max-w-2xl">
                        <!-- Full Name -->
                        <div class="space-y-2">
                            <label class="block text-sm font-semibold text-deep-navy">Họ và tên <span class="text-red-500">*</span></label>
                            <div class="relative flex items-center">
                                <span class="material-symbols-outlined absolute left-3 text-outline text-[20px]">person</span>
                                <input type="text" 
                                       name="fullName" 
                                       value="${user.fullName}" 
                                       required
                                       class="pl-10 w-full border border-outline-variant rounded-xl px-4 py-3 text-sm focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all text-on-surface"
                                       placeholder="Nhập họ và tên đầy đủ"/>
                            </div>
                        </div>

                        <!-- Email (Read-only) -->
                        <div class="space-y-2">
                            <label class="block text-sm font-semibold text-deep-navy">Email đăng nhập</label>
                            <div class="relative flex items-center bg-surface-container-low rounded-xl">
                                <span class="material-symbols-outlined absolute left-3 text-outline text-[20px]">mail</span>
                                <input type="email" 
                                       value="${user.email}" 
                                       readonly
                                       class="pl-10 w-full border border-outline-variant bg-transparent rounded-xl px-4 py-3 text-sm cursor-not-allowed text-on-surface-variant"
                                       placeholder="example@mail.com"/>
                                <span class="material-symbols-outlined absolute right-3 text-outline text-[18px]">lock</span>
                            </div>
                            <p class="text-xs text-outline">Địa chỉ Email được liên kết cố định với tài khoản và không thể thay đổi.</p>
                        </div>

                        <!-- Phone -->
                        <div class="space-y-2">
                            <label class="block text-sm font-semibold text-deep-navy">Số điện thoại</label>
                            <div class="relative flex items-center">
                                <span class="material-symbols-outlined absolute left-3 text-outline text-[20px]">phone</span>
                                <input type="text" 
                                       name="phone" 
                                       value="${user.phone}" 
                                       class="pl-10 w-full border border-outline-variant rounded-xl px-4 py-3 text-sm focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all text-on-surface"
                                       placeholder="Nhập số điện thoại"/>
                            </div>
                        </div>

                        <!-- Address -->
                        <div class="space-y-2">
                            <label class="block text-sm font-semibold text-deep-navy">Địa chỉ</label>
                            <div class="relative flex items-center">
                                <span class="material-symbols-outlined absolute left-3 text-outline text-[20px]">location_on</span>
                                <input type="text" 
                                       name="address" 
                                       value="${user.address}" 
                                       class="pl-10 w-full border border-outline-variant rounded-xl px-4 py-3 text-sm focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all text-on-surface"
                                       placeholder="Nhập địa chỉ liên hệ"/>
                            </div>
                        </div>

                        <!-- Role Info (Static) -->
                        <div class="bg-surface-container-low rounded-xl p-4 flex items-center justify-between text-sm">
                            <span class="text-on-surface-variant font-medium">Vai trò tài khoản:</span>
                            <span class="font-bold text-deep-navy">
                                <c:choose>
                                    <c:when test="${user.roleId == 1}">
                                        Administrator
                                    </c:when>
                                    <c:otherwise>
                                        Customer
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <!-- Submit and Actions -->
                        <div class="flex flex-col sm:flex-row items-center gap-4 pt-4">
                            <button type="submit" 
                                    class="w-full sm:w-auto bg-ocean-blue hover:bg-primary text-white font-bold text-sm px-6 py-3 rounded-xl transition-all shadow-sm active:scale-95 flex items-center justify-center gap-2 cursor-pointer">
                                <span class="material-symbols-outlined text-[18px]">save</span> Cập nhật thông tin
                            </button>
                            <a href="<c:url value='/'/>" 
                               class="w-full sm:w-auto border border-outline-variant hover:bg-surface-container-low text-deep-navy font-semibold text-sm px-6 py-3 rounded-xl transition-colors text-center">
                                Trang chủ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>