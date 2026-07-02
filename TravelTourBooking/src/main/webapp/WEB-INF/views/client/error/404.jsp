<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Không tìm thấy trang | VoyagerElite</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-[#F2F3F3] min-h-screen flex items-center justify-center p-6">
    <div class="max-w-md w-full bg-white rounded-2xl shadow-xl border border-gray-200 overflow-hidden text-center p-8">
        
        <!-- Icon 404 sinh động -->
        <div class="mx-auto flex items-center justify-center h-24 w-24 rounded-full bg-blue-50 mb-6 text-[#0194F3]">
            <span class="text-5xl font-extrabold">404</span>
        </div>

        <h1 class="text-2xl font-bold text-[#05285D] mb-3">
            ${empty errorTitle ? "Không tìm thấy trang" : errorTitle}
        </h1>
        
        <p class="text-gray-500 mb-8 text-sm sm:text-base leading-relaxed">
            ${empty errorMessage ? "Đường dẫn bạn truy cập không tồn tại, đã bị đổi tên hoặc tạm thời không khả dụng." : errorMessage}
        </p>

        <div class="flex flex-col gap-2">
            <a href="${pageContext.request.contextPath}/" 
               class="inline-flex items-center justify-center px-6 py-3 bg-[#0194F3] hover:bg-[#0082d6] text-white font-semibold rounded-xl transition-all shadow-md">
                Về Trang Chủ
            </a>
            <button onclick="window.history.back()" 
                    class="inline-flex items-center justify-center px-6 py-3 bg-gray-100 hover:bg-gray-200 text-[#05285D] font-semibold rounded-xl transition-all border border-gray-200">
                ← Quay lại trang trước
            </button>
        </div>
        
        <p class="text-xs text-gray-400 mt-8">VoyagerElite Travel Tour Booking System</p>
    </div>
</body>
</html>
