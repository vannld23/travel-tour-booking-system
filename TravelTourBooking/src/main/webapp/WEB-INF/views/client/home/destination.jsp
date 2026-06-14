<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Điểm đến | VoyagerElite Luxury Travel" />
<%@ include file="../layout/header.jsp" %>

<!-- Hero Section -->
<header class="relative h-[480px] flex items-center overflow-hidden">
    <div class="absolute inset-0 z-0">
        <img class="w-full h-full object-cover" alt="Breathtaking aerial view of Halong Bay" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD3IpHqnNP8fgeFjbi3nQv2drB8tPlRahnHXjYmw8g3Mma3dZPmSCKi0a35HCLiE0xgcMd795Fsksb9VIg1rvGA0J82uBvlidarpZrgtU9D0zE3RMNec7Uz5Cqqi9c8aiW631NdmYiM869AWjyw_qdTPFtn316kT6IMxb1-lrC4CiFj6Vr8aK6xKwYCsJiPVjU22xGH1k9JP0OBaZ19Vvr6JUUclv4F3fo8PCq8ePX-nCmuBGXrDfgACpzFart74qr7wR7yUTf4DHQ"/>
        <div class="absolute inset-0 bg-gradient-to-r from-deep-navy/85 via-deep-navy/60 to-transparent"></div>
    </div>
    <div class="relative z-10 px-margin-desktop max-w-container-max mx-auto w-full text-white">
        <h1 class="font-display-lg text-display-lg max-w-2xl mb-4 leading-tight">Khám phá các Điểm đến Tuyệt vời</h1>
        <p class="font-body-lg text-body-lg max-w-xl opacity-90 leading-relaxed">
            Hành trình tìm về những vùng đất di sản, nơi vẻ đẹp tự nhiên hòa quyện cùng sự tinh tế của dịch vụ nghỉ dưỡng đẳng cấp VoyagerElite.
        </p>
    </div>
</header>

<!-- Filter Section -->
<section class="bg-white shadow-sm sticky top-20 z-40 border-b border-outline-variant/30">
    <div class="px-margin-desktop max-w-container-max mx-auto flex items-center justify-between h-16 overflow-x-auto">
        <div class="flex space-x-12 whitespace-nowrap">
            <button class="region-tab active font-label-md text-label-md py-5 transition-all cursor-pointer" onclick="filterRegion('all')">Tất cả</button>
            <button class="region-tab text-on-surface-variant font-label-md text-label-md py-5 transition-all hover:text-ocean-blue cursor-pointer" onclick="filterRegion('north')">Miền Bắc</button>
            <button class="region-tab text-on-surface-variant font-label-md text-label-md py-5 transition-all hover:text-ocean-blue cursor-pointer" onclick="filterRegion('central')">Miền Trung</button>
            <button class="region-tab text-on-surface-variant font-label-md text-label-md py-5 transition-all hover:text-ocean-blue cursor-pointer" onclick="filterRegion('south')">Miền Nam</button>
        </div>
        <div class="hidden md:flex items-center text-on-surface-variant font-label-sm text-label-sm select-none">
            <span class="material-symbols-outlined mr-2 text-[18px]">sort</span>
            Sắp xếp theo: Phổ biến nhất
        </div>
    </div>
</section>

