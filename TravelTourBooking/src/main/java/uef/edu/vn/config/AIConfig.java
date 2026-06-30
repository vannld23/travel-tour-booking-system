package uef.edu.vn.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class AIConfig {

    private static final Properties properties = new Properties();

    static {
        try (
            InputStream input =
                    AIConfig.class.getClassLoader()
                            .getResourceAsStream("ai.properties")
        ) {

            if (input == null) {
                throw new RuntimeException(
                        "Không tìm thấy file ai.properties"
                );
            }

            properties.load(input);

        } catch (IOException exception) {
            throw new RuntimeException(exception);
        }
    }

    public static String getApiKey() {
        return properties.getProperty("gemini.api.key");
    }

    public static String getModel() {
        return properties.getProperty("gemini.model");
    }
}