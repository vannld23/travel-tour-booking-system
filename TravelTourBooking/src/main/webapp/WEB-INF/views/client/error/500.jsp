<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Lỗi hệ thống | VoyagerElite</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-[#F2F3F3] min-h-screen flex items-center justify-center p-6">
    <div class="max-w-md w-full bg-white rounded-2xl shadow-xl border border-gray-200 overflow-hidden text-center p-8">
        
        <!-- Icon cảnh báo động -->
        <div class="mx-auto flex items-center justify-center h-20 w-20 rounded-full bg-red-100 mb-6 animate-pulse">
            <svg class="h-12 w-12 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
            </svg>
        </div>

        <h1 class="text-3xl font-extrabold text-[#05285D] mb-3">
            ${empty errorTitle ? "Lỗi hệ thống (500)" : errorTitle}
        </h1>
        
        <p class="text-gray-600 mb-6 text-sm sm:text-base">
            ${empty errorMessage ? "Hệ thống đang gặp sự cố kết nối hoặc đang được bảo trì. Vui lòng thử lại sau ít phút." : errorMessage}
        </p>

        <!-- Chi tiết lỗi thu gọn (Cho lập trình viên kiểm tra) -->
        <c:if test="${not empty exceptionType}">
            <div class="text-left bg-gray-50 border border-gray-200 rounded-lg p-4 mb-6 text-xs text-gray-500 font-mono overflow-auto max-h-32">
                <strong class="text-red-500 block mb-1">Loại lỗi: ${exceptionType}</strong>
                <span>Nội dung: ${exceptionMessage}</span>
            </div>
        </c:if>

        <div class="flex flex-col gap-2">
            <a href="${pageContext.request.contextPath}/" 
               class="inline-flex items-center justify-center px-6 py-3 bg-[#0194F3] hover:bg-[#0082d6] text-white font-semibold rounded-xl transition-all shadow-md">
                Quay lại Trang Chủ
            </a>
            <button onclick="window.location.reload()" 
                    class="inline-flex items-center justify-center px-6 py-3 bg-gray-100 hover:bg-gray-200 text-[#05285D] font-semibold rounded-xl transition-all border border-gray-200">
                Thử tải lại trang
            </button>
        </div>
        
        <p class="text-xs text-gray-400 mt-8">VoyagerElite Travel Tour Booking System</p>
    </div>
</body>
</html>
