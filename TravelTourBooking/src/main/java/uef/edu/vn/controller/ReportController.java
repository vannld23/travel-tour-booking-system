/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uef.edu.vn.dao.DashboardDAO;
import uef.edu.vn.dto.RevenueByTimeDTO;
import uef.edu.vn.dto.TourReportDTO;
import uef.edu.vn.model.DashboardDTO;
import uef.edu.vn.service.ReportService;

/**
 *
 * @author LENOVO
 */
@Controller
@RequestMapping("/admin/report")
public class ReportController {

    private final ReportService reportService = new ReportService();

    // Báo cáo 1: Tổng quan hệ thống
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        // Lấy dữ liệu thống kê từ Service
        DashboardDTO stats = reportService.getSystemOverview();
        DashboardDAO dashboardDAO = new DashboardDAO();
        // Truyền vào model với key "stats"
        model.addAttribute("stats", stats);

        //Lấy danh sách Top 5 Tour (đã có sẵn trong DashboardDAO của bạn)
        model.addAttribute("topTours", dashboardDAO.getTopTours());

        model.addAttribute("activePage", "report-dashboard");

        // Trả về view báo cáo
        return "admin/report/dashboard-report";
    }

    // Báo cáo 2 : Doanh thu theo thời gian
    @GetMapping("/revenue-time")
    public String getRevenueByTime(@RequestParam(defaultValue = "2026-01-01") String startDate,
            @RequestParam(defaultValue = "2026-12-31") String endDate,
            Model model) {

        // Gọi service
        List<RevenueByTimeDTO> data = reportService.getRevenueByTime(startDate, endDate);

        // Đẩy dữ liệu sang JSP
        model.addAttribute("revenueList", data);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("activePage", "report-revenue");

        return "admin/report/revenue-time";
    }

    // Báo cáo 3: Tour bán chạy nhất
    @GetMapping("/top-selling-tours")
    public String getTopSellingTours(
            @RequestParam(defaultValue = "2026-01-01") String startDate,
            @RequestParam(defaultValue = "2026-12-31") String endDate,
            Model model) {

        model.addAttribute("topTours", reportService.getTopSellingTours(startDate, endDate));
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        return "admin/report/top-selling-tours";
            }

    // Endpoint tạm thời để khởi tạo bảng vouchers và chèn các vai trò còn thiếu
    @GetMapping("/init-db")
    @org.springframework.web.bind.annotation.ResponseBody
    public String initDb() {
        String sqlVoucher = """
            CREATE TABLE IF NOT EXISTS vouchers (
                voucher_id INT AUTO_INCREMENT PRIMARY KEY,
                code VARCHAR(50) NOT NULL UNIQUE,
                discount_percentage DECIMAL(5,2) NOT NULL,
                max_discount_amount DECIMAL(15,2),
                min_order_amount DECIMAL(15,2),
                start_date DATE,
                end_date DATE,
                usage_limit INT DEFAULT 100,
                used_count INT DEFAULT 0,
                status VARCHAR(20) DEFAULT 'ACTIVE',
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        """;
        
        String sqlRole3 = "INSERT INTO roles (role_id, role_name) VALUES (3, 'STAFF') ON DUPLICATE KEY UPDATE role_name='STAFF'";
        String sqlRole4 = "INSERT INTO roles (role_id, role_name) VALUES (4, 'MANAGER') ON DUPLICATE KEY UPDATE role_name='MANAGER'";

        try (java.sql.Connection conn = uef.edu.vn.utils.DBConnection.getConnection()) {
            // 1. Tạo bảng vouchers
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sqlVoucher)) {
                stmt.executeUpdate();
            }
            
            // 2. Chèn role 3
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sqlRole3)) {
                stmt.executeUpdate();
            }
            
            // 3. Chèn role 4
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sqlRole4)) {
                stmt.executeUpdate();
            }
            
            return "SUCCESS: Table 'vouchers' and missing Roles (3: STAFF, 4: MANAGER) have been initialized in database!";
        } catch (java.sql.SQLException e) {
            return "ERROR: Failed to initialize database: " + e.getMessage();
        }
    }
}
