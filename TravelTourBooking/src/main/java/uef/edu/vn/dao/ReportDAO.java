package uef.edu.vn.dao;

import uef.edu.vn.model.DashboardDTO;
import uef.edu.vn.utils.DBConnection; // Import đúng lớp kết nối
import java.sql.*;

public class ReportDAO {

    public DashboardDTO getSystemOverview() {
        DashboardDTO dto = new DashboardDTO();
        String sql = "SELECT (SELECT COUNT(*) FROM bookings) AS total_bookings, "
                + "(SELECT SUM(total_price) FROM bookings WHERE booking_status = 'COMPLETED') AS total_revenue, "
                + // Lưu ý tên cột/trạng thái
                "(SELECT COUNT(*) FROM tours WHERE status = 'ACTIVE') AS active_tours, "
                + "(SELECT COUNT(*) FROM users WHERE role = 'CLIENT') AS total_customers";

        try (Connection conn = DBConnection.getConnection(); // Dùng đúng DBConnection
                 PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                dto.setTotalBookings(rs.getInt("total_bookings")); // Dùng int nếu trong DTO là int
                dto.setTotalRevenue(rs.getBigDecimal("total_revenue")); // Lưu ý: dùng getBigDecimal cho kiểu BigDecimal
                dto.setTotalTours(rs.getInt("active_tours"));         // Sửa từ setActiveTours thành setTotalTours
                dto.setTotalUsers(rs.getInt("total_customers"));      // Sửa từ setTotalCustomers thành setTotalUsers
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dto;
    }
}
