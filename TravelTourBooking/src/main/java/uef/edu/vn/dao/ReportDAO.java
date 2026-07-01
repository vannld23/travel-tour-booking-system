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

        // Spring JdbcTemplate tự quản lý Connection, nên code gọn hơn nhiều
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
            DashboardDTO dto = new DashboardDTO();
            dto.setTotalBookings(rs.getInt("total_bookings"));
            dto.setTotalRevenue(rs.getBigDecimal("total_revenue"));
            dto.setTotalTours(rs.getInt("active_tours"));
            dto.setTotalUsers(rs.getInt("total_customers"));
            return dto;
        });
    }

    public List<Double> getRevenueDataByMonth(String month) {
        // Thay SELECT ... bằng câu lệnh SQL thực tế của bạn
        String sql = "SELECT SUM(total_price) FROM bookings WHERE MONTH(booking_date) = ? GROUP BY WEEK(booking_date)";
        return jdbcTemplate.queryForList(sql, new Object[]{month}, Double.class);
    }
}