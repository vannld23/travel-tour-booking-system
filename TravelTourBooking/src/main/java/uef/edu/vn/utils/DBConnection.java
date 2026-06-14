/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Tiện ích quản lý kết nối cơ sở dữ liệu.
 * Hỗ trợ cấu hình qua System Property hoặc biến môi trường.
 *
 * Mặc định: localhost:3307/travel_tour_booking, root, no password.
 */
public class DBConnection {

    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/travel_tour_booking?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException exception) {
            throw new ExceptionInInitializerError(exception);
        }
    }

    private DBConnection() {
    }

    /**
     * Trả về một Connection mới tới cơ sở dữ liệu.
     * Ưu tiên đọc cấu hình từ System Property, sau đó từ biến môi trường,
     * cuối cùng dùng giá trị mặc định.
     */
    public static Connection getConnection() throws SQLException {
        String url      = getConfig("TTBS_DB_URL",      DEFAULT_URL);
        String user     = getConfig("TTBS_DB_USER",     DEFAULT_USER);
        String password = getConfig("TTBS_DB_PASSWORD", DEFAULT_PASSWORD);
        return DriverManager.getConnection(url, user, password);
    }

    /**
     * Đọc giá trị cấu hình theo thứ tự ưu tiên:
     * System Property → Biến môi trường (env) → giá trị mặc định.
     */
    private static String getConfig(String key, String defaultValue) {
        String value = System.getProperty(key);
        if (value == null || value.isBlank()) {
            value = System.getenv(key);
        }
        return (value == null || value.isBlank()) ? defaultValue : value;
    }
}
