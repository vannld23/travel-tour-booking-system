package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uef.edu.vn.dao.DestinationDAO;
import uef.edu.vn.model.Destination;

/**
 * Controller quản lý điểm đến (Destination).
 * Bổ sung: tìm kiếm, lọc theo quốc gia/thành phố/trạng thái, hỗ trợ tạo/sửa có trường status.
 */
@Controller
@RequestMapping("/destination")
public class DestinationController {

    private final DestinationDAO destinationDAO = new DestinationDAO();

    // ─── LIST + SEARCH ────────────────────────────────────────────────────────

    /**
     * Hiển thị danh sách điểm đến. Nếu có tham số tìm kiếm thì lọc kết quả.
     *
     * @param keyword  từ khóa tìm kiếm (nullable)
     * @param country  quốc gia cần lọc  (nullable)
     * @param city     thành phố cần lọc (nullable)
     * @param status   trạng thái cần lọc (nullable — tên enum ACTIVE/INACTIVE/UPCOMING)
     */
    @GetMapping({"", "/", "/list"})
    public String list(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "country",  required = false) String country,
            @RequestParam(value = "city",     required = false) String city,
            @RequestParam(value = "status",   required = false) String statusStr,
            Model model) {

        // Kiểm tra có bộ lọc nào không
        boolean hasFilter = isNotBlank(keyword) || isNotBlank(country) || isNotBlank(city) || isNotBlank(statusStr);

        // Parse status string thành enum (an toàn)
        Destination.Status statusFilter = null;
        if (isNotBlank(statusStr)) {
            try {
                statusFilter = Destination.Status.valueOf(statusStr.toUpperCase());
            } catch (IllegalArgumentException ignored) {
                // Giá trị không hợp lệ → bỏ qua, lấy tất cả
            }
        }

        // Lấy danh sách destinations theo điều kiện lọc
        var destinations = hasFilter
                ? destinationDAO.search(keyword, country, city, statusFilter)
                : destinationDAO.findAll();

        // Đổ dữ liệu vào Model để JSP dùng
        model.addAttribute("destinations",  destinations);
        model.addAttribute("countries",     destinationDAO.findAllCountries()); // dropdown filter quốc gia
        model.addAttribute("statuses",      Destination.Status.values());       // dropdown filter trạng thái

        // Giữ lại giá trị filter để pre-fill ô tìm kiếm
        model.addAttribute("filterKeyword", keyword);
        model.addAttribute("filterCountry", country);
        model.addAttribute("filterCity",    city);
        model.addAttribute("filterStatus",  statusStr);

        return "destination/list";
    }

    // ─── CREATE ───────────────────────────────────────────────────────────────

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("destination", new Destination());
        model.addAttribute("statuses",    Destination.Status.values());
        return "destination/create";
    }

    @PostMapping("/create")
    public String create(@ModelAttribute("destination") Destination destination,
                         @RequestParam(value = "statusStr", required = false, defaultValue = "ACTIVE") String statusStr,
                         Model model) {
        // Bind status từ form string sang enum
        destination.setStatus(parseStatus(statusStr));

        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(destination, "destination");
        validateDestination(destination, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.destination", bindingResult);
            model.addAttribute("statuses", Destination.Status.values());
            return "destination/create";
        }
        destinationDAO.save(destination);
        return "redirect:/destination/list";
    }

    // ─── EDIT ─────────────────────────────────────────────────────────────────

    @GetMapping("/edit")
    public String editForm(@RequestParam int id, Model model) {
        Destination destination = destinationDAO.findById(id);
        if (destination == null) {
            return "redirect:/destination/list";
        }
        model.addAttribute("destination", destination);
        model.addAttribute("statuses",    Destination.Status.values());
        return "destination/edit";
    }

    @PostMapping("/edit")
    public String update(@ModelAttribute("destination") Destination destination,
                         @RequestParam(value = "statusStr", required = false, defaultValue = "ACTIVE") String statusStr,
                         Model model) {
        destination.setStatus(parseStatus(statusStr));

        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(destination, "destination");
        validateDestination(destination, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.destination", bindingResult);
            model.addAttribute("statuses", Destination.Status.values());
            return "destination/edit";
        }
        destinationDAO.update(destination);
        return "redirect:/destination/list";
    }

    // ─── DETAIL ───────────────────────────────────────────────────────────────

    @GetMapping("/detail")
    public String detail(@RequestParam int id, Model model) {
        Destination destination = destinationDAO.findById(id);
        if (destination == null) {
            return "redirect:/destination/list";
        }
        model.addAttribute("destination", destination);
        return "destination/detail";
    }

    // ─── DELETE ───────────────────────────────────────────────────────────────

    @GetMapping("/delete")
    public String deleteConfirm(@RequestParam int id, Model model) {
        Destination destination = destinationDAO.findById(id);
        if (destination == null) {
            return "redirect:/destination/list";
        }
        model.addAttribute("destination", destination);
        return "destination/delete";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam int id) {
        destinationDAO.delete(id);
        return "redirect:/destination/list";
    }

    // ─── Helpers ──────────────────────────────────────────────────────────────

    private void validateDestination(Destination destination, BeanPropertyBindingResult bindingResult) {
        if (destination.getDestinationName() == null || destination.getDestinationName().trim().isEmpty()) {
            bindingResult.rejectValue("destinationName", "destinationName.required", "Tên điểm đến là bắt buộc");
        }
        if (destination.getCountry() == null || destination.getCountry().trim().isEmpty()) {
            bindingResult.rejectValue("country", "country.required", "Quốc gia là bắt buộc");
        }
    }

    private Destination.Status parseStatus(String raw) {
        if (raw == null || raw.isBlank()) return Destination.Status.ACTIVE;
        try {
            return Destination.Status.valueOf(raw.toUpperCase());
        } catch (IllegalArgumentException e) {
            return Destination.Status.ACTIVE;
        }
    }

    private boolean isNotBlank(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
