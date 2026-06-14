<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Ưu đãi | VoyagerElite Luxury Travel" />
<%@ include file="../layout/header.jsp" %>

<!-- Hero Section -->
<section class="relative h-[500px] flex items-center overflow-hidden">
    <div class="absolute inset-0 z-0">
        <img alt="Luxury Coast Resort" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC1QAEsiEtdfIpK1MlCXCdDa-d5GImMpSb7AJpRgoa_dTHTCJjDUleSoevB-hZuaig3IPyMnOK89DNiewsUg07pC7bFwUbLIkQdPX04nU4YzGCgRU3JkFuGm7mHhU2k3TNadxrBczKpU8pvlHK6P_NNXBDkgs88TaeAR6lPLUZxPqhlwtUYqPSTxvAcfSyVLnEJ2HiErPeCKZQGaVElLoRrzgJzbGB7_7UGq9pJXCn8EtpZb3H_qoOHGUKf2S-L8Xs4vxQoF_6w5CQ"/>
        <div class="absolute inset-0 bg-gradient-to-r from-deep-navy/85 via-deep-navy/60 to-transparent"></div>
    </div>
    <div class="relative z-10 max-w-container-max mx-auto px-margin-desktop w-full text-white">
        <h1 class="font-display-lg text-display-lg max-w-2xl mb-6 leading-tight">Ưu đãi Đặc biệt</h1>
        <p class="font-body-lg text-body-lg max-w-xl opacity-90 mb-8 leading-relaxed">Khám phá thế giới với phong cách thượng lưu cùng những ưu đãi độc quyền chỉ dành riêng cho khách hàng của VoyagerElite.</p>
        <div class="flex gap-4">
            <a href="#flash-sales" class="bg-action-orange text-white px-8 py-3.5 rounded-lg font-bold shadow-lg hover:shadow-xl hover:bg-secondary active:scale-95 transition-all">Khám phá ngay</a>
            <a href="#member-benefits" class="bg-white/10 backdrop-blur-md border border-white/20 text-white px-8 py-3.5 rounded-lg font-bold hover:bg-white/20 active:scale-95 transition-all">Tìm hiểu thêm</a>
        </div>
    </div>
</section>

