<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!-- Footer -->
    <footer class="bg-deep-navy w-full py-16 text-white">
        <div class="max-w-container-max mx-auto px-margin-desktop">
            <div class="flex flex-col md:flex-row justify-between gap-12">
                <div class="mb-12 md:mb-0 max-w-sm">
                    <span class="text-headline-md font-headline-md text-white mb-6 block font-bold">VoyagerElite</span>
                    <p class="text-surface-container text-body-md mb-8">VoyagerElite Travel mang đến cho bạn những trải nghiệm du lịch đẳng cấp, chuyên nghiệp và đầy cảm hứng trên khắp mọi miền tổ quốc và thế giới.</p>
                    <div class="flex gap-4">
                        <a class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center hover:bg-ocean-blue transition-colors" href="#">
                            <span class="material-symbols-outlined text-white">public</span>
                        </a>
                        <a class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center hover:bg-ocean-blue transition-colors" href="#">
                            <span class="material-symbols-outlined text-white">share</span>
                        </a>
                        <a class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center hover:bg-ocean-blue transition-colors" href="#">
                            <span class="material-symbols-outlined text-white">alternate_email</span>
                        </a>
                    </div>
                </div>
                
                <div class="grid grid-cols-2 lg:grid-cols-3 gap-x-12 gap-y-8">
                    <div>
                        <h4 class="font-label-md text-white mb-6 font-semibold">Liên kết</h4>
                        <ul class="space-y-4">
                            <li><a class="text-surface-container hover:text-ocean-blue transition-colors text-body-md" href="#">About Us</a></li>
                            <li><a class="text-surface-container hover:text-ocean-blue transition-colors text-body-md" href="#">Careers</a></li>
                            <li><a class="text-surface-container hover:text-ocean-blue transition-colors text-body-md" href="#">Sitemap</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-label-md text-white mb-6 font-semibold">Hỗ trợ</h4>
                        <ul class="space-y-4">
                            <li><a class="text-surface-container hover:text-ocean-blue transition-colors text-body-md" href="#">Privacy Policy</a></li>
                            <li><a class="text-surface-container hover:text-ocean-blue transition-colors text-body-md" href="#">Terms of Service</a></li>
                            <li><a class="text-surface-container hover:text-ocean-blue transition-colors text-body-md" href="#">Contact Support</a></li>
                        </ul>
                    </div>
                    <div class="col-span-2 lg:col-span-1">
                        <h4 class="font-label-md text-white mb-6 font-semibold">Liên hệ</h4>
                        <p class="text-surface-container text-body-md mb-2">123 Đường Du Lịch, Quận 1, TP. HCM</p>
                        <p class="text-surface-container text-body-md mb-2">Hotline: 1900 1234</p>
                        <p class="text-surface-container text-body-md">Email: support@voyagerelite.vn</p>
                    </div>
                </div>
            </div>
            
            <div class="w-full mt-16 pt-8 border-t border-white/10 flex flex-col md:flex-row justify-between items-center opacity-80 hover:opacity-100">
                <p class="text-surface-container text-body-md mb-4 md:mb-0">© 2024 VoyagerElite Travel. All rights reserved.</p>
                <div class="flex gap-4">
                    <span class="material-symbols-outlined text-surface-container">payments</span>
                    <span class="material-symbols-outlined text-surface-container">credit_card</span>
                    <span class="material-symbols-outlined text-surface-container">account_balance</span>
                </div>
            </div>
        </div>
    </footer>

    <script>
        // Smooth transitions for interaction states
        document.querySelectorAll('button, a').forEach(elem => {
            elem.addEventListener('mousedown', () => elem.style.transform = 'scale(0.95)');
            elem.addEventListener('mouseup', () => elem.style.transform = '');
            elem.addEventListener('mouseleave', () => elem.style.transform = '');
        });
    </script>
</body>
</html>
