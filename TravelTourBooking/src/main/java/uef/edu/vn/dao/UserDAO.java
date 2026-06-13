package uef.edu.vn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import uef.edu.vn.model.User;
import uef.edu.vn.utils.DBConnection;

public class UserDAO {

    public User findByEmail(String email) {
        String sql = "SELECT user_id, full_name, email, password, phone, address, is_active, role_id, created_at "
                   + "FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("DB query failed in UserDAO.findByEmail: " + e.getMessage());
        }
        return null;
    }

    /**
     * Lấy toàn bộ danh sách người dùng (dùng cho BookingController.showAddForm).
     */
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT user_id, full_name, email, password, phone, address, is_active, role_id, created_at "
                   + "FROM users ORDER BY full_name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("DB query failed in UserDAO.findAll: " + e.getMessage());
        }
        return list;
    }

    /**
     * Checks if there are any users in the database.
     */
    public boolean hasAnyUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("DB query failed in UserDAO.hasAnyUsers: " + e.getMessage());
        }
        return false;
    }

    private User mapRow(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("user_id"),
            rs.getString("full_name"),
            rs.getString("email"),
            rs.getString("password"),
            rs.getString("phone"),
            rs.getString("address"),
            rs.getBoolean("is_active"),
            rs.getInt("role_id"),
            rs.getTimestamp("created_at")
        );
    }
}

