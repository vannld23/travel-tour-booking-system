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
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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
     * Lấy toàn bộ danh sách người dùng (dùng cho
     * BookingController.showAddForm).
     */
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT user_id, full_name, email, password, phone, address, is_active, role_id, created_at "
                + "FROM users ORDER BY full_name";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
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
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("DB query failed in UserDAO.hasAnyUsers: " + e.getMessage());
        }
        return false;
    }

    public boolean emailExists(String email) {

        String sql = "SELECT 1 FROM users WHERE email = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            return rs.next();

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return false;
    }

    public boolean insertUser(User user) {

        String sql = """
        INSERT INTO users
        (
            full_name,
            email,
            password,
            phone,
            address,
            role_id
        )
        VALUES
        (?, ?, ?, ?, ?, ?)
    """;

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getAddress());
            stmt.setInt(6, user.getRoleId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return false;
    }

    public User login(String email, String password) {

        String sql = """
        SELECT *
        FROM users
        WHERE email = ?
        AND password = ?
        AND is_active = 1
    """;

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }

    public User findById(int userId) {

        String sql = """
        SELECT *
        FROM users
        WHERE user_id = ?
    """;

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }

    public boolean updateProfile(User user) {

        String sql = """
        UPDATE users
        SET
            full_name = ?,
            phone = ?,
            address = ?
        WHERE user_id = ?
    """;

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getPhone());
            stmt.setString(3, user.getAddress());
            stmt.setInt(4, user.getUserId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
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

    public boolean save(User user) {
        String sql = "INSERT INTO users (full_name, email, password, phone, address, is_active, role_id) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getAddress());
            stmt.setBoolean(6, user.isActive());
            stmt.setInt(7, user.getRoleId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("DB query failed in UserDAO.save: " + e.getMessage());
        }
        return false;
    }
}
