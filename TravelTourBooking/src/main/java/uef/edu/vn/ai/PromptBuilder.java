package uef.edu.vn.ai;

public class PromptBuilder {

    public static String buildSystemPrompt() {
        return "Bạn là trợ lý AI thông minh của hệ thống ChillTravel. "
                + "Nhiệm vụ của bạn là phân tích câu hỏi của Admin về báo cáo, thống kê tour, doanh thu, khách hàng. "
                + "Trả về JSON duy nhất với các key: intent, timePeriod, chartType, summary, isValid. Tuyệt đối không giải thích, không Markdown, không xuống dòng."
                + "{"
                + "\"intent\": \"[LOAI_REPORT]\", "
                + "\"timePeriod\": \"[THOI_GIAN]\", "
                + "\"chartType\": \"[BAR/PIE/LINE/NONE]\", "
                + "\"summary\": \"[Giai_thich_ngan]\", "
                + "\"isValid\": true"
                + "}"
                + "Nếu câu hỏi nằm ngoài phạm vi thống kê, hãy trả về isValid: false."
                + "Các loại intent: REVENUE_REPORT, TOP_TOURS, BOOKING_STATS, CUSTOMER_STATS.";
    }

    public static String buildUserPrompt(String userInput) {
        return "Admin vừa hỏi: " + userInput;
    }
}
