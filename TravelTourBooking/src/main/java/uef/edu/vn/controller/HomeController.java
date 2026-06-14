package uef.edu.vn.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
            @org.springframework.web.bind.annotation.RequestParam(value = "destinationId", required = false) Integer destinationId,
            @org.springframework.web.bind.annotation.RequestParam(value = "priceRange", required = false) String priceRange,
            Model model) {
        
        // Fetch matching tours
        List<Tour> tours = tourDAO.search(keyword, destinationId, null, null, Tour.Status.ACTIVE, "tourName", "ASC", 100, 0);
        
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
        model.addAttribute("destinationId", destinationId);
        model.addAttribute("priceRange", priceRange);

        return "client/home/home";
    }

    @GetMapping("/destinations")
    public String destinations(Model model) {
        List<Destination> destinations = destinationDAO.findAll();
        // Lọc các điểm đến đang hoạt động (ACTIVE) cho khách hàng xem
        List<Destination> activeDestinations = destinations.stream()
                .filter(d -> d.getStatus() == Destination.Status.ACTIVE)
                .collect(java.util.stream.Collectors.toList());
        model.addAttribute("destinations", activeDestinations);
        model.addAttribute("pageTitle", "Điểm đến | VoyagerElite Luxury Travel");
        return "client/home/destination";
    }

    @GetMapping("/deals")
    public String deals(Model model) {
        // Lấy tất cả tour đang hoạt động
        List<Tour> allTours = tourDAO.findAll();
        List<Tour> activeTours = allTours.stream()
                .filter(t -> t.getStatus() == Tour.Status.ACTIVE)
                .collect(java.util.stream.Collectors.toList());

        // Phân bổ tour cho mục Flash Sales và Limited Deals
        List<Tour> flashSaleTours = java.util.Collections.emptyList();
        List<Tour> limitedTours = java.util.Collections.emptyList();

        if (activeTours.size() >= 2) {
            flashSaleTours = activeTours.subList(0, 2);
            if (activeTours.size() >= 6) {
                limitedTours = activeTours.subList(2, 6);
            } else {
                limitedTours = activeTours.subList(2, activeTours.size());
            }
        } else {
            flashSaleTours = activeTours;
        }

        model.addAttribute("flashSaleTours", flashSaleTours);
        model.addAttribute("limitedTours", limitedTours);
        model.addAttribute("pageTitle", "Ưu đãi | VoyagerElite Luxury Travel");
        return "client/home/deals";
    }

    @GetMapping("/support")
    public String support(Model model) {
        model.addAttribute("pageTitle", "Trung tâm Hỗ trợ | VoyagerElite");
        return "client/home/support";
    }

    @GetMapping("/tour/detail")
    public String tourDetail(@RequestParam("id") int id, Model model) {
        Tour tour = tourDAO.findById(id);
        if (tour == null) {
            return "redirect:/";
        }
        model.addAttribute("tour", tour);
        
        // Lấy lịch trình của tour
        List<uef.edu.vn.model.Itinerary> itineraries = new uef.edu.vn.dao.ItineraryDAO().findByTourId(id);
        model.addAttribute("itineraries", itineraries);

        // Lấy danh sách tour liên quan (khác tour hiện tại)
        List<Tour> allTours = tourDAO.findAll();
        List<Tour> relatedTours = allTours.stream()
                .filter(t -> t.getStatus() == Tour.Status.ACTIVE && t.getTourId() != id)
                .limit(3)
                .collect(java.util.stream.Collectors.toList());
        model.addAttribute("relatedTours", relatedTours);
        
        model.addAttribute("pageTitle", tour.getTourName() + " | VoyagerElite");
        return "client/home/tour-detail";
    }
}

