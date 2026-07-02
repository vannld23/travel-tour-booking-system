package uef.edu.vn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import uef.edu.vn.model.Voucher;
import uef.edu.vn.utils.DBConnection;

public class VoucherDAO {

    public List<Voucher> findAll() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM vouchers ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("DB query failed in VoucherDAO.findAll: " + e.getMessage());
        }
        return list;
    }

    public Voucher findById(int id) {
        String sql = "SELECT * FROM vouchers WHERE voucher_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("DB query failed in VoucherDAO.findById: " + e.getMessage());
        }
        return null;
    }

    public Voucher findByCode(String code) {
        String sql = "SELECT * FROM vouchers WHERE code = ? AND status = 'ACTIVE'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("DB query failed in VoucherDAO.findByCode: " + e.getMessage());
        }
        return null;
    }

    public boolean save(Voucher voucher) {
        String sql = "INSERT INTO vouchers (code, discount_percentage, max_discount_amount, min_order_amount, start_date, end_date, usage_limit, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, voucher.getCode().toUpperCase().trim());
            stmt.setBigDecimal(2, voucher.getDiscountPercentage());
            stmt.setBigDecimal(3, voucher.getMaxDiscountAmount());
            stmt.setBigDecimal(4, voucher.getMinOrderAmount());
            stmt.setDate(5, voucher.getStartDate());
            stmt.setDate(6, voucher.getEndDate());
            stmt.setInt(7, voucher.getUsageLimit());
            stmt.setString(8, voucher.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("DB query failed in VoucherDAO.save: " + e.getMessage());
        }
        return false;
    }

    public boolean update(Voucher voucher) {
        String sql = "UPDATE vouchers SET code = ?, discount_percentage = ?, max_discount_amount = ?, min_order_amount = ?, start_date = ?, end_date = ?, usage_limit = ?, status = ? "
                   + "WHERE voucher_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, voucher.getCode().toUpperCase().trim());
            stmt.setBigDecimal(2, voucher.getDiscountPercentage());
            stmt.setBigDecimal(3, voucher.getMaxDiscountAmount());
            stmt.setBigDecimal(4, voucher.getMinOrderAmount());
            stmt.setDate(5, voucher.getStartDate());
            stmt.setDate(6, voucher.getEndDate());
            stmt.setInt(7, voucher.getUsageLimit());
            stmt.setString(8, voucher.getStatus());
            stmt.setInt(9, voucher.getVoucherId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("DB query failed in VoucherDAO.update: " + e.getMessage());
        }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM vouchers WHERE voucher_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("DB query failed in VoucherDAO.delete: " + e.getMessage());
        }
        return false;
    }

    private Voucher mapRow(ResultSet rs) throws SQLException {
        return new Voucher(
            rs.getInt("voucher_id"),
            rs.getString("code"),
            rs.getBigDecimal("discount_percentage"),
            rs.getBigDecimal("max_discount_amount"),
            rs.getBigDecimal("min_order_amount"),
            rs.getDate("start_date"),
            rs.getDate("end_date"),
            rs.getInt("usage_limit"),
            rs.getInt("used_count"),
            rs.getString("status"),
            rs.getTimestamp("created_at")
        );
    }
}
