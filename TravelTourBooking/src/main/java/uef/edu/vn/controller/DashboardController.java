package uef.edu.vn.controller;

import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import uef.edu.vn.dao.DashboardDAO;
import uef.edu.vn.model.DashboardDTO;
import uef.edu.vn.model.MonthlyRevenueDTO;
import uef.edu.vn.model.TopTourDTO;
import uef.edu.vn.model.TourRevenueDTO;
import uef.edu.vn.model.User;

@Controller
public class DashboardController {

    private final DashboardDAO dashboardDAO = new DashboardDAO();

    /**
     * Admin Dashboard
     */

    @GetMapping({"/dashboard", "/admin/dashboard"})
    public String index(
            HttpSession session,
            Model model) {

        User currentUser =
                (User) session.getAttribute("currentUser");

        // Chưa đăng nhập
        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        // Không phải Admin
        if (currentUser.getRoleId() != 1) {
            return "redirect:/user/profile";
        }

        DashboardDTO stats =
                dashboardDAO.getAllDashboardStats();

        List<TourRevenueDTO> tourRevenues =
                dashboardDAO.getRevenueByTour();

        List<TopTourDTO> topTours =
                dashboardDAO.getTopTours();

        List<MonthlyRevenueDTO> monthlyRevenues =
                dashboardDAO.getMonthlyRevenue();


        model.addAttribute("stats", stats);
        model.addAttribute("tourRevenues", tourRevenues);
        model.addAttribute("topTours", topTours);
        model.addAttribute("monthlyRevenues", monthlyRevenues);
        model.addAttribute(
                "currentYear",
                LocalDate.now().getYear());

        model.addAttribute(
                "currentUser",
                currentUser);

        return "admin/dashboard/index";
    }
}