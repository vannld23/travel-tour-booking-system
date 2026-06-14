<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Trung tâm Hỗ trợ | VoyagerElite" />
<%@ include file="layout/header.jsp" %>

<style>
    .card-shadow {
        box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.05);
    }
    .card-shadow-hover {
        transition: all 0.3s ease;
    }
    .card-shadow-hover:hover {
        box-shadow: 0px 8px 24px rgba(0, 0, 0, 0.08);
        transform: translateY(-2px);
    }
    .accordion-content {
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease-out;
    }
    .accordion-active .accordion-content {
        max-height: 500px;
    }
    .accordion-active .accordion-icon {
        transform: rotate(180deg);
    }
</style>

<!-- Hero Section -->
<section class="relative h-[480px] flex items-center justify-center overflow-hidden">
    <div class="absolute inset-0 z-0">
        <img alt="Luxury tropical resort hero background" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida/AP1WRLvAGIjT9Kx8lX5Q_dZcZLaLLBnYM5oEPdA17rmml_PTwK5TKDr5Z3l6Ta3KBFyoCLzon7LE3qIMrEJlNOx-5tNE-R_haNtndQOps8bX1hP7LlXh31SuXNrHxSxOWLzd_aBXD9iUo8UdoAk9aYXyw1bQjdq7wzNC6F4HgYsy3YV8_ktdIG8wuxRCMFF3gMPPXx4F6OwEndTSY8uFk2IQhinl0iurfP4Jnqm2qqjflK9tx2oQ2NKpZAzz8Vs"/>
        <div class="absolute inset-0 bg-deep-navy/40 backdrop-blur-[2px]"></div>
    </div>
    <div class="relative z-10 w-full max-w-4xl px-margin-mobile text-center text-white">
        <h1 class="font-display-lg text-display-lg mb-4">Chúng tôi có thể giúp gì cho bạn?</h1>
        <p class="font-body-lg text-body-lg opacity-90 mb-10 max-w-2xl mx-auto">
            Tìm kiếm câu trả lời cho các câu hỏi phổ biến hoặc liên hệ với đội ngũ hỗ trợ của chúng tôi.
        </p>
        <div class="relative max-w-2xl mx-auto">
            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant">search</span>
            <input id="faq-search" class="w-full pl-12 pr-4 py-5 rounded-xl border-none focus:ring-4 focus:ring-ocean-blue/30 text-on-surface text-body-lg shadow-xl" placeholder="Tìm kiếm hướng dẫn, chính sách..." type="text" oninput="filterFAQs()"/>
        </div>
    </div>
</section>

<!-- Support Categories -->
<section class="py-16 px-margin-desktop max-w-container-max mx-auto">
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-gutter">
        <!-- Booking & Payment -->
        <div class="bg-surface-container-lowest p-8 rounded-xl card-shadow card-shadow-hover text-center cursor-pointer border border-outline-variant/30 group">
            <div class="w-16 h-16 bg-ocean-blue/10 rounded-full flex items-center justify-center mx-auto mb-6 group-hover:bg-ocean-blue transition-colors">
                <span class="material-symbols-outlined text-ocean-blue group-hover:text-white" style="font-size: 32px;">payments</span>
            </div>
            <h3 class="font-headline-md text-headline-md text-deep-navy mb-2">Đặt chỗ &amp; Thanh toán</h3>
            <p class="font-body-md text-on-surface-variant">Hướng dẫn thanh toán và quản lý đơn đặt tour của bạn.</p>
        </div>
        <!-- Changes & Cancellations -->
        <div class="bg-surface-container-lowest p-8 rounded-xl card-shadow card-shadow-hover text-center cursor-pointer border border-outline-variant/30 group">
            <div class="w-16 h-16 bg-ocean-blue/10 rounded-full flex items-center justify-center mx-auto mb-6 group-hover:bg-ocean-blue transition-colors">
                <span class="material-symbols-outlined text-ocean-blue group-hover:text-white" style="font-size: 32px;">event_repeat</span>
            </div>
            <h3 class="font-headline-md text-headline-md text-deep-navy mb-2">Thay đổi &amp; Hủy bỏ</h3>
            <p class="font-body-md text-on-surface-variant">Chính sách hoàn tiền, hủy chuyến và thay đổi lịch trình.</p>
        </div>
        <!-- Trip Information -->
        <div class="bg-surface-container-lowest p-8 rounded-xl card-shadow card-shadow-hover text-center cursor-pointer border border-outline-variant/30 group">
            <div class="w-16 h-16 bg-ocean-blue/10 rounded-full flex items-center justify-center mx-auto mb-6 group-hover:bg-ocean-blue transition-colors">
                <span class="material-symbols-outlined text-ocean-blue group-hover:text-white" style="font-size: 32px;">info</span>
            </div>
            <h3 class="font-headline-md text-headline-md text-deep-navy mb-2">Thông tin chuyến đi</h3>
            <p class="font-body-md text-on-surface-variant">Thông tin cần thiết trước khi khởi hành và trong chuyến đi.</p>
        </div>
        <!-- Deals & Membership -->
        <div class="bg-surface-container-lowest p-8 rounded-xl card-shadow card-shadow-hover text-center cursor-pointer border border-outline-variant/30 group">
            <div class="w-16 h-16 bg-ocean-blue/10 rounded-full flex items-center justify-center mx-auto mb-6 group-hover:bg-ocean-blue transition-colors">
                <span class="material-symbols-outlined text-ocean-blue group-hover:text-white" style="font-size: 32px;">loyalty</span>
            </div>
            <h3 class="font-headline-md text-headline-md text-deep-navy mb-2">Ưu đãi &amp; Thành viên</h3>
            <p class="font-body-md text-on-surface-variant">Đặc quyền hội viên Voyager Elite và mã giảm giá hấp dẫn.</p>
        </div>
    </div>
