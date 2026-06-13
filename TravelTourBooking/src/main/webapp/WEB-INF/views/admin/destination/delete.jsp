<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <title>Quản trị VoyagerElite - Xóa Điểm Đến</title>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "ocean-blue": "#0194F3",
                        "deep-navy": "#05285D",
                        "surface-gray": "#F2F3F3",
                        "surface-bright": "#f8f9f9",
                        "surface-container": "#edeeee",
                        "outline-variant": "#bfc7d4",
                        "on-surface": "#191c1c",
                        "on-surface-variant": "#3f4752",
                        "action-orange": "#FF5E1F"
                    }
                }
            }
        };
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F2F3F3; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .glass-card { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(8px); border: 1px solid rgba(224, 224, 224, 0.5); }
    </style>
</head>
<body class="bg-surface-gray">
<div class="flex min-h-screen">
    <%@ include file="../layout/sidebar.jsp" %>

<main class="flex-1 ml-[280px] p-8 min-h-screen">
    <div class="flex justify-between items-center mb-8">
        <div>
            <nav class="flex items-center gap-2 text-on-surface-variant text-sm mb-2">
                <a class="hover:text-ocean-blue" href="<c:url value='/destination/list'/>">Quản lý Điểm đến</a>
                <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                <span class="text-ocean-blue font-semibold">Xóa Điểm Đến</span>
            </nav>
            <h2 class="text-3xl font-bold text-deep-navy">Xác nhận xóa Điểm đến</h2>
        </div>
    </div>

    <div class="max-w-xl">
        <section class="glass-card rounded-xl p-8 shadow-[0px_4px_12px_rgba(0,0,0,0.05)] border-red-200 bg-red-50/10">
            <div class="flex items-center gap-3 text-action-orange mb-6">
                <span class="material-symbols-outlined text-3xl">warning</span>
                <h3 class="text-xl font-bold">Cảnh báo hành động</h3>
            </div>
            
            <p class="text-on-surface mb-6 leading-relaxed">
                Bạn có chắc chắn muốn xóa điểm đến <strong class="text-deep-navy font-bold">"${destination.destinationName}"</strong>? 
                Hành động này không thể hoàn tác và có thể ảnh hưởng đến các Tour đang thuộc điểm đến này.
            </p>

            <form method="post" action="<c:url value='/destination/delete'/>" class="flex gap-4">
                <input type="hidden" name="id" value="${destination.destinationId}">
                <button class="px-6 py-2.5 rounded-lg bg-action-orange text-white font-medium shadow hover:brightness-110 transition-all" type="submit">Xác nhận Xóa</button>
                <a class="px-6 py-2.5 rounded-lg border border-outline-variant text-on-surface-variant font-medium bg-white hover:bg-surface-bright transition-all" href="<c:url value='/destination/list'/>">Hủy bỏ</a>
            </form>
        </section>
    </div>
</main>
</div>
</body>
</html>
