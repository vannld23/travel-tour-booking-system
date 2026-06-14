package uef.edu.vn.service;

import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.dao.UserDAO; 
import uef.edu.vn.model.Booking; // Cần import thêm class Booking
import uef.edu.vn.model.DashboardDTO;
import java.math.BigDecimal;
import java.util.List;

public class ReportService {

    private BookingDAO bookingDAO = new BookingDAO();
    private TourDAO tourDAO = new TourDAO();
    private UserDAO userDAO = new UserDAO();

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
}