</section>

<!-- FAQ Section -->
<section class="py-16 bg-surface-container-low px-margin-desktop">
    <div class="max-w-4xl mx-auto">
        <div class="text-center mb-12">
            <h2 class="font-headline-lg text-headline-lg text-deep-navy mb-4">Câu hỏi thường gặp</h2>
            <div class="h-1 w-20 bg-action-orange mx-auto"></div>
        </div>
        <div class="space-y-4" id="faq-list">
            <!-- FAQ Item 1 -->
            <div class="accordion-item bg-surface-container-lowest rounded-xl card-shadow overflow-hidden transition-all">
                <button class="w-full flex items-center justify-between p-6 text-left hover:bg-surface-gray transition-colors" onclick="toggleAccordion(this)">
                    <span class="font-label-md text-label-md text-deep-navy faq-question">Làm thế nào để đổi lịch trình tour?</span>
                    <span class="material-symbols-outlined accordion-icon transition-transform">expand_more</span>
                </button>
                <div class="accordion-content">
                    <div class="p-6 pt-0 font-body-md text-on-surface-variant border-t border-outline-variant/20 faq-answer">
                        Bạn có thể đổi lịch trình bằng cách truy cập vào phần "Quản lý đặt chỗ" trên trang web hoặc ứng dụng. Lưu ý rằng việc thay đổi có thể phát sinh phí tùy theo thời điểm và chính sách của nhà cung cấp dịch vụ cụ thể.
                    </div>
                </div>
            </div>
            <!-- FAQ Item 2 -->
            <div class="accordion-item bg-surface-container-lowest rounded-xl card-shadow overflow-hidden transition-all">
                <button class="w-full flex items-center justify-between p-6 text-left hover:bg-surface-gray transition-colors" onclick="toggleAccordion(this)">
                    <span class="font-label-md text-label-md text-deep-navy faq-question">Chính sách hoàn tiền của VoyagerElite là gì?</span>
                    <span class="material-symbols-outlined accordion-icon transition-transform">expand_more</span>
                </button>
                <div class="accordion-content">
                    <div class="p-6 pt-0 font-body-md text-on-surface-variant border-t border-outline-variant/20 faq-answer">
                        Hoàn tiền 100% nếu hủy trước 7 ngày khởi hành. Từ 3-6 ngày, hoàn lại 50%. Trong vòng 48 giờ trước giờ khởi hành, chúng tôi rất tiếc không thể hoàn tiền trừ các trường hợp bất khả kháng theo quy định.
                    </div>
                </div>
            </div>
            <!-- FAQ Item 3 -->
            <div class="accordion-item bg-surface-container-lowest rounded-xl card-shadow overflow-hidden transition-all">
                <button class="w-full flex items-center justify-between p-6 text-left hover:bg-surface-gray transition-colors" onclick="toggleAccordion(this)">
                    <span class="font-label-md text-label-md text-deep-navy faq-question">Tôi có thể thanh toán bằng phương thức nào?</span>
                    <span class="material-symbols-outlined accordion-icon transition-transform">expand_more</span>
                </button>
                <div class="accordion-content">
                    <div class="p-6 pt-0 font-body-md text-on-surface-variant border-t border-outline-variant/20 faq-answer">
                        Chúng tôi hỗ trợ nhiều phương thức linh hoạt: Thẻ tín dụng (Visa, Mastercard, JCB), Chuyển khoản ngân hàng, Ví điện tử (Momo, VNPay, ZaloPay) và thanh toán trực tiếp tại văn phòng.
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Contact Options Section -->
<section class="py-24 px-margin-desktop max-w-container-max mx-auto">
    <div class="text-center mb-16">
        <h2 class="font-headline-lg text-headline-lg text-deep-navy mb-4">Bạn vẫn cần hỗ trợ?</h2>
        <p class="font-body-lg text-body-lg text-on-surface-variant">Đội ngũ chuyên viên của chúng tôi luôn sẵn sàng lắng nghe bạn.</p>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-gutter">
        <!-- Call Us -->
        <div class="flex flex-col items-center p-10 bg-surface-container-lowest border border-outline-variant/40 rounded-2xl card-shadow">
            <span class="material-symbols-outlined text-ocean-blue mb-6" style="font-size: 48px;">call</span>
            <h3 class="font-headline-md text-headline-md text-deep-navy mb-4">Gọi cho chúng tôi</h3>
            <p class="font-body-md text-on-surface-variant mb-6 text-center">Giải quyết vấn đề nhanh chóng qua điện thoại.</p>
            <a class="text-ocean-blue font-bold text-headline-md hover:underline" href="tel:19001234">Hotline 1900 1234 (24/7)</a>
        </div>
        <!-- Email Us -->
        <div class="flex flex-col items-center p-10 bg-surface-container-lowest border border-outline-variant/40 rounded-2xl card-shadow">
            <span class="material-symbols-outlined text-ocean-blue mb-6" style="font-size: 48px;">mail</span>
            <h3 class="font-headline-md text-headline-md text-deep-navy mb-4">Gửi Email</h3>
            <p class="font-body-md text-on-surface-variant mb-6 text-center">Thích hợp cho các yêu cầu cần gửi kèm tệp tin.</p>
            <a class="text-ocean-blue font-bold text-headline-md hover:underline" href="mailto:support@voyagerelite.vn">support@voyagerelite.vn</a>
        </div>
        <!-- Live Chat -->
        <div class="flex flex-col items-center p-10 bg-surface-container-lowest border border-outline-variant/40 rounded-2xl card-shadow">
            <span class="material-symbols-outlined text-ocean-blue mb-6" style="font-size: 48px;">forum</span>
            <h3 class="font-headline-md text-headline-md text-deep-navy mb-4">Trò chuyện trực tiếp</h3>
            <p class="font-body-md text-on-surface-variant mb-6 text-center">Chat trực tiếp với tư vấn viên ngay bây giờ.</p>
            <button class="bg-ocean-blue text-white px-10 py-3 rounded-xl font-label-md hover:bg-deep-navy transition-all active:scale-95" onclick="alert('Tính năng chat trực tiếp đang được kết nối...')">Trò chuyện ngay</button>
        </div>
    </div>
</section>

<script>
    function toggleAccordion(button) {
        const item = button.parentElement;
        const isActive = item.classList.contains('accordion-active');
        
        // Close all items
        document.querySelectorAll('.accordion-item').forEach(el => {
            el.classList.remove('accordion-active');
        });
        
        // Open clicked item if it wasn't active
        if (!isActive) {
            item.classList.add('accordion-active');
        }
    }

    // Dynamic FAQ Filtering
    function filterFAQs() {
        const query = document.getElementById('faq-search').value.toLowerCase();
        const items = document.querySelectorAll('.accordion-item');
        
        items.forEach(item => {
            const question = item.querySelector('.faq-question').innerText.toLowerCase();
            const answer = item.querySelector('.faq-answer').innerText.toLowerCase();
            
            if (question.includes(query) || answer.includes(query)) {
                item.style.display = 'block';
            } else {
                item.style.display = 'none';
            }
        });
    }
</script>

<%@ include file="layout/footer.jsp" %>