<!-- Destination Grid -->
<main class="px-margin-desktop py-16 max-w-container-max mx-auto">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-gutter" id="destination-grid">
        <c:forEach var="dest" items="${destinations}">
            <!-- Fallback image setup -->
            <c:set var="destImg" value="${dest.imageUrl}"/>
            <c:if test="${empty destImg || !destImg.startsWith('http')}">
                <c:choose>
                    <c:when test="${dest.destinationName.toLowerCase().contains('dalat') || dest.destinationName.toLowerCase().contains('đà lạt')}">
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1589308078059-be1415eab4c3?w=600&q=80"/>
                    </c:when>
                    <c:when test="${dest.destinationName.toLowerCase().contains('nha trang')}">
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1540206395-68808572332f?w=600&q=80"/>
                    </c:when>
                    <c:when test="${dest.destinationName.toLowerCase().contains('phu quoc') || dest.destinationName.toLowerCase().contains('phú quốc')}">
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600&q=80"/>
                    </c:when>
                    <c:when test="${dest.destinationName.toLowerCase().contains('sapa') || dest.destinationName.toLowerCase().contains('sa pa')}">
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1508873696983-2df519f0397e?w=600&q=80"/>
                    </c:when>
                    <c:when test="${dest.destinationName.toLowerCase().contains('ha long') || dest.destinationName.toLowerCase().contains('hạ long') || dest.destinationName.toLowerCase().contains('halong')}">
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1528127269322-539801943592?w=600&q=80"/>
                    </c:when>
                    <c:when test="${dest.destinationName.toLowerCase().contains('danang') || dest.destinationName.toLowerCase().contains('đà nẵng')}">
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80"/>
                    </c:when>
                    <c:when test="${dest.destinationName.toLowerCase().contains('hoi an') || dest.destinationName.toLowerCase().contains('hội an')}">
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80"/>
                    </c:when>
                    <c:when test="${dest.destinationName.toLowerCase().contains('cat ba') || dest.destinationName.toLowerCase().contains('cát bà')}">
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600&q=80"/>
                    </c:when>
                    <c:when test="${dest.destinationName.toLowerCase().contains('hue') || dest.destinationName.toLowerCase().contains('huế')}">
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1590001155093-a3c66ab0c3ff?w=600&q=80"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="destImg" value="https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=600&q=80"/>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <article class="bg-white rounded-xl overflow-hidden shadow-[0px_4px_12px_rgba(0,0,0,0.05)] tour-card transition-all duration-300 flex flex-col h-full" data-region="${dest.regionCode}">
                <div class="aspect-video relative overflow-hidden">
                    <img class="w-full h-full object-cover filter brightness-[0.95] hover:scale-105 transition-all duration-500" src="${destImg}" alt="${dest.destinationName}"/>
                    <div class="absolute top-4 left-4 bg-white/95 backdrop-blur-sm px-3 py-1 rounded-full text-label-sm text-deep-navy font-bold shadow-sm">${dest.regionLabel}</div>
                </div>
                <div class="p-6 flex flex-col flex-grow">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="font-headline-md text-headline-md text-deep-navy font-semibold">${dest.destinationName}</h3>
                        <span class="text-action-orange font-bold text-headline-md">${dest.tourCount} Tours</span>
                    </div>
                    <div class="flex items-center text-outline text-label-sm mb-4">
                        <span class="material-symbols-outlined text-[16px] mr-1">location_on</span>
                        ${dest.city}, ${dest.country}
                    </div>
                    <p class="font-body-md text-body-md text-on-surface-variant mb-6 line-clamp-3 italic">
                        "${dest.description}"
                    </p>
                    <div class="mt-auto pt-4 border-t border-surface-gray flex justify-between items-center">
                        <a class="text-ocean-blue font-label-md text-label-md flex items-center hover:underline group font-semibold" href="<c:url value='/home?destinationId=${dest.destinationId}'/>">
                            Xem chi tiết
                            <span class="material-symbols-outlined ml-1 transition-transform group-hover:translate-x-1">arrow_forward</span>
                        </a>
                        <button class="w-10 h-10 rounded-full bg-surface-container flex items-center justify-center text-on-surface-variant hover:bg-ocean-blue hover:text-white transition-colors">
                            <span class="material-symbols-outlined">favorite</span>
                        </button>
                    </div>
                </div>
            </article>
        </c:forEach>
        
        <c:if test="${empty destinations}">
            <div class="col-span-full py-24 text-center text-on-surface-variant">
                <span class="material-symbols-outlined text-5xl mb-4 text-outline select-none">travel_explore</span>
                <p class="text-lg font-semibold">Hiện chưa có điểm đến nào phù hợp.</p>
            </div>
        </c:if>
    </div>

    <!-- Pagination -->
    <div class="mt-16 flex justify-center">
        <nav class="flex space-x-2">
            <button class="w-10 h-10 rounded-lg flex items-center justify-center border border-outline-variant hover:bg-surface-container transition-colors">
                <span class="material-symbols-outlined">chevron_left</span>
            </button>
            <button class="w-10 h-10 rounded-lg flex items-center justify-center bg-ocean-blue text-white font-bold">1</button>
            <button class="w-10 h-10 rounded-lg flex items-center justify-center border border-outline-variant hover:bg-surface-container transition-colors">2</button>
            <button class="w-10 h-10 rounded-lg flex items-center justify-center border border-outline-variant hover:bg-surface-container transition-colors">3</button>
            <button class="w-10 h-10 rounded-lg flex items-center justify-center border border-outline-variant hover:bg-surface-container transition-colors">
                <span class="material-symbols-outlined">chevron_right</span>
            </button>
        </nav>
    </div>
