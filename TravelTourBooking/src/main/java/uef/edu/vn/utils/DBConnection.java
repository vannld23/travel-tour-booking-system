/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author LENOVO
 */
public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3307/travel_tour_booking";

    private static final String USER = "root";

    private static final String PASSWORD = "";

    public static Connection getConnection() {

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException exception) {
            throw new ExceptionInInitializerError(exception);
        }
    }

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        String url = getConfig("TTBS_DB_URL", DEFAULT_URL);
        String user = getConfig("TTBS_DB_USER", DEFAULT_USER);
        String password = getConfig("TTBS_DB_PASSWORD", DEFAULT_PASSWORD);
        return DriverManager.getConnection(url, user, password);
    }

    private static String getConfig(String key, String defaultValue) {
        String value = System.getProperty(key);
        if (value == null || value.isBlank()) {
            value = System.getenv(key);
        }
        return value == null || value.isBlank() ? defaultValue : value;
    }
}
