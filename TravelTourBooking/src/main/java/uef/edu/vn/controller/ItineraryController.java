package uef.edu.vn.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uef.edu.vn.dao.ItineraryDAO;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.model.Itinerary;

/**
 * Controller class for managing Tour Itineraries (Lịch trình Tour).
 * Hỗ trợ bộ lọc tìm kiếm nâng cao, phân trang, sắp xếp và quản lý trạng thái.
 */
@Controller
@RequestMapping("/itinerary")
public class ItineraryController {

    private final ItineraryDAO itineraryDAO = new ItineraryDAO();
    private final TourDAO tourDAO = new TourDAO();

    // ─── DANH SÁCH + TÌM KIẾM + PHÂN TRANG + SẮP XẾP ──────────────────────────

    @GetMapping({"", "/", "/list"})
    public String list(
            @RequestParam(value = "tourId", required = false) Integer tourId,
            @RequestParam(value = "dayNumber", required = false) Integer dayNumber,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "status", required = false) String statusStr,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            @RequestParam(value = "sortBy", defaultValue = "tourName") String sortBy,
            @RequestParam(value = "sortDir", defaultValue = "ASC") String sortDir,
            Model model) {

        // Parse status enum
        Itinerary.Status statusFilter = null;
        if (statusStr != null && !statusStr.isBlank()) {
            try {
                statusFilter = Itinerary.Status.valueOf(statusStr.toUpperCase());
            } catch (IllegalArgumentException ignored) {}
        }

        // Đảm bảo phân trang hợp lệ
        if (page < 1) page = 1;
        if (size < 1) size = 5;
        int offset = (page - 1) * size;

        // Tìm kiếm và đếm tổng số phần tử
        List<Itinerary> itineraries = itineraryDAO.search(tourId, dayNumber, keyword, statusFilter, sortBy, sortDir, size, offset);
        int totalItems = itineraryDAO.count(tourId, dayNumber, keyword, statusFilter);
        int totalPages = (int) Math.ceil((double) totalItems / size);
        if (totalPages == 0) totalPages = 1;

        // Đưa dữ liệu vào view
        model.addAttribute("itineraries", itineraries);
        model.addAttribute("tours", tourDAO.findAll());
        model.addAttribute("statuses", Itinerary.Status.values());

        // Dữ liệu phân trang & sắp xếp
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalItems", totalItems);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("sortDir", sortDir);

        // Giữ lại các bộ lọc đã chọn
        model.addAttribute("filterTourId", tourId);
        model.addAttribute("filterDayNumber", dayNumber);
        model.addAttribute("filterKeyword", keyword);
        model.addAttribute("filterStatus", statusStr);

        return "admin/itinerary/list";
    }

    // ─── TẠO MỚI ──────────────────────────────────────────────────────────────

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("itinerary", new Itinerary());
        model.addAttribute("tours", tourDAO.findAll());
        model.addAttribute("statuses", Itinerary.Status.values());
        return "admin/itinerary/create";
    }

    @PostMapping("/create")
    public String create(@ModelAttribute("itinerary") Itinerary itinerary,
                         @RequestParam(value = "statusStr", defaultValue = "ACTIVE") String statusStr,
                         Model model) {
        itinerary.setStatus(parseStatus(statusStr));

        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(itinerary, "itinerary");
        validateItinerary(itinerary, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.itinerary", bindingResult);
            model.addAttribute("tours", tourDAO.findAll());
            model.addAttribute("statuses", Itinerary.Status.values());
            return "admin/itinerary/create";
        }
        itineraryDAO.save(itinerary);
        return "redirect:/itinerary/list";
    }

    // ─── CHỈNH SỬA ────────────────────────────────────────────────────────────

    @GetMapping("/edit")
    public String editForm(@RequestParam int id, Model model) {
        Itinerary itinerary = itineraryDAO.findById(id);
        if (itinerary == null) {
            return "redirect:/itinerary/list";
        }
        model.addAttribute("itinerary", itinerary);
        model.addAttribute("tours", tourDAO.findAll());
        model.addAttribute("statuses", Itinerary.Status.values());
        return "admin/itinerary/edit";
    }

    @PostMapping("/edit")
    public String update(@ModelAttribute("itinerary") Itinerary itinerary,
                         @RequestParam(value = "statusStr", defaultValue = "ACTIVE") String statusStr,
                         Model model) {
        itinerary.setStatus(parseStatus(statusStr));

        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(itinerary, "itinerary");
        validateItinerary(itinerary, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.itinerary", bindingResult);
            model.addAttribute("tours", tourDAO.findAll());
            model.addAttribute("statuses", Itinerary.Status.values());
            return "admin/itinerary/edit";
        }
        itineraryDAO.update(itinerary);
        return "redirect:/itinerary/list";
    }

    // ─── XÓA ──────────────────────────────────────────────────────────────────

    @GetMapping("/delete")
    public String deleteConfirm(@RequestParam int id, Model model) {
        Itinerary itinerary = itineraryDAO.findById(id);
        if (itinerary == null) {
            return "redirect:/itinerary/list";
        }
        model.addAttribute("itinerary", itinerary);
        return "admin/itinerary/delete";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam int id) {
        itineraryDAO.delete(id);
        return "redirect:/itinerary/list";
    }

    // ─── HELPERS ──────────────────────────────────────────────────────────────

    private Itinerary.Status parseStatus(String statusStr) {
        try {
            return Itinerary.Status.valueOf(statusStr.toUpperCase());
        } catch (Exception e) {
            return Itinerary.Status.ACTIVE;
        }
    }

    private void validateItinerary(Itinerary itinerary, BeanPropertyBindingResult bindingResult) {
        if (itinerary.getTourId() <= 0) {
            bindingResult.rejectValue("tourId", "tourId.required", "Vui lòng chọn Tour du lịch");
        }
        if (itinerary.getDayNumber() <= 0) {
            bindingResult.rejectValue("dayNumber", "dayNumber.positive", "Số ngày hoạt động phải lớn hơn 0");
        }
        if (itinerary.getActivityDescription() == null || itinerary.getActivityDescription().trim().isEmpty()) {
            bindingResult.rejectValue("activityDescription", "activityDescription.required", "Mô tả hoạt động chi tiết không được để trống");
        }
    }
}