</main>

<!-- Call to Action -->
<section class="bg-deep-navy text-white py-20 px-margin-desktop overflow-hidden relative">
    <div class="absolute inset-0 bg-[radial-gradient(circle_at_bottom_left,_var(--tw-gradient-stops))] from-ocean-blue/10 via-transparent to-transparent"></div>
    <div class="max-w-container-max mx-auto grid grid-cols-1 lg:grid-cols-2 gap-gutter items-center relative z-10">
        <div>
            <h2 class="font-display-lg text-display-lg mb-6 leading-tight">Bạn chưa chọn được điểm đến?</h2>
            <p class="font-body-lg text-body-lg opacity-80 mb-8 max-w-lg">
                Hãy để các chuyên gia tư vấn của VoyagerElite thiết kế một hành trình riêng biệt, cá nhân hóa hoàn toàn cho sở thích và đẳng cấp của bạn.
            </p>
            <div class="flex flex-col sm:flex-row gap-4">
                <button class="bg-action-orange text-white px-8 py-4 rounded-lg font-bold hover:bg-secondary transition-all flex items-center justify-center gap-2 shadow-lg hover:shadow-xl active:scale-95">
                    Nhận tư vấn ngay
                    <span class="material-symbols-outlined">headset_mic</span>
                </button>
                <button class="border border-white/30 hover:bg-white/10 px-8 py-4 rounded-lg font-bold transition-all flex items-center justify-center gap-2 active:scale-95">
                    Tải Brochure 2024
                    <span class="material-symbols-outlined">download</span>
                </button>
            </div>
        </div>
        <div class="relative hidden lg:block h-96">
            <div class="absolute inset-0 bg-ocean-blue/10 rounded-3xl -rotate-3"></div>
            <img class="absolute inset-0 w-full h-full object-cover rounded-3xl shadow-2xl rotate-2" alt="Travel Consultant working in a modern office" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCFA9MOArvHEvOkZXp-3_6ORkNh4Gfy82YvJ4kPLcZ1Er34sjIDddayw2kMdOstT6gH8SrU9DrjFs3aw8EDQFOn8iVBtQGAF71LgLKgctMFwJekmoXSA5dv_QoKhOOJpug9VQRegKoUzVhuvBUm2omlJREon7NjC4ptxhKd5lT991J2grP2c57H-2mQbkqZsgOJdwb9FFVYfQWadhj5EIbN4DtaytEZs8p7aijPJwk21Y_N2Wb8bbrEmv0GfH_HjWUieqO1H122jVc"/>
        </div>
    </div>
</section>

<script>
    function filterRegion(region) {
        const cards = document.querySelectorAll('#destination-grid article');
        const tabs = document.querySelectorAll('.region-tab');
        
        // Update tabs active styles
        tabs.forEach(tab => {
            tab.classList.remove('active', 'text-ocean-blue', 'border-b-2', 'border-ocean-blue', 'font-bold');
            tab.classList.add('text-on-surface-variant');
        });

        const regionMap = {
            'all': 'tất cả',
            'north': 'miền bắc',
            'central': 'miền trung',
            'south': 'miền nam'
        };

        const activeTab = Array.from(tabs).find(t => t.innerText.toLowerCase().includes(regionMap[region]));
        if (activeTab) {
            activeTab.classList.add('active', 'text-ocean-blue', 'border-b-2', 'border-ocean-blue', 'font-bold');
            activeTab.classList.remove('text-on-surface-variant');
        }

        // Filter cards with soft animations
        cards.forEach(card => {
            card.style.transition = 'all 0.3s ease';
            card.style.opacity = '0';
            card.style.transform = 'scale(0.95)';
            
            setTimeout(() => {
                if (region === 'all' || card.dataset.region === region) {
                    card.style.display = 'flex';
                    setTimeout(() => {
                        card.style.opacity = '1';
                        card.style.transform = 'scale(1)';
                    }, 50);
                } else {
                    card.style.display = 'none';
                }
            }, 300);
        });
    }
</script>

<%@ include file="../layout/footer.jsp" %>
