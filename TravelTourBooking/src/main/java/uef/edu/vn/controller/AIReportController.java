package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import uef.edu.vn.ai.GeminiService;

@Controller
public class AIReportController {

    @GetMapping(
            value = "/admin/ai/test-gemini",
            produces = "text/plain;charset=UTF-8"
    )
    @ResponseBody
    public String testGemini() {

        try {

            GeminiService geminiService
                    = new GeminiService();

            return geminiService.ask(
                    "Xin chào Gemini, hãy giới thiệu ngắn gọn về bản thân bạn."
            );

        } catch (Exception exception) {

            exception.printStackTrace();

            return exception.getMessage();
        }
    }
}