<!-- Flash Sales Section -->
<section id="flash-sales" class="py-16 bg-white scroll-mt-20">
    <div class="max-w-container-max mx-auto px-margin-desktop">
        <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-10">
            <div class="flex items-center gap-3">
                <span class="material-symbols-outlined text-action-orange text-4xl animate-pulse" style="font-variation-settings: 'FILL' 1;">bolt</span>
                <h2 class="font-headline-lg text-headline-lg text-deep-navy font-bold">Giờ vàng giá sốc</h2>
            </div>
            <div class="flex gap-4 items-center" id="countdown">
                <span class="font-label-md text-on-surface-variant font-semibold">Kết thúc sau:</span>
                <div class="flex gap-2 select-none">
                    <div class="bg-deep-navy text-white px-3 py-2 rounded-lg font-bold text-headline-md min-w-[3rem] text-center" id="hours">04</div>
                    <div class="bg-deep-navy text-white px-3 py-2 rounded-lg font-bold text-headline-md min-w-[3rem] text-center" id="minutes">22</div>
                    <div class="bg-deep-navy text-white px-3 py-2 rounded-lg font-bold text-headline-md min-w-[3rem] text-center" id="seconds">45</div>
                </div>
            </div>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-gutter">
            <c:choose>
                <c:when test="${not empty flashSaleTours}">
                    <c:forEach var="tour" items="${flashSaleTours}" varStatus="status">
                        <!-- Dynamic Flash Sale Card -->
                        <c:set var="tourImg" value="${tour.imageUrl}"/>
                        <c:if test="${empty tourImg || !tourImg.startsWith('http')}">
                            <c:choose>
                                <c:when test="${status.index == 0}">
                                    <c:set var="tourImg" value="https://lh3.googleusercontent.com/aida-public/AB6AXuDog0WiEFUxutKfh6109nvwLvgemEIgBHRlLp7Nllz-feAf1kxauN_1e5CB-qWs0ZcAVG8j0OrqXE-IR3emNZxzBMFXIL1Em9qgkbb5sny6CiLCtypK5j6MNO9lkAn9RvzxpM7yE9sqYjM6HnZyn8XU1FD1BW13lcJVyU7j1W0jXqjMwBD2MPxQz3eB2qW1-q_oPGN7CcVotg-oPzh3jnVPeK1WQaPXDFGM51XutUuc86ZXb0YO5lVIrvzLqZV_Udm-INeOuIo9lUE"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="tourImg" value="https://lh3.googleusercontent.com/aida-public/AB6AXuBMhFIQKPSGEExZ_8FOoqz-hB7TX8JbXDi_WpshTPILMF-kFNBbuxoBXSOdTY9ZlD2K-RiIKrmBsgjxAwzY65Q-hLzvtKDOeB_CaNqRTFB_LI1mdWqcZC3ZqbEsnIuz2fKenEQKntyAvnnsvwU1e5FFwM1xxIpAeWNFfsOD8KS9HAG4kG33XVCrkq32hvKNVBSuS8oLjRLzB0T2VamCFQu12il_ghhcVK-vxPhyy7ePBEEpURJsna-LfzLYsXSDaLG-rTE0d4EnMes"/>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        
                        <!-- Simulated Discount Rates -->
                        <c:set var="discountPct" value="${status.index == 0 ? 45 : 30}"/>
                        <c:set var="originalPrice" value="${tour.price * 1.5}"/>

                        <div class="flex flex-col md:flex-row bg-surface-container-low rounded-xl overflow-hidden group hover:shadow-xl transition-shadow border border-outline-variant/30">
                            <a href="<c:url value='/tour/detail?id=${tour.tourId}'/>" class="w-full md:w-2/5 relative h-48 md:h-auto overflow-hidden block">
                                <img alt="${tour.tourName}" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" src="${tourImg}"/>
                                <div class="absolute top-4 left-4 bg-action-orange text-white px-3 py-1 rounded-full font-bold text-label-sm shadow-md">-${discountPct}%</div>
                            </a>
                            <div class="p-6 flex flex-col justify-between w-full md:w-3/5">
                                <div>
                                    <a href="<c:url value='/tour/detail?id=${tour.tourId}'/>" class="hover:text-ocean-blue transition-colors">
                                        <h3 class="font-headline-md text-headline-md text-deep-navy font-bold mb-2 line-clamp-2">${tour.tourName}</h3>
                                    </a>
                                    <p class="text-on-surface-variant font-body-md mb-4 line-clamp-3">${tour.description}</p>
                                </div>
                                <div class="flex items-end justify-between mt-4">
                                    <div>
                                        <span class="text-on-surface-variant line-through text-label-sm block">
                                            <fmt:formatNumber value="${originalPrice}" type="number" groupingUsed="true"/>đ
                                        </span>
                                        <span class="text-action-orange font-bold text-headline-lg">
                                            <fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ
                                        </span>
                                    </div>
                                    <div class="flex gap-2">
                                        <a href="<c:url value='/tour/detail?id=${tour.tourId}'/>" class="border border-ocean-blue text-ocean-blue px-3 py-2 rounded-lg font-bold hover:bg-ocean-blue hover:text-white transition-all text-xs flex items-center">
                                            Chi tiết
                                        </a>
                                        <a href="<c:url value='/booking/create?tourId=${tour.tourId}'/>" class="bg-ocean-blue text-white p-3 rounded-lg hover:bg-primary transition-all active:scale-95 flex items-center justify-center shadow-md">
                                            <span class="material-symbols-outlined">shopping_cart</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Fallback Flash Sale Card 1 -->
                    <div class="flex flex-col md:flex-row bg-surface-container-low rounded-xl overflow-hidden group hover:shadow-xl transition-shadow border border-outline-variant/30">
                        <div class="w-full md:w-2/5 relative h-48 md:h-auto overflow-hidden">
                            <img alt="Luxury Hotel Suite Maldives" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDog0WiEFUxutKfh6109nvwLvgemEIgBHRlLp7Nllz-feAf1kxauN_1e5CB-qWs0ZcAVG8j0OrqXE-IR3emNZxzBMFXIL1Em9qgkbb5sny6CiLCtypK5j6MNO9lkAn9RvzxpM7yE9sqYjM6HnZyn8XU1FD1BW13lcJVyU7j1W0jXqjMwBD2MPxQz3eB2qW1-q_oPGN7CcVotg-oPzh3jnVPeK1WQaPXDFGM51XutUuc86ZXb0YO5lVIrvzLqZV_Udm-INeOuIo9lUE"/>
                            <div class="absolute top-4 left-4 bg-action-orange text-white px-3 py-1 rounded-full font-bold text-label-sm shadow-md">-45%</div>
                        </div>
                        <div class="p-6 flex flex-col justify-between w-full md:w-3/5">
                            <div>
                                <h3 class="font-headline-md text-headline-md text-deep-navy font-bold mb-2 group-hover:text-ocean-blue transition-colors">Resort 5 Sao Maldives - Trọn gói</h3>
                                <p class="text-on-surface-variant font-body-md mb-4 line-clamp-2">Trải nghiệm kỳ nghỉ thiên đường tại Maldives với dịch vụ đưa đón bằng thủy phi cơ và bữa tối lãng mạn dưới ánh sao.</p>
                            </div>
                            <div class="flex items-end justify-between mt-4">
                                <div>
                                    <span class="text-on-surface-variant line-through text-label-sm block">45.000.000đ</span>
                                    <span class="text-action-orange font-bold text-headline-lg">24.750.000đ</span>
                                </div>
                                <button class="bg-ocean-blue text-white p-3.5 rounded-lg hover:bg-primary transition-all active:scale-95 flex items-center justify-center shadow-md">
                                    <span class="material-symbols-outlined">shopping_cart</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- Fallback Flash Sale Card 2 -->
                    <div class="flex flex-col md:flex-row bg-surface-container-low rounded-xl overflow-hidden group hover:shadow-xl transition-shadow border border-outline-variant/30">
                        <div class="w-full md:w-2/5 relative h-48 md:h-auto overflow-hidden">
                            <img alt="Private Villa Sunset" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBMhFIQKPSGEExZ_8FOoqz-hB7TX8JbXDi_WpshTPILMF-kFNBbuxoBXSOdTY9ZlD2K-RiIKrmBsgjxAwzY65Q-hLzvtKDOeB_CaNqRTFB_LI1mdWqcZC3ZqbEsnIuz2fKenEQKntyAvnnsvwU1e5FFwM1xxIpAeWNFfsOD8KS9HAG4kG33XVCrkq32hvKNVBSuS8oLjRLzB0T2VamCFQu12il_ghhcVK-vxPhyy7ePBEEpURJsna-LfzLYsXSDaLG-rTE0d4EnMes"/>
                            <div class="absolute top-4 left-4 bg-action-orange text-white px-3 py-1 rounded-full font-bold text-label-sm shadow-md">-30%</div>
                        </div>
                        <div class="p-6 flex flex-col justify-between w-full md:w-3/5">
                            <div>
                                <h3 class="font-headline-md text-headline-md text-deep-navy font-bold mb-2 group-hover:text-ocean-blue transition-colors">Hành trình Di sản Trung Âu</h3>
                                <p class="text-on-surface-variant font-body-md mb-4 line-clamp-2">Khám phá vẻ đẹp cổ kính của Prague, Vienna và Budapest trong hành trình 10 ngày đêm sang trọng.</p>
                            </div>
                            <div class="flex items-end justify-between mt-4">
                                <div>
                                    <span class="text-on-surface-variant line-through text-label-sm block">68.000.000đ</span>
                                    <span class="text-action-orange font-bold text-headline-lg">47.600.000đ</span>
                                </div>
                                <button class="bg-ocean-blue text-white p-3.5 rounded-lg hover:bg-primary transition-all active:scale-95 flex items-center justify-center shadow-md">
                                    <span class="material-symbols-outlined">shopping_cart</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<!-- Limited Time Offers (Grid) -->
