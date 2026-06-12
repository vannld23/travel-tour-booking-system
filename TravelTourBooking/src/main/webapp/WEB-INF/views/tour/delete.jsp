<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <title>Xóa Tour</title>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .glass-card { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(8px); border: 1px solid rgba(224, 224, 224, 0.5); }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-8">
    <div class="glass-card rounded-xl p-8 shadow-lg max-w-xl w-full">
        <h1 class="text-2xl font-bold text-red-600 mb-4">Xác nhận xóa Tour</h1>
        <p class="text-gray-700 mb-6">Bạn có chắc chắn muốn xóa tour <strong>${tour.tourName}</strong> không?</p>
        <form method="post" action="${pageContext.request.contextPath}/tuormanagement/delete" class="flex gap-4">
            <input type="hidden" name="id" value="${tour.tourId}">
            <button class="px-6 py-3 rounded-lg bg-[#FF5E1F] text-white font-semibold" type="submit">Xóa</button>
            <a class="px-6 py-3 rounded-lg bg-gray-200 text-gray-800 font-semibold" href="<c:url value='/tuormanagement/list'/>">Hủy</a>
        </form>
    </div>
</body>
</html>
