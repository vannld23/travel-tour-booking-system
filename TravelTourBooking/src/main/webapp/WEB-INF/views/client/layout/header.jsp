<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>${not empty pageTitle ? pageTitle : 'VoyagerElite - Khám phá thế giới theo cách của bạn'}</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        "colors": {
                            "error-container": "#ffdad6",
                            "on-tertiary-fixed": "#001a43",
                            "surface-bright": "#f8f9f9",
                            "primary-container": "#0078c7",
                            "ocean-blue": "#0194F3",
                            "tertiary-fixed": "#d9e2ff",
                            "surface-container": "#edeeee",
                            "secondary-container": "#ff5e1f",
                            "primary": "#005f9f",
                            "on-surface-variant": "#3f4752",
                            "on-error": "#ffffff",
                            "surface-container-highest": "#e1e3e3",
                            "deep-navy": "#05285D",
                            "on-secondary-fixed-variant": "#832600",
                            "outline-variant": "#bfc7d4",
                            "on-surface": "#191c1c",
                            "outline": "#707884",
                            "on-secondary": "#ffffff",
                            "background": "#f8f9f9",
                            "on-tertiary": "#ffffff",
                            "secondary-fixed-dim": "#ffb59d",
                            "on-background": "#191c1c",
                            "status-warning": "#F39C12",
                            "surface-container-lowest": "#ffffff",
                            "on-error-container": "#93000a",
                            "error": "#ba1a1a",
                            "action-orange": "#FF5E1F",
                            "surface-gray": "#F2F3F3",
                            "surface-container-low": "#f3f4f4",
                            "on-primary-fixed-variant": "#00497c",
                            "on-secondary-container": "#551600",
                            "surface-dim": "#d9dada",
                            "primary-fixed-dim": "#9dcaff",
                            "tertiary-container": "#5a74ad",
                            "inverse-primary": "#9dcaff",
                            "on-tertiary-container": "#fefcff",
                            "status-success": "#00BA4A",
                            "surface": "#f8f9f9",
                            "surface-variant": "#e1e3e3",
                            "surface-tint": "#0061a3",
                            "secondary": "#ab3500",
                            "on-secondary-fixed": "#390c00",
                            "inverse-on-surface": "#f0f1f1",
                            "surface-container-high": "#e7e8e8",
                            "tertiary-fixed-dim": "#afc6ff",
                            "tertiary": "#415b92",
                            "primary-fixed": "#d1e4ff",
                            "on-primary": "#ffffff",
                            "on-primary-container": "#fdfcff",
                            "secondary-fixed": "#ffdbd0",
                            "on-primary-fixed": "#001d36",
                            "on-tertiary-fixed-variant": "#2a457b",
                            "inverse-surface": "#2e3131"
                        },
                        "borderRadius": {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "full": "9999px"
                        },
                        "spacing": {
                            "margin-desktop": "40px",
                            "gutter": "24px",
                            "unit": "4px",
                            "margin-mobile": "16px",
                            "container-max": "1280px"
                        },
                        "fontFamily": {
                            "headline-md": ["Inter"],
                            "headline-lg-mobile": ["Inter"],
                            "headline-lg": ["Inter"],
                            "body-md": ["Inter"],
                            "label-sm": ["Inter"],
                            "label-md": ["Inter"],
                            "display-lg": ["Inter"],
                            "body-lg": ["Inter"]
                        },
                        "fontSize": {
                            "headline-md": ["20px", {"lineHeight": "28px", "fontWeight": "600"}],
                            "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "700"}],
                            "headline-lg": ["32px", {"lineHeight": "40px", "fontWeight": "700"}],
                            "body-md": ["14px", {"lineHeight": "20px", "fontWeight": "400"}],
                            "label-sm": ["12px", {"lineHeight": "16px", "fontWeight": "500"}],
                            "label-md": ["14px", {"lineHeight": "16px", "letterSpacing": "0.01em", "fontWeight": "600"}],
                            "display-lg": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                            "body-lg": ["16px", {"lineHeight": "24px", "fontWeight": "400"}]
                        }
                    },
                },
            }
        </script>
        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f8f9f9;
            }
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
            .tour-card {
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .tour-card:hover {
                transform: translateY(-8px) scale(1.02);
                box-shadow: 0px 8px 24px rgba(0, 0, 0, 0.08);
            }
            .glass-effect {
                background: rgba(255, 255, 255, 0.85);
                backdrop-filter: blur(8px);
            }
        </style>
    </head>
    <body class="text-on-surface">

        <!-- TopNavBar -->
        <nav class="bg-surface-container-lowest shadow-sm docked full-width top-0 sticky z-50 h-20 transition-all duration-200">
            <div class="flex justify-between items-center w-full px-margin-desktop max-w-container-max mx-auto h-full">
                <div class="flex items-center gap-8">
                    <a href="<c:url value='/'/>" class="text-headline-md font-headline-md text-primary font-bold">VoyagerElite</a>
                    <div class="hidden md:flex gap-6">
                        <a class="${empty pageTitle || (!pageTitle.contains('Điểm đến') && !pageTitle.contains('Ưu đãi') && !pageTitle.contains('Hỗ trợ')) ? 'text-primary border-b-2 border-primary pb-1 font-semibold' : 'text-deep-navy font-medium hover:text-ocean-blue'} transition-all duration-200" href="<c:url value='/'/>">Tours</a>
                        <a class="${not empty pageTitle && pageTitle.contains('Điểm đến') ? 'text-primary border-b-2 border-primary pb-1 font-semibold' : 'text-deep-navy font-medium hover:text-ocean-blue'} transition-colors" href="<c:url value='/destinations'/>">Điểm đến</a>
                        <a class="${not empty pageTitle && pageTitle.contains('Ưu đãi') ? 'text-primary border-b-2 border-primary pb-1 font-semibold' : 'text-deep-navy font-medium hover:text-ocean-blue'} transition-colors" href="<c:url value='/deals'/>">Ưu đãi</a>
                        <a class="${not empty pageTitle && pageTitle.contains('Hỗ trợ') ? 'text-primary border-b-2 border-primary pb-1 font-semibold' : 'text-deep-navy font-medium hover:text-ocean-blue'} transition-colors" href="<c:url value='/support'/>">Hỗ trợ</a>
                    </div>
                </div>

                <!-- Right side: Auth buttons or User menu -->
                <div class="flex items-center gap-3">
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <!-- Logged-in: Traveloka-style user pill + dropdown -->
                            <div class="relative" id="user-dropdown-wrapper">
                                <!-- Trigger pill -->
                                <button id="user-menu-btn"
                                        onclick="toggleUserMenu()"
                                        class="flex items-center gap-2 border border-outline-variant rounded-full pl-2 pr-3 py-1.5 hover:shadow-md transition-all duration-200 bg-white cursor-pointer select-none">
                                    <span class="w-8 h-8 rounded-full bg-ocean-blue flex items-center justify-center text-white font-bold text-sm flex-shrink-0">
                                        ${sessionScope.currentUser.fullName.substring(0,1).toUpperCase()}
                                    </span>
                                    <span class="text-deep-navy font-semibold text-sm hidden md:block max-w-[110px] truncate">${sessionScope.currentUser.fullName}</span>
                                    <span class="inline-flex items-center gap-1 bg-yellow-400/20 text-yellow-700 text-[11px] font-bold px-2 py-0.5 rounded-full hidden md:flex">
                                        <span class="material-symbols-outlined text-[13px] text-yellow-500" style="font-variation-settings:'FILL' 1;">stars</span>
                                        Member
                                    </span>
                                    <span class="material-symbols-outlined text-on-surface-variant text-[18px]" id="user-chevron">expand_more</span>
                                </button>

                                <!-- Dropdown panel -->
                                <div id="user-dropdown-menu"
                                     class="hidden absolute right-0 top-[calc(100%+8px)] w-64 bg-white rounded-2xl shadow-2xl border border-outline-variant/20 overflow-hidden z-50">

                                    <!-- Header info -->
                                    <div class="bg-gradient-to-r from-ocean-blue to-primary px-5 py-4 text-white">
                                        <div class="flex items-center gap-3">
                                            <span class="w-11 h-11 rounded-full bg-white/20 flex items-center justify-center text-white font-extrabold text-lg flex-shrink-0">
                                                ${sessionScope.currentUser.fullName.substring(0,1).toUpperCase()}
                                            </span>
                                            <div class="min-w-0">
                                                <p class="font-bold text-sm truncate">${sessionScope.currentUser.fullName}</p>
                                                <p class="text-white/75 text-[11px] truncate">${sessionScope.currentUser.email}</p>
                                            </div>
                                        </div>
                                        <div class="mt-3 flex items-center gap-2 bg-white/15 rounded-full px-3 py-1.5 w-fit">
                                            <span class="material-symbols-outlined text-yellow-300 text-[16px]" style="font-variation-settings:'FILL' 1;">stars</span>
                                            <span class="text-xs font-bold">VoyagerElite Member</span>
                                        </div>
                                    </div>

                                    <!-- Menu items -->
                                    <div class="py-2">
                                        <c:if test="${sessionScope.currentUser.roleId == 1}">
                                            <a href="<c:url value='/admin/dashboard'/>"
                                               class="flex items-center gap-3 px-5 py-3 hover:bg-surface-container-low transition-colors group">
                                                <span class="material-symbols-outlined text-[20px] text-ocean-blue" style="font-variation-settings:'FILL' 1;">admin_panel_settings</span>
                                                <span class="text-sm font-semibold text-deep-navy group-hover:text-ocean-blue transition-colors">Trang quản trị</span>
                                                <span class="ml-auto bg-red-500 text-white text-[10px] font-bold px-2 py-0.5 rounded-full">Admin</span>
                                            </a>
                                            <div class="mx-4 border-t border-outline-variant/20"></div>
                                        </c:if>

                                        <a href="<c:url value='/booking/my-bookings'/>"
                                           class="flex items-center gap-3 px-5 py-3 hover:bg-surface-container-low transition-colors group">
                                            <span class="material-symbols-outlined text-[20px] text-[#7B61FF]" style="font-variation-settings:'FILL' 1;">confirmation_number</span>
                                            <span class="text-sm font-medium text-deep-navy group-hover:text-ocean-blue transition-colors">Đặt chỗ của tôi</span>
                                        </a>

                                        <a href="<c:url value='/payment/history'/>"
                                           class="flex items-center gap-3 px-5 py-3 hover:bg-surface-container-low transition-colors group">
                                            <span class="material-symbols-outlined text-[20px] text-[#00A896]" style="font-variation-settings:'FILL' 1;">receipt_long</span>
                                            <span class="text-sm font-medium text-deep-navy group-hover:text-ocean-blue transition-colors">Lịch sử giao dịch</span>
                                        </a>

                                        <a href="<c:url value='/deals'/>"
                                           class="flex items-center gap-3 px-5 py-3 hover:bg-surface-container-low transition-colors group">
                                            <span class="material-symbols-outlined text-[20px] text-action-orange" style="font-variation-settings:'FILL' 1;">local_offer</span>
                                            <span class="text-sm font-medium text-deep-navy group-hover:text-ocean-blue transition-colors">Khuyến mãi</span>
                                            <span class="ml-auto bg-action-orange text-white text-[10px] font-bold px-2 py-0.5 rounded-full">Mới!</span>
                                        </a>

                                        <a href="<c:url value='/user/profile'/>"
                                           class="flex items-center gap-3 px-5 py-3 hover:bg-surface-container-low transition-colors group">
                                            <span class="material-symbols-outlined text-[20px] text-primary" style="font-variation-settings:'FILL' 1;">
                                                person
                                            </span>
                                            <span class="text-sm font-medium text-deep-navy group-hover:text-ocean-blue transition-colors">
                                                Xem hồ sơ
                                            </span>
                                        </a>

                                        <a href="<c:url value='/auth/change-password'/>"
                                           class="flex items-center gap-3 px-5 py-3 hover:bg-surface-container-low transition-colors group">
                                            <span class="material-symbols-outlined text-[20px] text-on-surface-variant" style="font-variation-settings:'FILL' 1;">lock</span>
                                            <span class="text-sm font-medium text-deep-navy group-hover:text-ocean-blue transition-colors">Đổi mật khẩu</span>
                                        </a>

                                        <div class="mx-4 my-1 border-t border-outline-variant/20"></div>

                                        <a href="<c:url value='/auth/logout'/>"
                                           class="flex items-center gap-3 px-5 py-3 hover:bg-red-50 transition-colors group">
                                            <span class="material-symbols-outlined text-[20px] text-red-500">logout</span>
                                            <span class="text-sm font-medium text-red-500 group-hover:text-red-600 transition-colors">Đăng xuất</span>
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <script>
                                function toggleUserMenu() {
                                    const menu = document.getElementById('user-dropdown-menu');
                                    const chevron = document.getElementById('user-chevron');
                                    const isOpen = !menu.classList.contains('hidden');
                                    menu.classList.toggle('hidden');
                                    chevron.textContent = isOpen ? 'expand_more' : 'expand_less';
                                }
                                // Close when clicking outside
                                document.addEventListener('click', function (e) {
                                    const wrapper = document.getElementById('user-dropdown-wrapper');
                                    if (wrapper && !wrapper.contains(e.target)) {
                                        document.getElementById('user-dropdown-menu').classList.add('hidden');
                                        document.getElementById('user-chevron').textContent = 'expand_more';
                                    }
                                });
                            </script>
                        </c:when>
                        <c:otherwise>
                            <!-- Guest: Login + Register buttons -->
                            <a href="<c:url value='/auth/login'/>"
                               class="text-deep-navy font-semibold text-sm px-4 py-2 rounded-lg hover:bg-surface-container-low transition-colors hidden md:block">
                                Đăng nhập
                            </a>
                            <a href="<c:url value='/auth/register'/>"
                               class="bg-ocean-blue text-white font-semibold text-sm px-5 py-2 rounded-lg hover:bg-primary transition-all shadow-sm active:scale-95">
                                Đăng ký
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </nav>
