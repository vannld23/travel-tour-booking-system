<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../layout/header.jsp" %>

<!-- Fallback check for tour image -->
<c:set var="tourImg" value="${tour.imageUrl}"/>
<c:if test="${empty tourImg || (!tourImg.startsWith('http') && !tourImg.contains('/resources/'))}">
    <c:choose>
        <c:when test="${tour.tourName.toLowerCase().contains('dalat') || tour.tourName.toLowerCase().contains('da lat') || tour.tourName.toLowerCase().contains('đà lạt')}">
            <c:set var="tourImg" value="${pageContext.request.contextPath}/resource/images/da_lat.jpg"/>
        </c:when>
        <c:when test="${tour.tourName.toLowerCase().contains('danang') || tour.tourName.toLowerCase().contains('da nang') || tour.tourName.toLowerCase().contains('đà nẵng')}">
            <c:set var="tourImg" value="${pageContext.request.contextPath}/resource/images/da_nang.jpg"/>
        </c:when>
        <c:when test="${tour.tourName.toLowerCase().contains('hue') || tour.tourName.toLowerCase().contains('huế')}">
            <c:set var="tourImg" value="${pageContext.request.contextPath}/resource/images/Hue.jpg"/>
        </c:when>
        <c:when test="${tour.tourName.toLowerCase().contains('nha trang')}">
            <c:set var="tourImg" value="https://images.unsplash.com/photo-1540206395-68808572332f?w=1200&q=80"/>
        </c:when>
        <c:when test="${tour.tourName.toLowerCase().contains('phu quoc') || tour.tourName.toLowerCase().contains('phú quốc')}">
            <c:set var="tourImg" value="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200&q=80"/>
        </c:when>
        <c:otherwise>
            <c:set var="tourImg" value="https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=1200&q=80"/>
        </c:otherwise>
    </c:choose>
</c:if>

<!-- Custom Bento Bento Grid Images Configuration -->
<c:set var="bento1" value="${tourImg}"/>
<c:set var="bento2" value="https://lh3.googleusercontent.com/aida-public/AB6AXuCEqPOS3XK45UBphWk0ODrRJYaNd4j9Z6ayRGwlCRo87JefphLxPpBLFXennNzwYI-o2udPc3Y0UR0S0b0r9j7BmOn4p_RBibThPmqVwDL-umggWPzDpbS_YfYE9ONewmx_nxW3mRVrQjR3tOnPNOjsnYoRgWPm8JgTEeUvnpVbLwYkTvwmAmkcMYgeHMGjGj4GTR43zv1XGeCLeu1hDLKIUMp75TKz1HoYRZ3Kpj54i2L3qvn2PN5xo6o_bBjTvHbRArGqEqr_zqA"/>
<c:set var="bento3" value="https://lh3.googleusercontent.com/aida-public/AB6AXuBZiTaIeUhzYbPO0_Yfsak5n3mBDL_5DNWdeSu-QjY9BoCA-m-BjU7i_M1iuEOnv09JWjO9DUvtVgkMUH-hhK35lGAdelj5Qzb7nKYxeexT70lrb2ojslRlkpdhUlfpaWscO3RgRQwQONPH-HaejOzd_O9IaiWLhr_91pNuvo1LHeCcRnQEZ8aztWp_3gHjtN_-jIkNclpV_7FYXv0txiT4TqzsFPT_r4dshm0x5YegaO2S3c6g5rvBZ5zbSHowb3j9oCIzQPZBWVo"/>
<c:set var="bento4" value="https://lh3.googleusercontent.com/aida-public/AB6AXuAeZD4ttLHVfNySRLlfROcXFwCavZHA90olEaiWWtw0f50L491dmiwS7KMpV-d6HRq6aTEGIVYtVQaAKw25pVwr8jH-JjSDhiY1Yg5l5wDRItT1xl2uD5gSpf2u0V2BU0eGKgqAgMTTG_31Xqfz8bVGButx3hopqFh9ar5YvI7f3Uv8DzhAlKzV0Acw9m8mKm99MhUS4-ZjAWTMWB_-zyq3oIqa_MUjtY9zkhmKm5Jitgs2dBanGOsvpy8-Y6PCGoGUwmknsMcd2z4"/>