<section class="py-16 bg-surface-gray">
    <div class="max-w-container-max mx-auto px-margin-desktop">
        <div class="text-center mb-12">
            <h2 class="font-headline-lg text-headline-lg text-deep-navy mb-2 font-bold">Ưu đãi giới hạn</h2>
            <p class="text-on-surface-variant font-body-lg">Đừng bỏ lỡ cơ hội khám phá những điểm đến mơ ước với mức giá tốt nhất.</p>
        </div>
        
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-gutter">
            <c:choose>
                <c:when test="${not empty limitedTours}">
                    <c:forEach var="tour" items="${limitedTours}" varStatus="status">
                        <!-- Dynamic Tour Card -->
                        <c:set var="tourImg" value="${tour.imageUrl}"/>
                        <c:if test="${empty tourImg || !tourImg.startsWith('http')}">
                            <c:choose>
                                <c:when test="${tour.tourName.toLowerCase().contains('dalat') || tour.tourName.toLowerCase().contains('đà lạt')}">
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1589308078059-be1415eab4c3?w=600&q=80"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('nha trang')}">
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1540206395-68808572332f?w=600&q=80"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('phu quoc') || tour.tourName.toLowerCase().contains('phú quốc')}">
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600&q=80"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=600&q=80"/>
                                </c:otherwise>
                            </c:choose>
                        </c:if>

                        <c:set var="originalPrice" value="${tour.price * 1.15}"/>

                        <div class="bg-white rounded-xl overflow-hidden shadow-[0px_4px_12px_rgba(0,0,0,0.05)] hover:shadow-[0px_8px_24px_rgba(0,0,0,0.08)] hover:scale-[1.02] transition-all flex flex-col h-full border border-outline-variant/20">
                            <a href="<c:url value='/tour/detail?id=${tour.tourId}'/>" class="aspect-video relative overflow-hidden block">
                                <img alt="${tour.tourName}" class="w-full h-full object-cover transition-transform duration-500 hover:scale-110" src="${tourImg}"/>
                                <div class="absolute top-2 right-2 bg-white/90 px-2 py-1 rounded text-label-sm flex items-center gap-1 shadow-sm font-semibold text-deep-navy">
                                    <span class="material-symbols-outlined text-status-warning text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                                    4.9
                                </div>
                            </a>
                            <div class="p-5 flex flex-col flex-grow justify-between">
                                <div>
                                    <div class="flex items-center gap-1 text-ocean-blue mb-2">
                                        <span class="material-symbols-outlined text-sm">location_on</span>
                                        <span class="text-label-sm uppercase tracking-wider font-semibold">${tour.destinationName}</span>
                                    </div>
                                    <a href="<c:url value='/tour/detail?id=${tour.tourId}'/>" class="hover:text-ocean-blue transition-colors">
                                        <h3 class="font-headline-md text-headline-md text-deep-navy mb-4 h-14 line-clamp-2 font-bold">${tour.tourName}</h3>
                                    </a>
                                </div>
                                <div class="mt-auto">
                                    <div class="flex justify-between items-center mb-4">
                                        <div>
                                            <span class="text-on-surface-variant line-through text-label-sm block">
                                                <fmt:formatNumber value="${originalPrice}" type="number" groupingUsed="true"/>đ
                                            </span>
                                            <div class="text-action-orange font-bold text-body-lg">
                                                <fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ
                                            </div>
                                        </div>
                                    </div>
                                    <div class="grid grid-cols-2 gap-2">
                                        <a href="<c:url value='/tour/detail?id=${tour.tourId}'/>" class="block w-full text-center border border-ocean-blue text-ocean-blue py-2 rounded-lg font-bold hover:bg-ocean-blue hover:text-white transition-colors text-sm">Chi tiết</a>
                                        <a href="<c:url value='/booking/create?tourId=${tour.tourId}'/>" class="block w-full text-center bg-ocean-blue text-white py-2 rounded-lg font-bold hover:bg-primary transition-all text-sm">Đặt ngay</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Fallback Tour Card 1 -->
                    <div class="bg-white rounded-xl overflow-hidden shadow-[0px_4px_12px_rgba(0,0,0,0.05)] hover:shadow-[0px_8px_24px_rgba(0,0,0,0.08)] hover:scale-[1.02] transition-all flex flex-col">
                        <div class="aspect-video relative overflow-hidden">
                            <img alt="Bali Temple Sunrise" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAOQzYVJixibClQHzJvGjT24Db2XrAzCr23iDSBvS_xVg4UQWWSHs_kAyYEVDyJo23vlpV8CWkuGPt9KaS0KZ5AGxuTMH0bSKQC7wBOgS_MaePifLmVVw4ulu9a1r8-tQF39NUDo6YE90oxYB273V435olSbxdcrozez7YB94XzLq_vv_fItY1S9bSuc7EJPmmNLpoi6oFxNbXy3wGxhpw-hjiyTB-To3iadVB9J_rCDsrexN4cgH2GpgelcQAjsM21a_QVe6tH3Ec"/>
                            <div class="absolute top-2 right-2 bg-white/90 px-2 py-1 rounded text-label-sm flex items-center gap-1 shadow-sm font-semibold">
                                <span class="material-symbols-outlined text-status-warning text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                                4.9
                            </div>
                        </div>
                        <div class="p-5 flex flex-col flex-grow justify-between">
                            <div>
                                <div class="flex items-center gap-1 text-ocean-blue mb-2">
                                    <span class="material-symbols-outlined text-sm">location_on</span>
                                    <span class="text-label-sm uppercase tracking-wider font-semibold">Bali, Indonesia</span>
                                </div>
                                <h3 class="font-headline-md text-headline-md text-deep-navy mb-4 h-14 line-clamp-2 font-bold">Tour Nghỉ dưỡng Bali - Yoga & Spa</h3>
                            </div>
                            <div class="mt-auto">
                                <div class="flex justify-between items-center mb-4">
                                    <div>
                                        <span class="text-on-surface-variant line-through text-label-sm block">18.500.000đ</span>
                                        <div class="text-action-orange font-bold text-body-lg">15.900.000đ</div>
                                    </div>
                                </div>
                                <button class="w-full border-2 border-ocean-blue text-ocean-blue py-2 rounded-lg font-bold hover:bg-ocean-blue hover:text-white transition-colors">Xem chi tiết</button>
                            </div>
                        </div>
                    </div>
                    <!-- Fallback Tour Card 2 -->
                    <div class="bg-white rounded-xl overflow-hidden shadow-[0px_4px_12px_rgba(0,0,0,0.05)] hover:shadow-[0px_8px_24px_rgba(0,0,0,0.08)] hover:scale-[1.02] transition-all flex flex-col">
                        <div class="aspect-video relative overflow-hidden">
                            <img alt="Kyoto Garden Autumn" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDxrqfjzzY_KHOV_LkXIOUJG6MTvpuhr4aG0ONRTRwSu1nU1voaihZn9UHogk8qfm1wi4zAYkZ76a6q-TJ5E9_SVebdxtwwocc_f41-JNKW2kRKbrWqEg5bTnR11jMgZn4UxKlRBCFCkL1DSpLMVnjiG5qJw9BizjoOvTkVkfQQelIRvWcIzsNzAsZJJx-osoeFW3xF4XVhY0GrD14htXgjJGBOHGBAEriIkq1fhYl9O8P74h239PbHvHNHQPlq1VYxG8Uzqqk0NDE"/>
                            <div class="absolute top-2 right-2 bg-white/90 px-2 py-1 rounded text-label-sm flex items-center gap-1 shadow-sm font-semibold">
                                <span class="material-symbols-outlined text-status-warning text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                                4.8
                            </div>
                        </div>
                        <div class="p-5 flex flex-col flex-grow justify-between">
                            <div>
                                <div class="flex items-center gap-1 text-ocean-blue mb-2">
                                    <span class="material-symbols-outlined text-sm">location_on</span>
                                    <span class="text-label-sm uppercase tracking-wider font-semibold">Kyoto, Japan</span>
                                </div>
                                <h3 class="font-headline-md text-headline-md text-deep-navy mb-4 h-14 line-clamp-2 font-bold">Mùa Thu Kyoto: Sắc Màu Di Sản</h3>
                            </div>
                            <div class="mt-auto">
                                <div class="flex justify-between items-center mb-4">
                                    <div>
                                        <span class="text-on-surface-variant line-through text-label-sm block">32.000.000đ</span>
                                        <div class="text-action-orange font-bold text-body-lg">28.500.000đ</div>
                                    </div>
                                </div>
                                <button class="w-full border-2 border-ocean-blue text-ocean-blue py-2 rounded-lg font-bold hover:bg-ocean-blue hover:text-white transition-colors">Xem chi tiết</button>
                            </div>
                        </div>
                    </div>
                    <!-- Fallback Tour Card 3 -->
                    <div class="bg-white rounded-xl overflow-hidden shadow-[0px_4px_12px_rgba(0,0,0,0.05)] hover:shadow-[0px_8px_24px_rgba(0,0,0,0.08)] hover:scale-[1.02] transition-all flex flex-col">
                        <div class="aspect-video relative overflow-hidden">
                            <img alt="London Twilight Tower Bridge" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBxGNVIM6_OsAA0UZhB6FSCoVqGx_9oNe9Yq8-_8OJpsw9clGbb17sS1CG8YZ34YDYcYN1x96JAUGFJoQh8Rf3vNdaDNbyG3sE8NAuAZX16m_MkBiHhaqgbQRK46wVmXjOXiv3O74zLMLBmfj37uwTg84N6mNsEm1qJMWvTRYV07ptjsIW157zJ3xvTOYLA2ykUOwj5q8ONHVIB4QhxIg9OMvnIooJ14JcawEMUkv7syAz8f6Art4px2CF8frca-2LHmf_Xjcub530"/>
                            <div class="absolute top-2 right-2 bg-white/90 px-2 py-1 rounded text-label-sm flex items-center gap-1 shadow-sm font-semibold">
                                <span class="material-symbols-outlined text-status-warning text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                                4.7
                            </div>
                        </div>
                        <div class="p-5 flex flex-col flex-grow justify-between">
                            <div>
                                <div class="flex items-center gap-1 text-ocean-blue mb-2">
                                    <span class="material-symbols-outlined text-sm">location_on</span>
                                    <span class="text-label-sm uppercase tracking-wider font-semibold">London, UK</span>
                                </div>
                                <h3 class="font-headline-md text-headline-md text-deep-navy mb-4 h-14 line-clamp-2 font-bold">London - Paris: Hành Trình Sang Trọng</h3>
                            </div>
                            <div class="mt-auto">
                                <div class="flex justify-between items-center mb-4">
                                    <div>
                                        <span class="text-on-surface-variant line-through text-label-sm block">85.000.000đ</span>
                                        <div class="text-action-orange font-bold text-body-lg">76.500.000đ</div>
                                    </div>
                                </div>
                                <button class="w-full border-2 border-ocean-blue text-ocean-blue py-2 rounded-lg font-bold hover:bg-ocean-blue hover:text-white transition-colors">Xem chi tiết</button>
                            </div>
                        </div>
                    </div>
                    <!-- Fallback Tour Card 4 -->
                    <div class="bg-white rounded-xl overflow-hidden shadow-[0px_4px_12px_rgba(0,0,0,0.05)] hover:shadow-[0px_8px_24px_rgba(0,0,0,0.08)] hover:scale-[1.02] transition-all flex flex-col">
                        <div class="aspect-video relative overflow-hidden">
                            <img alt="Luxury Mediterranean Yacht" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDWFoYdWaKug_ulVxgRRBNApRWMyaR9ZuoQL8zG1Qpv64PnHmzHYwI42jmtPlhnfimRvWzJ9KW3IVRTJXZWaqs5RpeqP5_C47rBxZxIrcb8CSQUo2ym3pgzlf68tix5F0gJ2rSkET0pl2UpBip36X0eYu_-HvlSiFgjdulOZCdOmad_ZfT8x74oB9mtRsl3of74oNONW9uR40XWh1Y2Z8KJMqs-dra9_lvZ93mjIQ2bGwO4Dum5ipZMM5mepNGq1lGBhO-aUgnGWyc"/>
                            <div class="absolute top-2 right-2 bg-white/90 px-2 py-1 rounded text-label-sm flex items-center gap-1 shadow-sm font-semibold">
                                <span class="material-symbols-outlined text-status-warning text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                                5.0
                            </div>
                        </div>
                        <div class="p-5 flex flex-col flex-grow justify-between">
                            <div>
                                <div class="flex items-center gap-1 text-ocean-blue mb-2">
                                    <span class="material-symbols-outlined text-sm">location_on</span>
                                    <span class="text-label-sm uppercase tracking-wider font-semibold">Địa Trung Hải</span>
                                </div>
                                <h3 class="font-headline-md text-headline-md text-deep-navy mb-4 h-14 line-clamp-2 font-bold">Du Thuyền 6 Sao: Khám Phá Hy Lạp</h3>
                            </div>
                            <div class="mt-auto">
                                <div class="flex justify-between items-center mb-4">
                                    <div>
                                        <span class="text-on-surface-variant line-through text-label-sm block">120.000.000đ</span>
                                        <div class="text-action-orange font-bold text-body-lg">108.000.000đ</div>
                                    </div>
                                </div>
                                <button class="w-full border-2 border-ocean-blue text-ocean-blue py-2 rounded-lg font-bold hover:bg-ocean-blue hover:text-white transition-colors">Xem chi tiết</button>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<!-- Exclusive Member Deals -->
