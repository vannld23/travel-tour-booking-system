package uef.edu.vn.service;

import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.dao.UserDAO;
import uef.edu.vn.model.Booking; // Cần import thêm class Booking
import uef.edu.vn.model.DashboardDTO;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import uef.edu.vn.dto.RevenueByTimeDTO;

public class ReportService {

    private BookingDAO bookingDAO = new BookingDAO();
    private TourDAO tourDAO = new TourDAO();
    private UserDAO userDAO = new UserDAO();

    // Báo cáo 1 : tổng quan hệ thống
    public DashboardDTO getSystemOverview() {
        // Thay vì dùng var, dùng List<Booking> để tương thích mọi bản Java
        List<Booking> allBookings = bookingDAO.getAllBookings();

        int totalBookings = (allBookings != null) ? allBookings.size() : 0;
        int totalTours = (tourDAO.findAll() != null) ? tourDAO.findAll().size() : 0;
        int totalUsers = (userDAO.findAll() != null) ? userDAO.findAll().size() : 0;

        BigDecimal totalRevenue = BigDecimal.ZERO;

        // Dùng vòng lặp for-each truyền thống
        if (allBookings != null) {
            for (Booking booking : allBookings) {
                if ("COMPLETED".equals(booking.getBookingStatus())) {
                    // Đảm bảo hàm getTotalPrice() trả về double hoặc BigDecimal
                    totalRevenue = totalRevenue.add(BigDecimal.valueOf(booking.getTotalPrice()));
                }
            }
        }

        return new DashboardDTO(totalUsers, totalTours, totalBookings, totalRevenue);
    }

    // Báo cáo 2 : Donh thu theo thời gian
    public List<RevenueByTimeDTO> getRevenueByTime(String startDateStr, String endDateStr) {
        List<Booking> allBookings = bookingDAO.getAllBookings();
        Map<String, BigDecimal> revenueMap = new TreeMap<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");

        try {
            // Chuyển String input sang Timestamp để so sánh
            Timestamp start = Timestamp.valueOf(startDateStr + " 00:00:00");
            Timestamp end = Timestamp.valueOf(endDateStr + " 23:59:59");

            if (allBookings != null) {
                for (Booking b : allBookings) {
                    if ("COMPLETED".equals(b.getBookingStatus()) && b.getBookingDate() != null) {
                        Timestamp date = b.getBookingDate();

                        // So sánh Timestamp
                        if (!date.before(start) && !date.after(end)) {
                            String month = sdf.format(date); // Dùng sdf để lấy "yyyy-MM"
                            BigDecimal amount = BigDecimal.valueOf(b.getTotalPrice());

                            revenueMap.put(month, revenueMap.getOrDefault(month, BigDecimal.ZERO).add(amount));
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý lỗi parse ngày tháng
        }

        // Chuyển từ Map sang List DTO
        List<RevenueByTimeDTO> result = new ArrayList<>();
        for (Map.Entry<String, BigDecimal> entry : revenueMap.entrySet()) {
            result.add(new RevenueByTimeDTO(entry.getKey(), entry.getValue()));
        }
        return result;
    }
}