<!-- Customize Bento Images for specific locations -->
<c:if test="${tour.tourName.toLowerCase().contains('dalat') || tour.tourName.toLowerCase().contains('đà lạt')}">
    <c:set var="bento2" value="https://images.unsplash.com/photo-1589308078059-be1415eab4c3?w=600&q=80"/>
    <c:set var="bento3" value="https://images.unsplash.com/photo-1508873696983-2df519f0397e?w=600&q=80"/>
    <c:set var="bento4" value="https://images.unsplash.com/photo-1528127269322-539801943592?w=600&q=80"/>
</c:if>

<style>
    .bento-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-template-rows: repeat(2, 200px);
        gap: 16px;
    }
    @media (max-width: 768px) {
        .bento-grid {
            grid-template-columns: repeat(2, 1fr);
            grid-template-rows: repeat(4, 150px);
        }
    }
    .card-shadow { box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.05); }
    .card-hover:hover { 
        box-shadow: 0px 8px 24px rgba(0, 0, 0, 0.08); 
        transform: scale(1.02);
        transition: all 0.2s ease-in-out;
    }
</style>

<!-- Hero Section -->
<section class="relative h-[614px] min-h-[400px] w-full overflow-hidden">
    <div class="absolute inset-0 bg-black/40 z-10"></div>
    <img class="w-full h-full object-cover" src="${tourImg}" alt="${tour.tourName}"/>
    <div class="absolute inset-0 z-20 flex flex-col justify-end pb-16 px-margin-desktop max-w-container-max mx-auto">
        <nav aria-label="Breadcrumb" class="flex mb-4 text-white/80 font-label-sm text-label-sm">
            <ol class="inline-flex items-center space-x-2">
                <li>Trang chủ</li>
                <li><span class="material-symbols-outlined text-[16px]">chevron_right</span></li>
                <li>Tours</li>
                <li><span class="material-symbols-outlined text-[16px]">chevron_right</span></li>
                <li class="text-white">${tour.tourName}</li>
            </ol>
        </nav>
        <h1 class="text-white font-display-lg text-display-lg md:text-display-lg max-md:text-headline-lg-mobile">${tour.tourName}</h1>
        <p class="text-white/90 font-body-lg text-body-lg mt-2 max-w-2xl">${tour.destinationName} • ${tour.durationDays} Ngày</p>
    </div>
</section>

