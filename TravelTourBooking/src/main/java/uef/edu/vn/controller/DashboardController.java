package uef.edu.vn.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import uef.edu.vn.dao.DashboardDAO;
import uef.edu.vn.model.DashboardDTO;
import uef.edu.vn.model.MonthlyRevenueDTO;
import uef.edu.vn.model.TopTourDTO;
import uef.edu.vn.model.TourRevenueDTO;

/**
 * Controller handling the dashboard administrative view.
 */
@Controller
public class DashboardController {

    private final DashboardDAO dashboardDAO = new DashboardDAO();

    /**
     * Maps the admin dashboard page. Supports both /dashboard and /admin/dashboard for compatibility.
     * 
     * @param model Spring MVC model
     * @return JSP view path
     */
    @GetMapping({"/", "/dashboard", "/admin/dashboard"})
    public String index(Model model) {
        // Fetch stats from DAO
        DashboardDTO stats = dashboardDAO.getAllDashboardStats();
        List<TourRevenueDTO> tourRevenues = dashboardDAO.getRevenueByTour();
        List<TopTourDTO> topTours = dashboardDAO.getTopTours();
        List<MonthlyRevenueDTO> monthlyRevenues = dashboardDAO.getMonthlyRevenue();

        // Bind data to Model
        model.addAttribute("stats", stats);
        model.addAttribute("tourRevenues", tourRevenues);
        model.addAttribute("topTours", topTours);
        model.addAttribute("monthlyRevenues", monthlyRevenues);
        model.addAttribute("currentYear", java.time.LocalDate.now().getYear());

        return "admin/dashboard/index";
    }
}
