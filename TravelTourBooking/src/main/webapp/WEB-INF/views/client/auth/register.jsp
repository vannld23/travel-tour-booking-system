<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Đăng ký tài khoản - VoyagerElite</title>
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
                    Khám Phá Thế Giới,<br/>Trải Nghiệm Trọn Vẹn.
                </h1>
                <p class="text-lg text-white/90 font-medium">
                    Đăng ký tài khoản để bắt đầu hành trình của bạn, tích luỹ điểm thưởng và nhận các ưu đãi giảm giá tour hấp dẫn từ VoyagerElite.
                </p>
            </div>

            <!-- Right card -->
            <div class="w-full max-w-[440px] bg-white rounded-2xl shadow-2xl overflow-hidden flex flex-col border border-gray-100">
                <!-- Card top promo banner -->
                <div class="bg-[#E8F5FD] px-6 py-4 flex items-center justify-between border-b border-[#0194F3]/10">
                    <div class="max-w-[75%]">
                        <h3 class="text-[#05285D] font-bold text-[14px] leading-snug">Chúng tôi có một ưu đãi vô cùng hấp dẫn!</h3>
                    </div>
                    <div class="w-12 h-12 flex-shrink-0 relative">
                        <span class="material-symbols-outlined text-4xl text-[#0194F3] absolute right-0 bottom-0">stay_current_portrait</span>
                        <span class="material-symbols-outlined text-lg text-orange-500 absolute left-1 top-0 animate-bounce">redeem</span>
                    </div>
                </div>

                <!-- Card body -->
                <div class="p-6 md:p-8 flex-grow">
                    <div class="mb-5">
                        <h2 class="text-2xl font-extrabold text-[#05285D]">Đăng ký thành viên</h2>
                        <p class="text-xs text-gray-500 mt-1">Tạo tài khoản VoyagerElite để bắt đầu hành trình của bạn</p>
                    </div>

                    <form class="space-y-3.5" action="<c:url value='/auth/register'/>" method="post">
                        <!-- Message -->
                        <c:if test="${not empty error}">
                            <div class="bg-red-50 text-red-600 px-4 py-3 rounded-xl text-xs font-semibold border border-red-100 text-left flex items-center gap-2">
                                <span class="material-symbols-outlined text-[18px]">error</span>
                                <span>${error}</span>
                            </div>
                        </c:if>

                        <!-- Input Full Name -->
                        <div>
                            <label class="block text-xs font-bold text-gray-500 mb-1" for="fullName">Họ và Tên</label>
                            <input class="w-full px-4 py-2.5 rounded-xl border border-gray-300 focus:border-[#0194F3] focus:ring-1 focus:ring-[#0194F3] outline-none transition-all text-sm font-medium" id="fullName" name="fullName" value="${fullName}" placeholder="Nguyễn Văn A" type="text" required/>
                        </div>

                        <!-- Input Email -->
                        <div>
                            <label class="block text-xs font-bold text-gray-500 mb-1" for="email">Địa chỉ Email</label>
                            <input class="w-full px-4 py-2.5 rounded-xl border border-gray-300 focus:border-[#0194F3] focus:ring-1 focus:ring-[#0194F3] outline-none transition-all text-sm font-medium" id="email" name="email" value="${email}" placeholder="admin@voyagerelite.com" type="email" required/>
                        </div>

                        <!-- Input Password -->
                        <div>
                            <label class="block text-xs font-bold text-gray-500 mb-1" for="password">Mật khẩu</label>
                            <div class="relative">
                                <input class="w-full pl-4 pr-10 py-2.5 rounded-xl border border-gray-300 focus:border-[#0194F3] focus:ring-1 focus:ring-[#0194F3] outline-none transition-all text-sm font-medium" id="password" name="password" placeholder="Tối thiểu 6 ký tự" type="password" required/>
                                <button class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-[#05285D]" type="button" id="toggle-password">
                                    <span class="material-symbols-outlined text-lg">visibility</span>
                                </button>
                            </div>
                        </div>

                        <!-- Input Confirm Password -->
                        <div>
                            <label class="block text-xs font-bold text-gray-500 mb-1" for="confirmPassword">Xác nhận mật khẩu</label>
                            <div class="relative">
                                <input class="w-full pl-4 pr-10 py-2.5 rounded-xl border border-gray-300 focus:border-[#0194F3] focus:ring-1 focus:ring-[#0194F3] outline-none transition-all text-sm font-medium" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" type="password" required/>
                                <button class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-[#05285D]" type="button" id="toggle-confirm-password">
                                    <span class="material-symbols-outlined text-lg">visibility</span>
                                </button>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <button class="w-full bg-[#0194F3] hover:bg-[#0082d6] text-white py-3 rounded-xl font-bold shadow-md active:scale-[0.99] transition-all text-sm mt-3" type="submit">
                            Đăng ký
                        </button>
                    </form>

                    <!-- Divider -->
                    <div class="relative flex items-center my-4">
                        <div class="flex-grow border-t border-gray-200"></div>
                        <span class="px-3 text-[10px] text-gray-400 font-bold uppercase tracking-wider">Hoặc đăng ký với</span>
                        <div class="flex-grow border-t border-gray-200"></div>
                    </div>

                    <!-- Social Buttons -->
                    <div class="grid grid-cols-2 gap-3">
                        <button class="flex items-center justify-center gap-2 py-2 px-3 rounded-xl border border-gray-300 hover:bg-gray-50 transition-colors text-xs font-bold text-gray-700">
                            <svg class="w-4 h-4" viewbox="0 0 24 24">
                                <path d="M12 5.04c1.64 0 3.12.56 4.29 1.67l3.22-3.22C17.52 1.64 14.95 1 12 1 7.73 1 4.14 3.42 2.37 6.94l3.78 2.94C7.03 7.15 9.3 5.04 12 5.04z" fill="#EA4335"></path>
                                <path d="M23.49 12.27c0-.8-.07-1.57-.2-2.32H12v4.39h6.44c-.28 1.48-1.12 2.74-2.38 3.58l3.7 2.87c2.16-1.99 3.43-4.93 3.43-8.52z" fill="#4285F4"></path>
                                <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09L2.06 7.02C1.1 8.94.55 11.11.55 13.4s.55 4.46 1.51 6.38l3.78-2.94c-.45-1.32-.45-2.75 0-4.07z" fill="#FBBC05"></path>
                                <path d="M12 23c3.24 0 5.97-1.08 7.96-2.91l-3.7-2.87c-1.08.72-2.47 1.15-4.26 1.15-3.4 0-6.28-2.3-7.31-5.41l-3.78 2.94C3.12 20.42 6.71 23 12 23z" fill="#34A853"></path>
                            </svg>
                            Google
                        </button>
                        <button class="flex items-center justify-center gap-2 py-2 px-3 rounded-xl border border-gray-300 hover:bg-gray-50 transition-colors text-xs font-bold text-gray-700">
                            <svg class="w-4 h-4" fill="#1877F2" viewbox="0 0 24 24">
                                <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"></path>
                            </svg>
                            Facebook
                        </button>
                    </div>
                </div>

                <!-- Footer link -->
                <div class="mt-5 pt-4 border-t border-gray-100 text-center text-sm text-gray-600">
                    Đã có tài khoản? 
                    <a class="text-[#0194F3] font-bold hover:underline ml-1" href="<c:url value='/auth/login'/>">Đăng nhập ngay</a>
                </div>
            </div>
        </div>

        <!-- Footer section -->
        <div class="flex flex-col sm:flex-row justify-between items-center w-full max-w-7xl mx-auto gap-2 border-t border-white/10 pt-4 mt-auto">
            <span class="text-white/70 text-[11px]">Bằng cách đăng ký, bạn đồng ý với Điều khoản & Điều kiện của chúng tôi.</span>
            <span class="text-white/80 text-[11px]">© 2026 VoyagerElite. All rights reserved.</span>
        </div>
    </div>

    <script>
        // Toggle password visibility
        const togglePasswordBtn = document.getElementById('toggle-password');
        const passwordInput = document.getElementById('password');
        if (togglePasswordBtn && passwordInput) {
            togglePasswordBtn.addEventListener('click', () => {
                const isPassword = passwordInput.getAttribute('type') === 'password';
                passwordInput.setAttribute('type', isPassword ? 'text' : 'password');
                togglePasswordBtn.querySelector('.material-symbols-outlined').textContent = isPassword ? 'visibility_off' : 'visibility';
            });
        }

        // Toggle confirm password visibility
        const toggleConfirmPasswordBtn = document.getElementById('toggle-confirm-password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        if (toggleConfirmPasswordBtn && confirmPasswordInput) {
            toggleConfirmPasswordBtn.addEventListener('click', () => {
                const isPassword = confirmPasswordInput.getAttribute('type') === 'password';
                confirmPasswordInput.setAttribute('type', isPassword ? 'text' : 'password');
                toggleConfirmPasswordBtn.querySelector('.material-symbols-outlined').textContent = isPassword ? 'visibility_off' : 'visibility';
            });
        }
    </script>
</body>
</html>
