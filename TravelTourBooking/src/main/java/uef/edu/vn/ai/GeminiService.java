package uef.edu.vn.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import uef.edu.vn.config.AIConfig;

public class GeminiService implements AIService {

    private final String apiKey = AIConfig.getApiKey();
    private final String model = AIConfig.getModel();

    @Override
    public String ask(String prompt) throws Exception {

        String endpoint
                = "https://generativelanguage.googleapis.com/v1beta/models/"
                + model
                + ":generateContent?key="
                + apiKey;

        String requestBody = """
        {
            "contents": [
                {
                    "parts": [
                        {
                            "text": "%s"
                        }
                    ]
                }
            ]
        }
        """.formatted(
                prompt.replace("\"", "\\\"")
        );

        HttpClient client = HttpClient.newHttpClient();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(endpoint))
                .header("Content-Type", "application/json; charset=UTF-8")
                .POST(HttpRequest.BodyPublishers.ofString(
                        requestBody,
                        StandardCharsets.UTF_8
                ))
                .build();

        HttpResponse<String> response = client.send(
                request,
                HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8)
        );

        if (response.statusCode() != 200) {
            return response.body();
        }

        ObjectMapper mapper = new ObjectMapper();

        JsonNode root = mapper.readTree(response.body());

        JsonNode candidates = root.path("candidates");

        if (!candidates.isArray() || candidates.isEmpty()) {
            return "Gemini không trả về dữ liệu.";
        }

        String result = candidates
                .get(0)
                .path("content")
                .path("parts")
                .get(0)
                .path("text")
                .asText();

        System.out.println("========== GEMINI RESPONSE ==========");
        System.out.println(result);
        System.out.println("=====================================");

        return result;
    }

    public AIIntentDTO getAIIntent(String userInput) {
        String systemPrompt = PromptBuilder.buildSystemPrompt();
        String userPrompt = PromptBuilder.buildUserPrompt(userInput);

        String jsonResponse = callGeminiApi(systemPrompt, userPrompt);

        if (jsonResponse != null) {
            // Cải tiến Cleaning: Chỉ bỏ markdown, không cắt xén cấu trúc JSON
            jsonResponse = jsonResponse.replace("```json", "").replace("```", "").trim();
        }

        try {
            ObjectMapper mapper = new ObjectMapper();
            // Cấu hình thêm để tránh lỗi nghiêm ngặt
            mapper.configure(com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

            System.out.println("DEBUG JSON Response: " + jsonResponse);
            return mapper.readValue(jsonResponse, AIIntentDTO.class);
        } catch (Exception e) {
            System.err.println("Lỗi Parse JSON: " + e.getMessage());
            return new AIIntentDTO("ERROR", null, null, "Không thể phân tích yêu cầu", false);
        }
    }

    private String callGeminiApi(String systemPrompt, String userPrompt) {
        // Kết hợp systemPrompt và userPrompt thành một chuỗi prompt duy nhất để gửi cho Gemini
        String combinedPrompt = systemPrompt + " " + userPrompt;

        try {
            // Tái sử dụng logic gọi API của bạn
            return this.ask(combinedPrompt);
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"intent\": \"ERROR\", \"isValid\": false, \"summary\": \"Lỗi khi gọi API Gemini\"}";
        }
    }
}