<section id="member-benefits" class="py-16 overflow-hidden relative">
    <div class="absolute inset-0 z-0 bg-deep-navy"></div>
    <div class="absolute top-0 right-0 w-1/2 h-full opacity-20 pointer-events-none">
        <svg class="w-full h-full" viewBox="0 0 400 400" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,400 C150,300 250,100 400,0 L400,400 Z" fill="#0194F3"></path>
        </svg>
    </div>
    <div class="max-w-container-max mx-auto px-margin-desktop relative z-10 text-white">
        <div class="flex flex-col md:flex-row gap-12 items-center">
            <div class="w-full md:w-1/2">
                <div class="inline-block bg-action-orange/20 text-action-orange border border-action-orange px-4 py-1.5 rounded-full text-label-sm font-bold mb-4">HỘI VIÊN ELITE</div>
                <h2 class="font-display-lg text-display-lg mb-6 leading-tight">Đặc quyền dành cho Thành viên</h2>
                <p class="font-body-lg text-body-lg opacity-80 mb-10 leading-relaxed">Gia nhập cộng đồng VoyagerElite để nhận những ưu đãi không công khai, nâng hạng phòng miễn phí và dịch vụ chăm sóc khách hàng ưu tiên 24/7.</p>
                <div class="space-y-6">
                    <div class="flex items-start gap-4">
                        <div class="bg-white/10 p-3 rounded-lg"><span class="material-symbols-outlined text-ocean-blue">diamond</span></div>
                        <div>
                            <h4 class="font-bold text-white text-body-lg">Hạng Kim Cương</h4>
                            <p class="text-sm opacity-70 mt-1">Giảm thêm 5% cho tất cả các tour và miễn phí dịch vụ Fast-track tại sân bay.</p>
                        </div>
                    </div>
                    <div class="flex items-start gap-4">
                        <div class="bg-white/10 p-3 rounded-lg"><span class="material-symbols-outlined text-ocean-blue">confirmation_number</span></div>
                        <div>
                            <h4 class="font-bold text-white text-body-lg">Voucher Độc Quyền</h4>
                            <p class="text-sm opacity-70 mt-1">Nhận mã giảm giá lên đến 5.000.000đ vào ngày sinh nhật và kỷ niệm thành viên.</p>
                        </div>
                    </div>
                </div>
                <button class="mt-12 bg-white text-deep-navy px-10 py-4 rounded-lg font-bold hover:bg-ocean-blue hover:text-white transition-all shadow-lg active:scale-95">Đăng ký thành viên</button>
            </div>
            <div class="w-full md:w-1/2 grid grid-cols-2 gap-4 select-none">
                <div class="bg-white/10 backdrop-blur-md p-6 rounded-xl border border-white/10 transform translate-y-8">
                    <div class="text-4xl font-bold text-ocean-blue mb-2">15k+</div>
                    <div class="text-label-md opacity-80">Thành viên tin dùng</div>
                </div>
                <div class="bg-white/10 backdrop-blur-md p-6 rounded-xl border border-white/10">
                    <div class="text-4xl font-bold text-ocean-blue mb-2">200+</div>
                    <div class="text-label-md opacity-80">Khách sạn đối tác</div>
                </div>
                <div class="bg-white/10 backdrop-blur-md p-6 rounded-xl border border-white/10 transform translate-y-8">
                    <div class="text-4xl font-bold text-ocean-blue mb-2">24/7</div>
                    <div class="text-label-md opacity-80">Hỗ trợ cá nhân</div>
                </div>
                <div class="bg-white/10 backdrop-blur-md p-6 rounded-xl border border-white/10">
                    <div class="text-4xl font-bold text-ocean-blue mb-2">0%</div>
                    <div class="text-label-md opacity-80">Phí hủy tour *</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Newsletter Section -->
