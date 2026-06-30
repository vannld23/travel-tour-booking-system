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
}
