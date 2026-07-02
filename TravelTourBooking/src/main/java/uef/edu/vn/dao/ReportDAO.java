package uef.edu.vn.dao;

import uef.edu.vn.model.DashboardDTO;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public DashboardDTO getSystemOverview() {
        String sql = "SELECT " +
                     "(SELECT COUNT(*) FROM bookings) AS total_bookings, " +
                     "(SELECT SUM(total_price) FROM bookings WHERE booking_status = 'COMPLETED') AS total_revenue, " +
                     "(SELECT COUNT(*) FROM tours WHERE status = 'ACTIVE') AS active_tours, " +
                     "(SELECT COUNT(*) FROM users WHERE role = 'CLIENT') AS total_customers";

        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
            DashboardDTO dto = new DashboardDTO();
            dto.setTotalBookings(rs.getInt("total_bookings"));
            // Xử lý null cho BigDecimal nếu chưa có dữ liệu
            dto.setTotalRevenue(rs.getBigDecimal("total_revenue") != null ? rs.getBigDecimal("total_revenue") : java.math.BigDecimal.ZERO);
            dto.setTotalTours(rs.getInt("active_tours"));
            dto.setTotalUsers(rs.getInt("total_customers"));
            return dto;
        });
    }

    public List<Double> getRevenueDataByMonth(String monthInput) {
        // 1. Lọc số tháng từ chuỗi (Ví dụ: "tháng 4" -> 4)
        String monthNumber = monthInput.replaceAll("[^0-9]", "");
        
        // 2. Câu lệnh SQL chuẩn: Lấy tổng tiền theo tháng, không group theo tuần 
        // nếu bạn muốn biểu đồ hiển thị doanh thu tổng của cả tháng đó.
        String sql = "SELECT IFNULL(SUM(total_price), 0) FROM bookings " +
                     "WHERE MONTH(booking_date) = ? AND booking_status = 'COMPLETED'";
        
        System.out.println("DEBUG - SQL: " + sql + " với tham số: " + monthNumber);

        // Sử dụng queryForList trả về List<Double>
        return jdbcTemplate.queryForList(sql, new Object[]{monthNumber}, Double.class);
    }
}