<!-- Main Content Cluster -->
<main class="max-w-container-max mx-auto px-margin-desktop py-16">
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-gutter">
        <!-- Left Column: Content -->
        <div class="lg:col-span-8 space-y-16">
            <!-- Photo Gallery (Bento Style) -->
            <section>
                <h2 class="font-headline-lg text-headline-lg mb-6 text-deep-navy font-bold">Khám phá vẻ đẹp</h2>
                <div class="bento-grid">
                    <div class="col-span-2 row-span-2 rounded-xl overflow-hidden group">
                        <img class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" src="${bento1}" alt="Bento grid 1"/>
                    </div>
                    <div class="col-span-2 rounded-xl overflow-hidden group">
                        <img class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" src="${bento2}" alt="Bento grid 2"/>
                    </div>
                    <div class="rounded-xl overflow-hidden group">
                        <img class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" src="${bento3}" alt="Bento grid 3"/>
                    </div>
                    <div class="rounded-xl overflow-hidden group">
                        <img class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" src="${bento4}" alt="Bento grid 4"/>
                    </div>
                </div>
            </section>

            <!-- Detailed Description -->
            <section class="prose prose-lg max-w-none">
                <h2 class="font-headline-lg text-headline-lg text-deep-navy mb-4 font-bold">Tổng quan về ${tour.tourName}</h2>
                <div class="space-y-6 text-on-surface-variant font-body-lg">
                    <p class="whitespace-pre-line">${tour.description}</p>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8 my-8">
                        <div class="bg-surface-gray p-6 rounded-xl">
                            <h3 class="font-headline-md text-headline-md text-ocean-blue mb-2 font-bold">Chi tiết hành trình</h3>
                            <p class="text-body-md text-on-surface-variant">
                                Thời lượng: <strong>${tour.durationDays} Ngày</strong><br/>
                                Điểm đến: <strong>${tour.destinationName}</strong><br/>
                                Sức chứa tối đa: <strong>${tour.maxCapacity} khách</strong><br/>
                                Trạng thái: <strong>${tour.statusLabel}</strong>
                            </p>
                        </div>
                        <div class="bg-surface-gray p-6 rounded-xl">
                            <h3 class="font-headline-md text-headline-md text-ocean-blue mb-2 font-bold">Khí hậu & Thời điểm khởi hành</h3>
                            <p class="text-body-md text-on-surface-variant">
                                Ngày bắt đầu: <strong>${tour.startDate}</strong><br/>
                                Ngày kết thúc: <strong>${tour.endDate}</strong><br/>
                                Thích hợp nhất cho kỳ nghỉ dưỡng sang trọng đẳng cấp và gắn kết gia đình.
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Detailed Itinerary Timeline -->
            <section class="bg-white p-8 rounded-xl card-shadow border border-outline-variant/30">
                <h2 class="font-headline-lg text-headline-lg text-deep-navy mb-6 font-bold">Lịch trình chi tiết</h2>
                <div class="h-1 w-20 bg-action-orange mb-8"></div>
                
                <c:choose>
                    <c:when test="${not empty itineraries}">
                        <div class="relative border-l-2 border-outline-variant/50 ml-4 space-y-12">
                            <c:forEach var="iti" items="${itineraries}">
                                <div class="relative pl-8">
                                    <div class="absolute -left-[9px] top-1.5 w-4 h-4 rounded-full bg-ocean-blue border-2 border-white ring-4 ring-ocean-blue/10"></div>
                                    <div class="flex items-center gap-3 mb-2">
                                        <span class="bg-ocean-blue/10 text-ocean-blue text-xs font-bold px-2.5 py-1 rounded-full uppercase">Ngày ${iti.dayNumber}</span>
                                    </div>
                                    <p class="text-on-surface-variant font-body-md leading-relaxed whitespace-pre-line">${iti.activityDescription}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-12 text-on-surface-variant bg-surface-container-low rounded-lg border border-dashed border-outline-variant">
                            <span class="material-symbols-outlined text-4xl mb-3 opacity-60">map</span>
                            <p>Lịch trình chi tiết đang được cập nhật. Vui lòng liên hệ hỗ trợ viên.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Popular / Related Tours -->
            <section>
                <div class="flex justify-between items-end mb-8">
                    <div>
                        <h2 class="font-headline-lg text-headline-lg text-deep-navy font-bold">Tour Phổ Biến</h2>
                        <p class="text-on-surface-variant mt-1 text-body-md">Những trải nghiệm được yêu thích nhất tại hệ thống</p>
                    </div>
                    <a class="text-ocean-blue font-label-md flex items-center hover:underline" href="<c:url value='/'/>">
                        Xem tất cả <span class="material-symbols-outlined ml-1">arrow_forward</span>
                    </a>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-gutter">
                    <c:choose>
                        <c:when test="${not empty relatedTours}">
                            <c:forEach var="rel" items="${relatedTours}">
                                <c:set var="relImg" value="${rel.imageUrl}"/>
                                <c:if test="${empty relImg || !relImg.startsWith('http')}">
                                    <c:set var="relImg" value="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600&q=80"/>
                                </c:if>
                                <div onclick="window.location.href='<c:url value="/tour/detail?id=${rel.tourId}"/>'" class="bg-white rounded-xl overflow-hidden card-shadow card-hover cursor-pointer group flex flex-col justify-between">
                                    <div>
                                        <div class="h-48 overflow-hidden">
                                            <img class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" src="${relImg}" alt="${rel.tourName}"/>
                                        </div>
                                        <div class="p-4">
                                            <div class="flex items-center text-on-surface-variant mb-2">
                                                <span class="material-symbols-outlined text-[18px] mr-1 text-ocean-blue">location_on</span>
                                                <span class="text-label-sm font-label-sm uppercase tracking-wider font-semibold">${rel.destinationName}</span>
                                            </div>
                                            <h3 class="font-headline-md text-headline-md text-deep-navy line-clamp-1 mb-2 font-bold">${rel.tourName}</h3>
                                        </div>
                                    </div>
                                    <div class="p-4 pt-0">
                                        <div class="flex justify-between items-center mt-4 pt-4 border-t border-outline-variant">
                                            <div class="flex items-center">
                                                <span class="material-symbols-outlined text-status-warning" style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="ml-1 font-label-md">4.9</span>
                                            </div>
                                            <div class="text-action-orange font-headline-md font-bold">
                                                <fmt:formatNumber value="${rel.price}" type="number" groupingUsed="true"/>đ
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Fallback Tour Card 1 -->
                            <div class="bg-white rounded-xl overflow-hidden card-shadow card-hover cursor-pointer group">
                                <div class="h-48 overflow-hidden">
                                    <img class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBKMacs19-779TqjHjyUHuAlbfLVB_SPOkPt1s5c8G6l0BkoSe7Uvq7LuQSqxJS_e6RIKyN5q3VldXc8dZVFHw4kXGBQo9ko2o3tUgmw73-hrtBYcFXLFmKqoGCtoTjttio70ntQiKty3JRR2lt9ElhSynEXMw9XW5LJ78tlCzb4yFPZhsBQyEfgKRdV-s8lROv0z7vcmO4y4OHPGsQKYYr4dr67neAit7C7XOcMQ5I9AM2oXd5FM4qGbzJ7-UJVM9tEp_G4tPaqRo" alt="Du Thuyền 5 Sao"/>
                                </div>
                                <div class="p-4">
                                    <div class="flex items-center text-on-surface-variant mb-2">
                                        <span class="material-symbols-outlined text-[18px] mr-1 text-ocean-blue">location_on</span>
                                        <span class="text-label-sm font-label-sm uppercase tracking-wider">Vịnh Hạ Long</span>
                                    </div>
                                    <h3 class="font-headline-md text-headline-md text-deep-navy line-clamp-1 mb-2 font-bold">Du Thuyền 5 Sao - 2 Ngày 1 Đêm</h3>
                                    <div class="flex justify-between items-center mt-4 pt-4 border-t border-outline-variant">
                                        <div class="flex items-center">
                                            <span class="material-symbols-outlined text-status-warning" style="font-variation-settings: 'FILL' 1;">star</span>
                                            <span class="ml-1 font-label-md">4.9 (120)</span>
                                        </div>
                                        <div class="text-action-orange font-headline-md font-bold">3.500.000đ</div>
                                    </div>
                                </div>
                            </div>
                            <!-- Fallback Tour Card 2 -->
                            <div class="bg-white rounded-xl overflow-hidden card-shadow card-hover cursor-pointer group">
                                <div class="h-48 overflow-hidden">
                                    <img class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCDo5gUec7renDxe5pFCUFl2A_5S7XhN1OAJgvF4hayf3GGTNAmhSC6PU-GnutStiVkXnKyEsY6fwIAYHUP948zSk1rZhm14f5Wb7mmdPUL9-uCaoJ7tg9w2KxR7e4Lz8zESlzNRQSqUaoEH_3NT4T8136OkIe4a77hCLrVvpfu7J-Bp5hIkzfiH-fhZ08cmNalPEhjHe-biWBywr94W4Js5KgVRFWwKGSFDCuVqLXOteZj5AuXfC12gUfXwXzQcrSf8aztJwygMLo" alt="Khám Phá Vịnh Lan Hạ"/>
                                </div>
                                <div class="p-4">
                                    <div class="flex items-center text-on-surface-variant mb-2">
                                        <span class="material-symbols-outlined text-[18px] mr-1 text-ocean-blue">location_on</span>
                                        <span class="text-label-sm font-label-sm uppercase tracking-wider">Vịnh Lan Hạ</span>
                                    </div>
                                    <h3 class="font-headline-md text-headline-md text-deep-navy line-clamp-1 mb-2 font-bold">Khám Phá Vịnh Lan Hạ Bằng Kayak</h3>
                                    <div class="flex justify-between items-center mt-4 pt-4 border-t border-outline-variant">
                                        <div class="flex items-center">
                                            <span class="material-symbols-outlined text-status-warning" style="font-variation-settings: 'FILL' 1;">star</span>
                                            <span class="ml-1 font-label-md">4.8 (85)</span>
                                        </div>
                                        <div class="text-action-orange font-headline-md font-bold">1.200.000đ</div>
                                    </div>
                                </div>
                            </div>
                            <!-- Fallback Tour Card 3 -->
                            <div class="bg-white rounded-xl overflow-hidden card-shadow card-hover cursor-pointer group">
                                <div class="h-48 overflow-hidden">
                                    <img class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDzn-y2QrmAuFl75aVJYxnn5ng29_ylqMbIOhOKi18GoAHe7y3kdLTNtyw-prCh48Hfwd5FOQ6gymkS50KbDBknLTnBqCstgIV5GR17B4iTzKRZT92YmuJ1Vck914MyUqRzlomctHDBEOmxf-wVJlmABNyglcA7qLQrZK-tazJYn7tR4WnPFm76iYg5uq66fcxz4sdv6JRB-XSXjdGEubiglHdGSa1Un2oKNGZ2AV9LcIAzngU2ZqDiShG4zlwbrWZRK68Hima1fPQ" alt="Thủy phi cơ"/>
                                </div>
                                <div class="p-4">
                                    <div class="flex items-center text-on-surface-variant mb-2">
                                        <span class="material-symbols-outlined text-[18px] mr-1 text-ocean-blue">location_on</span>
                                        <span class="text-label-sm font-label-sm uppercase tracking-wider">Hạ Long</span>
                                    </div>
                                    <h3 class="font-headline-md text-headline-md text-deep-navy line-clamp-1 mb-2 font-bold">Trải Nghiệm Thủy Phi Cơ Ngắm Vịnh</h3>
                                    <div class="flex justify-between items-center mt-4 pt-4 border-t border-outline-variant">
                                        <div class="flex items-center">
                                            <span class="material-symbols-outlined text-status-warning" style="font-variation-settings: 'FILL' 1;">star</span>
                                            <span class="ml-1 font-label-md">5.0 (42)</span>
                                        </div>
                                        <div class="text-action-orange font-headline-md font-bold">2.800.000đ</div>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>
        </div>

        <!-- Right Column: Sidebar -->
        <aside class="lg:col-span-4 space-y-8">
            <!-- Booking Widget Card -->
            <div class="bg-white p-8 rounded-xl card-shadow border border-outline-variant/30">
                <span class="text-xs text-on-surface-variant font-semibold uppercase tracking-wider block mb-1">Giá Trọn Gói Từ</span>
                <div class="flex items-baseline gap-2 mb-6">
                    <span class="text-action-orange text-3xl font-extrabold">
                        <fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>₫
                    </span>
                    <span class="text-xs text-on-surface-variant">/ khách</span>
                </div>

                <div class="border-t border-b border-outline-variant/30 py-4 mb-6 space-y-3.5">
                    <div class="flex justify-between items-center text-sm">
                        <span class="text-on-surface-variant">Thời gian</span>
                        <span class="font-semibold text-deep-navy">${tour.durationDays} Ngày</span>
                    </div>
                    <div class="flex justify-between items-center text-sm">
                        <span class="text-on-surface-variant">Ngày khởi hành</span>
                        <span class="font-semibold text-deep-navy">${tour.startDate}</span>
                    </div>
                    <div class="flex justify-between items-center text-sm">
                        <span class="text-on-surface-variant">Ngày kết thúc</span>
                        <span class="font-semibold text-deep-navy">${tour.endDate}</span>
                    </div>
                </div>

                <a href="<c:url value='/booking/create?tourId=${tour.tourId}'/>" class="block w-full text-center bg-action-orange text-white py-4 rounded-xl font-bold shadow-lg hover:shadow-xl hover:opacity-90 active:scale-95 transition-all text-body-lg">Đặt Tour Ngay</a>
            </div>

            <!-- Quick Facts Card -->
            <div class="bg-white p-8 rounded-xl card-shadow border border-outline-variant">
                <h3 class="font-headline-md text-headline-md text-deep-navy mb-6 flex items-center font-bold">
                    <span class="material-symbols-outlined mr-2 text-ocean-blue">info</span> Thông Tin Nhanh
                </h3>
                <ul class="space-y-6">
                    <li class="flex items-start">
                        <span class="material-symbols-outlined text-ocean-blue mr-4">calendar_month</span>
                        <div>
                            <p class="font-label-md text-label-md text-deep-navy font-semibold">Thời điểm tốt nhất</p>
                            <p class="text-on-surface-variant text-body-md">Tháng 4 - Tháng 6 hoặc Tháng 9 - Tháng 11</p>
                        </div>
                    </li>
                    <li class="flex items-start">
                        <span class="material-symbols-outlined text-ocean-blue mr-4">language</span>
                        <div>
                            <p class="font-label-md text-label-md text-deep-navy font-semibold">Ngôn ngữ</p>
                            <p class="text-on-surface-variant text-body-md">Tiếng Việt (Tiếng Anh rất phổ biến)</p>
                        </div>
                    </li>
                    <li class="flex items-start">
                        <span class="material-symbols-outlined text-ocean-blue mr-4">payments</span>
                        <div>
                            <p class="font-label-md text-label-md text-deep-navy font-semibold">Tiền tệ</p>
                            <p class="text-on-surface-variant text-body-md">Việt Nam Đồng (VND)</p>
                        </div>
                    </li>
                    <li class="flex items-start">
                        <span class="material-symbols-outlined text-ocean-blue mr-4">thermostat</span>
                        <div>
                            <p class="font-label-md text-label-md text-deep-navy font-semibold">Nhiệt độ trung bình</p>
                            <p class="text-on-surface-variant text-body-md">18°C - 32°C tùy theo mùa</p>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Need Help CTA -->
            <div class="bg-deep-navy p-8 rounded-xl text-white relative overflow-hidden">
                <div class="relative z-10">
                    <h3 class="font-headline-md text-headline-md mb-4 font-bold">Bạn cần hỗ trợ?</h3>
                    <p class="text-white/80 text-body-md mb-6">Chuyên gia du lịch của chúng tôi luôn sẵn sàng tư vấn lịch trình riêng biệt cho bạn.</p>
                    <div class="space-y-3">
                        <a href="tel:19001234" class="w-full bg-ocean-blue text-white py-3 rounded-lg font-label-md flex justify-center items-center hover:bg-ocean-blue/90 transition-colors">
                            <span class="material-symbols-outlined mr-2">call</span> Liên hệ ngay
                        </a>
                        <button onclick="alert('Tính năng chat trực tuyến đang được kết nối...')" class="w-full bg-white/10 border border-white/20 text-white py-3 rounded-lg font-label-md flex justify-center items-center hover:bg-white/20 transition-colors">
                            <span class="material-symbols-outlined mr-2">chat_bubble</span> Chat với tư vấn viên
                        </button>
                    </div>
                </div>
                <!-- Subtle background decoration -->
                <div class="absolute -bottom-12 -right-12 w-48 h-48 bg-ocean-blue/20 rounded-full blur-3xl"></div>
            </div>

            <!-- Map Section -->
            <div class="rounded-xl overflow-hidden card-shadow h-64 border border-outline-variant">
                <div class="bg-surface-gray h-full w-full flex items-center justify-center relative">
                    <img class="absolute inset-0 w-full h-full object-cover opacity-50 grayscale" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCrN1hV5DW5McywsG8a0LanQO2akM-7Bk-agBpZ6yg38BjXrO6F6zHVN5J7nUm5EWTz4sC23RazLkw8mQ_SmJ2NQUC7Cd73sy7t6-nOp7K5ocSgYc8nBzVbD98VLr3QCryGEXTteQ16u2X3d8d50NOKygHl694LiNgufK9qV2Zog04wrrjVRtmzMb_wRQ_KqETjruG-zQHOpM60Biea3dA8edpv-ybEony51cuoZNu2iN4oafYuxKytzvGeVxQjpOfN_x0u0H_u4qc" alt="Map outline"/>
                    <div class="z-10 text-center px-6">
                        <span class="material-symbols-outlined text-ocean-blue text-4xl mb-2" style="font-variation-settings: 'FILL' 1;">location_on</span>
                        <p class="font-headline-md text-deep-navy font-bold">Vị trí điểm đến</p>
                        <p class="text-label-sm text-on-surface-variant font-semibold">${tour.destinationName}</p>
                        <button onclick="window.open('https://maps.google.com/?q=' + encodeURIComponent('${tour.destinationName}'))" class="mt-4 text-ocean-blue font-label-md hover:underline font-bold">Mở bản đồ lớn</button>
                    </div>
                </div>
            </div>
        </aside>
    </div>
</main>

<%@ include file="../layout/footer.jsp" %>
