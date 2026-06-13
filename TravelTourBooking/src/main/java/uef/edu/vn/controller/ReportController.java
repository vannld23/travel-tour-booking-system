/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import uef.edu.vn.dao.DashboardDAO;
import uef.edu.vn.dao.ReportDAO;
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
}

