package uef.edu.vn.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import uef.edu.vn.ai.AIIntentDTO;
import uef.edu.vn.ai.GeminiService;
import uef.edu.vn.ai.AIIntentDTO;
import uef.edu.vn.dao.ReportDAO;

@Controller
public class AIReportController {

    // Khởi tạo service (nếu bạn chưa cấu hình Bean thì có thể dùng new như cách cũ, 
    // nhưng khuyến khích cấu hình Bean trong Spring Context)
    private final GeminiService geminiService = new GeminiService();
    @Autowired
    private ReportDAO reportRepository;

    @GetMapping("/admin/ai/report")
    public String showAIReportPage() {
        return "admin/report/aireport";
    }

    @PostMapping(value = "/admin/ai/ask", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AIIntentDTO getAIReport(@RequestParam("question") String question) {

        // 1. Gọi Gemini phân tích intent
        AIIntentDTO intent = geminiService.getAIIntent(question);

        // 2. Kiểm tra nếu intent hợp lệ và yêu cầu báo cáo doanh thu
        if (intent == null) {
            return new AIIntentDTO("ERROR", null, "BAR", "Hệ thống đang bận, hãy thử lại", false);
        }

        if ("REVENUE_REPORT".equals(intent.getIntent())) {
            List<Double> data = reportRepository.getRevenueDataByMonth(intent.getTimePeriod());
            intent.setData(data);
            intent.setIsValid(true);
        }

        return intent; // Luôn trả về object, dù lỗi hay thành công
    }
}
