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
                        <!-- Logged-in user avatar dropdown -->
                        <div class="relative group">
                            <button class="flex items-center gap-2 bg-surface-container-low rounded-full px-4 py-2 hover:bg-surface-container transition-colors cursor-pointer" id="user-menu-btn">
                                <span class="material-symbols-outlined text-ocean-blue text-[22px]" style="font-variation-settings: 'FILL' 1;">account_circle</span>
                                <span class="text-deep-navy font-semibold text-sm hidden md:block max-w-[120px] truncate">${sessionScope.currentUser.fullName}</span>
                                <span class="material-symbols-outlined text-on-surface-variant text-[18px]">expand_more</span>
                            </button>
                            <!-- Dropdown -->
                            <div class="absolute right-0 top-full mt-2 w-52 bg-white rounded-xl shadow-xl border border-outline-variant/30 py-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 z-50">
                                <div class="px-4 py-2 border-b border-outline-variant/20 mb-1">
                                    <p class="text-xs text-on-surface-variant font-medium">Đăng nhập với</p>
                                    <p class="text-sm text-deep-navy font-bold truncate">${sessionScope.currentUser.email}</p>
                                </div>
                                <c:if test="${sessionScope.currentUser.roleId == 1}">
                                    <a href="<c:url value='/admin/dashboard'/>" class="flex items-center gap-2 px-4 py-2 text-sm text-deep-navy hover:bg-surface-container-low transition-colors font-medium">
                                        <span class="material-symbols-outlined text-[18px] text-ocean-blue">admin_panel_settings</span>
                                        Trang quản trị
                                    </a>
                                </c:if>
                                <a href="<c:url value='/auth/change-password'/>" class="flex items-center gap-2 px-4 py-2 text-sm text-deep-navy hover:bg-surface-container-low transition-colors font-medium">
                                    <span class="material-symbols-outlined text-[18px] text-on-surface-variant">lock</span>
                                    Đổi mật khẩu
                                </a>
                                <div class="border-t border-outline-variant/20 mt-1 pt-1">
                                    <a href="<c:url value='/auth/logout'/>" class="flex items-center gap-2 px-4 py-2 text-sm text-red-600 hover:bg-red-50 transition-colors font-medium">
                                        <span class="material-symbols-outlined text-[18px]">logout</span>
                                        Đăng xuất
                                    </a>
                                </div>
                            </div>
                        </div>
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