<section class="py-20 bg-white">
    <div class="max-w-container-max mx-auto px-margin-desktop">
        <div class="bg-surface-gray rounded-2xl p-8 md:p-16 flex flex-col md:flex-row items-center gap-12 border border-outline-variant/30">
            <div class="w-full md:w-1/2">
                <h2 class="font-headline-lg text-headline-lg text-deep-navy mb-4 font-bold">Nhận thông tin ưu đãi mới nhất</h2>
                <p class="text-on-surface-variant font-body-lg">Hãy là người đầu tiên biết về các chương trình Flash Sale và các hành trình mới độc đáo của chúng tôi.</p>
            </div>
            <div class="w-full md:w-1/2">
                <form class="flex flex-col sm:flex-row gap-4" onsubmit="event.preventDefault(); alert('Cảm ơn bạn đã đăng ký!');">
                    <input class="flex-grow px-6 py-4 rounded-lg border border-outline focus:ring-2 focus:ring-ocean-blue focus:border-ocean-blue outline-none transition-all text-body-md" placeholder="Email của bạn" required="" type="email"/>
                    <button class="bg-deep-navy text-white px-8 py-4 rounded-lg font-bold hover:bg-ocean-blue transition-all active:scale-95" type="submit">Đăng ký ngay</button>
                </form>
                <p class="text-xs text-on-surface-variant mt-4 opacity-60">Bằng cách đăng ký, bạn đồng ý với Chính sách bảo mật của VoyagerElite.</p>
            </div>
        </div>
    </div>
</section>

<script>
    // Simple Countdown Timer
    function updateCountdown() {
        const h = document.getElementById('hours');
        const m = document.getElementById('minutes');
        const s = document.getElementById('seconds');
        
        if (!h || !m || !s) return;
        
        let hours = parseInt(h.innerText);
        let minutes = parseInt(m.innerText);
        let seconds = parseInt(s.innerText);
        
        if (seconds > 0) {
            seconds--;
        } else {
            seconds = 59;
            if (minutes > 0) {
                minutes--;
            } else {
                minutes = 59;
                if (hours > 0) {
                    hours--;
                } else {
                    // reset to 8 hours if reaches 0
                    hours = 8;
                    minutes = 0;
                    seconds = 0;
                }
            }
        }
        
        h.innerText = hours.toString().padStart(2, '0');
        m.innerText = minutes.toString().padStart(2, '0');
        s.innerText = seconds.toString().padStart(2, '0');
    }
    
    setInterval(updateCountdown, 1000);
</script>

<%@ include file="../layout/footer.jsp" %>
