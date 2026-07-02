<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="VoyagerElite - Khám phá thế giới theo cách của bạn" />
<%@ include file="../layout/header.jsp" %>

    <!-- Hero Section -->
    <section class="relative h-[600px] flex items-center justify-center overflow-hidden">
        <div class="absolute inset-0 z-0">
            <img class="w-full h-full object-cover" alt="Ha Long Bay" src="https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1600&q=80"/>
            <div class="absolute inset-0 bg-black/30"></div>
        </div>
        <div class="relative z-10 w-full max-w-container-max px-margin-desktop text-center">
            <h1 class="font-display-lg text-display-lg text-white mb-8 drop-shadow-lg">Khám phá thế giới theo cách của bạn</h1>
            
            <!-- Search Bar Overlay -->
            <form action="<c:url value='/home'/>" method="GET" class="glass-effect p-4 md:p-6 rounded-xl shadow-2xl max-w-4xl mx-auto grid grid-cols-1 md:grid-cols-4 gap-4 items-end">
                <div class="text-left">
                    <label class="block text-label-sm text-on-surface-variant mb-1 ml-1 font-semibold">Điểm đến</label>
                    <div class="flex items-center bg-white border border-outline-variant rounded-lg px-3 py-2">
                        <span class="material-symbols-outlined text-ocean-blue mr-2">location_on</span>
                        <input name="keyword" value="${keyword}" class="w-full border-none p-0 focus:ring-0 text-body-md" placeholder="Bạn muốn đi đâu?" type="text"/>
                    </div>
                </div>
                <div class="text-left">
                    <label class="block text-label-sm text-on-surface-variant mb-1 ml-1 font-semibold">Ngày đi</label>
                    <div class="flex items-center bg-white border border-outline-variant rounded-lg px-3 py-2">
                        <span class="material-symbols-outlined text-ocean-blue mr-2">calendar_today</span>
                        <input class="w-full border-none p-0 focus:ring-0 text-body-md" type="date"/>
                    </div>
                </div>
                <div class="text-left">
                    <label class="block text-label-sm text-on-surface-variant mb-1 ml-1 font-semibold">Khoảng giá</label>
                    <div class="flex items-center bg-white border border-outline-variant rounded-lg px-3 py-2">
                        <span class="material-symbols-outlined text-ocean-blue mr-2">payments</span>
                        <select name="priceRange" class="w-full border-none p-0 focus:ring-0 text-body-md bg-transparent">
                            <option value="" ${empty priceRange ? 'selected' : ''}>Tất cả</option>
                            <option value="under_5m" ${priceRange == 'under_5m' ? 'selected' : ''}>Dưới 5 triệu</option>
                            <option value="5_10m" ${priceRange == '5_10m' ? 'selected' : ''}>5 - 10 triệu</option>
                            <option value="above_10m" ${priceRange == 'above_10m' ? 'selected' : ''}>Trên 10 triệu</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="bg-action-orange text-white h-[42px] rounded-lg font-label-md hover:bg-secondary transition-all flex items-center justify-center gap-2">
                    <span class="material-symbols-outlined">search</span>
                    Tìm ngay
                </button>
            </form>
        </div>
    </section>

    <!-- Promoted Tours -->
    <section class="py-16 max-w-container-max mx-auto px-margin-desktop">
        <div class="flex justify-between items-end mb-10">
            <div>
                <h2 class="font-headline-lg text-headline-lg text-deep-navy font-bold">
                    <c:choose>
                        <c:when test="${not empty keyword}">Kết quả tìm kiếm cho "${keyword}"</c:when>
                        <c:when test="${not empty destinationId}">
                            <c:set var="foundDest" value="" />
                            <c:forEach var="d" items="${destinations}">
                                <c:if test="${d.destinationId == destinationId}">
                                    <c:set var="foundDest" value="${d.destinationName}" />
                                </c:if>
                            </c:forEach>
                            Tour du lịch tại ${foundDest}
                        </c:when>
                        <c:otherwise>Tour nổi bật nhất</c:otherwise>
                    </c:choose>
                </h2>
                <div class="h-1 w-20 bg-action-orange mt-2"></div>
            </div>
            <c:if test="${not empty keyword || not empty destinationId}">
                <a class="text-ocean-blue font-label-md flex items-center hover:underline" href="<c:url value='/home'/>">
                    Xem tất cả <span class="material-symbols-outlined text-sm ml-1">arrow_forward</span>
                </a>
            </c:if>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-gutter">
            <c:choose>
                <c:when test="${not empty tours}">
                    <c:forEach var="tour" items="${tours}">
                        <c:set var="tourImg" value="${tour.imageUrl}"/>
                        <c:if test="${empty tourImg || (!tourImg.startsWith('http') && !tourImg.contains('/resources/'))}">
                            <c:choose>
                                <c:when test="${tour.tourName.toLowerCase().contains('dalat') || tour.tourName.toLowerCase().contains('da lat') || tour.tourName.toLowerCase().contains('đà lạt')}">
                                    <c:set var="tourImg" value="${pageContext.request.contextPath}/resource/images/da_lat.jpg"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('nha trang')}">
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1540206395-68808572332f?w=800&q=80"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('phu quoc') || tour.tourName.toLowerCase().contains('phú quốc')}">
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('sapa') || tour.tourName.toLowerCase().contains('sa pa')}">
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1508873696983-2df519f0397e?w=800&q=80"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('ha long') || tour.tourName.toLowerCase().contains('hạ long') || tour.tourName.toLowerCase().contains('halong')}">
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('danang') || tour.tourName.toLowerCase().contains('da nang') || tour.tourName.toLowerCase().contains('đà nẵng')}">
                                    <c:set var="tourImg" value="${pageContext.request.contextPath}/resource/images/da_nang.jpg"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('hue') || tour.tourName.toLowerCase().contains('huế')}">
                                    <c:set var="tourImg" value="${pageContext.request.contextPath}/resource/images/Hue.jpg"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('hoi an') || tour.tourName.toLowerCase().contains('hội an')}">
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&q=80"/>
                                </c:when>
                                <c:when test="${tour.tourName.toLowerCase().contains('cat ba') || tour.tourName.toLowerCase().contains('cát bà')}">
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="tourImg" value="https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800&q=80"/>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <div class="tour-card bg-white rounded-xl overflow-hidden shadow-[0px_4px_12px_rgba(0,0,0,0.05)] border border-outline-variant/30 flex flex-col justify-between hover:shadow-[0px_8px_24px_rgba(0,0,0,0.08)] transition-all">
                            <div>
                                <a href="<c:url value='/tour/detail?id=${tour.tourId}'/>" class="block group/img relative aspect-[16/9] overflow-hidden">
                                    <img class="w-full h-full object-cover transition-transform duration-500 hover:scale-110" src="${tourImg}" alt="${tour.tourName}"/>
                                    <div class="absolute top-3 left-3 bg-white/90 backdrop-blur-sm px-2 py-1 rounded text-label-sm font-bold text-ocean-blue">
                                        HOT TOUR
                                    </div>
                                </a>
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-2">
                                        <a href="<c:url value='/tour/detail?id=${tour.tourId}'/>" class="hover:text-ocean-blue transition-colors">
                                            <h3 class="font-headline-md text-headline-md text-deep-navy font-semibold line-clamp-1">${tour.tourName}</h3>
                                        </a>
                                        <div class="flex items-center text-status-warning">
                                            <span class="material-symbols-outlined fill" style="font-variation-settings: 'FILL' 1;">star</span>
                                            <span class="ml-1 text-label-md">5.0</span>
                                        </div>
                                    </div>
                                    <div class="flex items-center text-on-surface-variant text-body-md mb-4">
                                        <span class="material-symbols-outlined text-sm mr-1">schedule</span> ${tour.durationDays} Ngày
                                        <span class="mx-2 text-outline-variant">|</span>
                                        <span class="material-symbols-outlined text-sm mr-1">location_on</span> ${tour.destinationName}
                                    </div>
                                    <p class="text-sm text-on-surface-variant line-clamp-2">${tour.description}</p>
                                </div>
                            </div>
                            
                            <div class="p-6 pt-0">
                                <div class="flex justify-between items-center mt-6 pt-4 border-t border-outline-variant/30">
                                    <div class="flex flex-col">
                                        <span class="text-on-surface-variant text-[11px] font-semibold">Giá từ</span>
                                        <span class="text-action-orange font-bold text-lg">
                                            <fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>₫
                                        </span>
                                    </div>
                                    <a href="<c:url value='/booking/create?tourId=${tour.tourId}'/>" class="bg-ocean-blue text-white px-5 py-2 rounded-lg text-sm font-semibold hover:bg-primary transition-all">Đặt ngay</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-span-full text-center py-16 bg-white rounded-2xl border border-outline-variant/30 px-6">
                        <span class="material-symbols-outlined text-6xl text-on-surface-variant/40 mb-4" style="font-variation-settings: 'wght' 300;">search_off</span>
                        <h3 class="font-headline-md text-headline-md text-deep-navy font-bold mb-2">Không tìm thấy tour phù hợp</h3>
                        <p class="text-on-surface-variant font-body-md max-w-md mx-auto mb-6">VoyagerElite hiện chưa có chương trình tour tương ứng với tiêu chí tìm kiếm này. Quý khách vui lòng thử lại bằng từ khóa hoặc điểm đến khác.</p>
                        <a href="<c:url value='/home'/>" class="inline-flex items-center bg-ocean-blue text-white px-6 py-3 rounded-xl font-label-md hover:bg-primary transition-all shadow-md active:scale-95">
                            <span class="material-symbols-outlined mr-2 text-base">refresh</span>
                            Xem tất cả các tour
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Popular Destinations -->
    <section class="py-16 bg-surface-container-low">
        <div class="max-w-container-max mx-auto px-margin-desktop">
            <div class="text-center mb-12">
                <h2 class="font-headline-lg text-headline-lg text-deep-navy mb-2 font-bold">Điểm đến yêu thích</h2>
                <p class="text-on-surface-variant text-body-lg">Khám phá những địa điểm được lựa chọn nhiều nhất bởi khách hàng của chúng tôi</p>
            </div>
            
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
                <c:forEach var="dest" items="${destinations}" varStatus="status">
                    <c:if test="${status.index < 4}">
                        <c:set var="destImg" value="${dest.imageUrl}"/>
                        <c:if test="${empty destImg || !destImg.startsWith('http')}">
                            <c:choose>
                                <c:when test="${dest.destinationName.toLowerCase().contains('dalat') || dest.destinationName.toLowerCase().contains('da lat') || dest.destinationName.toLowerCase().contains('đà lạt')}">
                                    <c:set var="destImg" value="${pageContext.request.contextPath}/resource/images/da_lat.jpg"/>
                                </c:when>
                                <c:when test="${dest.destinationName.toLowerCase().contains('nha trang')}">
                                    <c:set var="destImg" value="https://images.unsplash.com/photo-1540206395-68808572332f?w=400&q=80"/>
                                </c:when>
                                <c:when test="${dest.destinationName.toLowerCase().contains('phu quoc') || dest.destinationName.toLowerCase().contains('phú quốc')}">
                                    <c:set var="destImg" value="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400&q=80"/>
                                </c:when>
                                <c:when test="${dest.destinationName.toLowerCase().contains('sapa') || dest.destinationName.toLowerCase().contains('sa pa')}">
                                    <c:set var="destImg" value="https://images.unsplash.com/photo-1508873696983-2df519f0397e?w=400&q=80"/>
                                </c:when>
                                <c:when test="${dest.destinationName.toLowerCase().contains('ha long') || dest.destinationName.toLowerCase().contains('hạ long') || dest.destinationName.toLowerCase().contains('halong')}">
                                    <c:set var="destImg" value="https://images.unsplash.com/photo-1528127269322-539801943592?w=400&q=80"/>
                                </c:when>
                                <c:when test="${dest.destinationName.toLowerCase().contains('danang') || dest.destinationName.toLowerCase().contains('da nang') || dest.destinationName.toLowerCase().contains('đà nẵng')}">
                                    <c:set var="destImg" value="${pageContext.request.contextPath}/resource/images/da_nang.jpg"/>
                                </c:when>
                                <c:when test="${dest.destinationName.toLowerCase().contains('hue') || dest.destinationName.toLowerCase().contains('huế')}">
                                    <c:set var="destImg" value="${pageContext.request.contextPath}/resource/images/Hue.jpg"/>
                                </c:when>
                                <c:when test="${dest.destinationName.toLowerCase().contains('hoi an') || dest.destinationName.toLowerCase().contains('hội an')}">
                                    <c:set var="destImg" value="https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80"/>
                                </c:when>
                                <c:when test="${dest.destinationName.toLowerCase().contains('cat ba') || dest.destinationName.toLowerCase().contains('cát bà')}">
                                    <c:set var="destImg" value="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400&q=80"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="destImg" value="https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400&q=80"/>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <a href="<c:url value='/home?destinationId=${dest.destinationId}'/>" class="flex flex-col items-center group cursor-pointer">
                            <div class="w-32 h-32 md:w-40 md:h-40 rounded-full overflow-hidden mb-4 border-4 border-white shadow-lg group-hover:border-ocean-blue transition-all duration-300">
                                <img class="w-full h-full object-cover" src="${destImg}" alt="${dest.destinationName}"/>
                            </div>
                            <span class="font-semibold text-deep-navy group-hover:text-ocean-blue transition-colors text-center text-base">${dest.destinationName}</span>
                            <span class="text-xs text-on-surface-variant">${dest.city}, ${dest.country}</span>
                            <span class="text-xs text-ocean-blue mt-1 font-semibold">${dest.bookingCount} lượt đặt</span>
                        </a>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- Why Choose Us -->
    <section class="py-20 max-w-container-max mx-auto px-margin-desktop">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-12 text-center">
            <div class="flex flex-col items-center">
                <div class="w-16 h-16 bg-ocean-blue/10 rounded-2xl flex items-center justify-center mb-6">
                    <span class="material-symbols-outlined text-ocean-blue text-4xl" style="font-variation-settings: 'wght' 600;">sell</span>
                </div>
                <h4 class="font-headline-md text-headline-md text-deep-navy mb-3 font-semibold">Giá tốt nhất</h4>
                <p class="text-on-surface-variant text-body-md max-w-xs">Cam kết mức giá cạnh tranh nhất thị trường cùng nhiều ưu đãi hấp dẫn hàng ngày.</p>
            </div>
            <div class="flex flex-col items-center">
                <div class="w-16 h-16 bg-ocean-blue/10 rounded-2xl flex items-center justify-center mb-6">
                    <span class="material-symbols-outlined text-ocean-blue text-4xl" style="font-variation-settings: 'wght' 600;">support_agent</span>
                </div>
                <h4 class="font-headline-md text-headline-md text-deep-navy mb-3 font-semibold">Hỗ trợ 24/7</h4>
                <p class="text-on-surface-variant text-body-md max-w-xs">Đội ngũ chuyên viên tư vấn tận tâm luôn sẵn sàng hỗ trợ bạn bất cứ lúc nào, bất cứ nơi đâu.</p>
            </div>
            <div class="flex flex-col items-center">
                <div class="w-16 h-16 bg-ocean-blue/10 rounded-2xl flex items-center justify-center mb-6">
                    <span class="material-symbols-outlined text-ocean-blue text-4xl" style="font-variation-settings: 'wght' 600;">verified_user</span>
                </div>
                <h4 class="font-headline-md text-headline-md text-deep-navy mb-3 font-semibold">Bảo mật thanh toán</h4>
                <p class="text-on-surface-variant text-body-md max-w-xs">Hệ thống thanh toán an toàn, bảo mật tuyệt đối thông tin khách hàng và giao dịch.</p>
            </div>
        </div>
    </section>

    <!-- Testimonials -->
    <section class="py-20 bg-deep-navy text-white overflow-hidden relative">
        <div class="absolute top-0 left-0 w-full h-full opacity-10 pointer-events-none">
            <div class="absolute top-[-10%] left-[-5%] w-64 h-64 rounded-full bg-ocean-blue blur-3xl"></div>
            <div class="absolute bottom-[-10%] right-[-5%] w-96 h-96 rounded-full bg-action-orange blur-3xl"></div>
        </div>
        <div class="max-w-container-max mx-auto px-margin-desktop relative z-10">
            <h2 class="font-headline-lg text-headline-lg text-center mb-16 font-bold">Khách hàng nói về chúng tôi</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-gutter">
                <!-- Review 1 -->
                <div class="bg-white/10 backdrop-blur-md p-8 rounded-2xl border border-white/20">
                    <div class="flex items-center gap-4 mb-6">
                        <img class="w-12 h-12 rounded-full border-2 border-ocean-blue" alt="Lan Anh" src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100"/>
                        <div>
                            <p class="font-label-md text-white">Lan Anh</p>
                            <p class="text-label-sm text-ocean-blue">Hà Nội</p>
                        </div>
                    </div>
                    <div class="flex mb-4 text-status-warning">
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                    </div>
                    <p class="text-body-md italic leading-relaxed">"Chuyến đi Sapa vừa rồi thực sự tuyệt vời. Dịch vụ của VoyagerElite rất chuyên nghiệp, hướng dẫn viên nhiệt tình và khách sạn vô cùng thoải mái."</p>
                </div>
                <!-- Review 2 -->
                <div class="bg-white/10 backdrop-blur-md p-8 rounded-2xl border border-white/20">
                    <div class="flex items-center gap-4 mb-6">
                        <img class="w-12 h-12 rounded-full border-2 border-ocean-blue" alt="Minh Quang" src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100"/>
                        <div>
                            <p class="font-label-md text-white">Minh Quang</p>
                            <p class="text-label-sm text-ocean-blue">TP. Hồ Chí Minh</p>
                        </div>
                    </div>
                    <div class="flex mb-4 text-status-warning">
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                    </div>
                    <p class="text-body-md italic leading-relaxed">"Tôi đã đặt tour Phú Quốc cho cả gia đình. Mọi thứ đều được chuẩn bị chu đáo, từ xe đưa đón đến các hoạt động vui chơi. Rất đáng tiền!"</p>
                </div>
                <!-- Review 3 -->
                <div class="bg-white/10 backdrop-blur-md p-8 rounded-2xl border border-white/20">
                    <div class="flex items-center gap-4 mb-6">
                        <img class="w-12 h-12 rounded-full border-2 border-ocean-blue" alt="Thùy Dương" src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100"/>
                        <div>
                            <p class="font-label-md text-white">Thùy Dương</p>
                            <p class="text-label-sm text-ocean-blue">Đà Nẵng</p>
                        </div>
                    </div>
                    <div class="flex mb-4 text-status-warning">
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                        <span class="material-symbols-outlined fill text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                    </div>
                    <p class="text-body-md italic leading-relaxed">"Giá cả minh bạch và hỗ trợ đặt chỗ cực kỳ nhanh chóng. VoyagerElite là lựa chọn hàng đầu của tôi cho mỗi kỳ nghỉ."</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="py-16 max-w-container-max mx-auto px-margin-desktop">
        <div class="bg-ocean-blue rounded-3xl p-10 md:p-16 flex flex-col md:flex-row items-center justify-between shadow-2xl relative overflow-hidden">
            <div class="absolute right-0 top-0 w-1/3 h-full bg-white/10 skew-x-[-20deg] translate-x-1/2"></div>
            <div class="relative z-10 md:max-w-xl text-center md:text-left mb-10 md:mb-0">
                <h2 class="font-headline-lg text-headline-lg text-white mb-4 font-bold">Nhận ưu đãi độc quyền ngay!</h2>
                <p class="text-white/80 text-body-lg">Đăng ký bản tin của chúng tôi để không bỏ lỡ những chuyến đi mơ ước với mức giá tốt nhất.</p>
            </div>
            <div class="relative z-10 w-full md:w-auto flex flex-col sm:flex-row gap-4">
                <input class="px-6 py-4 rounded-xl border-none focus:ring-2 focus:ring-action-orange w-full md:w-80 shadow-lg text-on-surface" placeholder="Email của bạn" type="email"/>
                <button class="bg-action-orange text-white px-8 py-4 rounded-xl font-label-md hover:bg-secondary transition-all shadow-lg active:scale-95 whitespace-nowrap">
                    Đăng ký ngay
                </button>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <%@ include file="../layout/footer.jsp" %>
