<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Quên mật khẩu - VoyagerElite</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            colors: {
              "ocean-blue": "#0194F3",
              "deep-navy": "#05285D",
            }
          }
        }
      }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans min-h-screen relative flex flex-col justify-between overflow-x-hidden">
    <!-- Traveloka-style Left Logo Banner -->
    <div class="absolute top-0 left-0 bg-[#0194F3] text-white px-10 pt-5 pb-7 rounded-br-[80px] shadow-lg z-20 flex items-center gap-2 select-none">
        <span class="material-symbols-outlined text-white text-3xl font-bold">explore</span>
        <span class="text-2xl font-black tracking-tight">VoyagerElite</span>
    </div>

    <!-- Background Image -->
    <div class="absolute inset-0 z-0">
        <div class="w-full h-full bg-black/25 absolute inset-0"></div>
        <img class="w-full h-full object-cover filter brightness-[0.8]" alt="Bromo Sunrise Background" src="<c:url value='/resource/images/login.jpg'/>"/>
    </div>

    <!-- Main Container -->
    <div class="relative z-10 min-h-screen w-full flex flex-col justify-between px-6 py-6 md:px-16 md:py-8">
        <!-- Top Nav Link -->
        <div class="flex justify-end items-center">
            <a href="<c:url value='/'/>" class="text-white hover:text-blue-100 font-semibold flex items-center gap-1.5 transition-all drop-shadow-sm text-sm">
                <span class="material-symbols-outlined text-base">arrow_back</span>
                Vào Trang chủ VoyagerElite
            </a>
        </div>

        <!-- Center content area -->
        <div class="flex flex-col lg:flex-row items-center justify-between my-auto gap-12 w-full max-w-7xl mx-auto">
            <!-- Left Header text -->
            <div class="text-white max-w-xl hidden lg:block drop-shadow-md">
                <h1 class="text-5xl font-extrabold leading-[1.25] tracking-wide mb-6">
                    Bảo Mật Tài Khoản,<br/>An Tâm Trải Nghiệm.
                </h1>
                <p class="text-lg text-white/90 font-medium">
                    Hãy cung cấp email đăng ký để chúng tôi giúp bạn đặt lại mật khẩu nhanh chóng và tiếp tục hành trình khám phá.
                </p>
            </div>

            <!-- Right card -->
            <div class="w-full max-w-[440px] bg-white rounded-2xl shadow-2xl overflow-hidden flex flex-col border border-gray-100">
                <!-- Card top promo banner -->
                <div class="bg-[#E8F5FD] px-6 py-4 flex items-center justify-between border-b border-[#0194F3]/10">
                    <div class="max-w-[75%]">
                        <h3 class="text-[#05285D] font-bold text-[14px] leading-snug">Hệ thống bảo mật tài khoản VoyagerElite</h3>
                    </div>
                    <div class="w-12 h-12 flex-shrink-0 relative">
                        <span class="material-symbols-outlined text-4xl text-[#0194F3] absolute right-0 bottom-0">key</span>
                        <span class="material-symbols-outlined text-lg text-orange-500 absolute left-1 top-0 animate-bounce">lock</span>
                    </div>
                </div>

                <!-- Card body -->
                <div class="p-6 md:p-8 flex-grow">
                    <div class="mb-6">
                        <h2 class="text-2xl font-extrabold text-[#05285D]">Quên mật khẩu</h2>
                        <p class="text-xs text-gray-500 mt-1">Nhập địa chỉ email của bạn để lấy lại quyền truy cập</p>
                    </div>

                    <form class="space-y-4" action="<c:url value='/auth/forgot-password'/>" method="post">
                        <!-- Messages -->
                        <c:if test="${not empty error}">
                            <div class="bg-red-50 text-red-600 px-4 py-3 rounded-xl text-xs font-semibold border border-red-100 text-left flex items-center gap-2">
                                <span class="material-symbols-outlined text-[18px]">error</span>
                                <span>${error}</span>
                            </div>
                        </c:if>

                        <!-- Input Email -->
                        <div>
                            <label class="block text-xs font-bold text-gray-500 mb-1.5" for="email">Địa chỉ Email đã đăng ký</label>
                            <input class="w-full px-4 py-3 rounded-xl border border-gray-300 focus:border-[#0194F3] focus:ring-1 focus:ring-[#0194F3] outline-none transition-all text-sm font-medium" id="email" name="email" value="${email}" placeholder="admin@voyagerelite.com" type="email" required/>
                        </div>

                        <!-- Submit Button -->
                        <button class="w-full bg-[#0194F3] hover:bg-[#0082d6] text-white py-3 rounded-xl font-bold shadow-md active:scale-[0.99] transition-all text-sm mt-2" type="submit">
                            Gửi yêu cầu đặt lại
                        </button>
                    </form>

                    <!-- Footer link -->
                    <div class="mt-8 pt-5 border-t border-gray-100 text-center text-sm text-gray-600">
                        <a class="text-[#0194F3] font-bold hover:underline inline-flex items-center gap-1.5" href="<c:url value='/auth/login'/>">
                            <span class="material-symbols-outlined text-base">arrow_back</span>
                            Quay lại Đăng nhập
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer section -->
        <div class="flex flex-col sm:flex-row justify-between items-center w-full max-w-7xl mx-auto gap-2 border-t border-white/10 pt-4 mt-auto">
            <span class="text-white/70 text-[11px]">Bằng cách tiếp tục, bạn đồng ý với Điều khoản & Điều kiện của chúng tôi.</span>
            <span class="text-white/80 text-[11px]">© 2026 VoyagerElite. All rights reserved.</span>
        </div>
    </div>
</body>
</html>
