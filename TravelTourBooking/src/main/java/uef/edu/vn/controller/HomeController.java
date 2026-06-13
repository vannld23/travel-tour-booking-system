package uef.edu.vn.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import uef.edu.vn.dao.DestinationDAO;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.model.Destination;
import uef.edu.vn.model.Tour;

/**
 * Controller phục vụ trang chủ khách hàng (client).
 */
@Controller
public class HomeController {

    private final TourDAO tourDAO = new TourDAO();
    private final DestinationDAO destinationDAO = new DestinationDAO();

    @GetMapping({"/", "/index", "/home"})
    public String home(
            @org.springframework.web.bind.annotation.RequestParam(value = "keyword", required = false) String keyword,
            @org.springframework.web.bind.annotation.RequestParam(value = "priceRange", required = false) String priceRange,
            Model model) {
        
        // Fetch matching tours
        List<Tour> tours = tourDAO.search(keyword, null, null, null, Tour.Status.ACTIVE, "tourName", "ASC", 100, 0);
        
        // Filter by price range in Java Stream to avoid complex DB queries
        if (priceRange != null && !priceRange.isBlank()) {
            tours = tours.stream().filter(t -> {
                java.math.BigDecimal price = t.getPrice();
                if (price == null) return false;
                double val = price.doubleValue();
                switch (priceRange) {
                    case "under_5m":
                        return val < 5000000;
                    case "5_10m":
                        return val >= 5000000 && val <= 10000000;
                    case "above_10m":
                        return val > 10000000;
                    default:
                        return true;
                }
            }).collect(java.util.stream.Collectors.toList());
        }

        // Limit to 6 items for the homepage display
        if (tours.size() > 6) {
            tours = tours.subList(0, 6);
        }
        
        // Fetch all destinations
        List<Destination> destinations = destinationDAO.findAll();

        model.addAttribute("tours", tours);
        model.addAttribute("destinations", destinations);
        model.addAttribute("keyword", keyword);
        model.addAttribute("priceRange", priceRange);

        return "client/home";
    }
}
