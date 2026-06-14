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
import uef.edu.vn.dao.ReportDAO;
import uef.edu.vn.dto.RevenueByTimeDTO;
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

        // Truyền vào model với key "stats"
        model.addAttribute("stats", stats);

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
}
