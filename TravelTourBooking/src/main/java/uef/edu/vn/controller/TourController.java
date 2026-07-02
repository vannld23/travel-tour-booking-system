package uef.edu.vn.controller;

import java.math.BigDecimal;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uef.edu.vn.dao.DestinationDAO;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.model.Tour;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.UUID;

/**
 * Controller điều hướng các request liên quan đến Quản lý Tour.
 * Hỗ trợ bộ lọc tìm kiếm nâng cao, phân trang (pagination) và sắp xếp (sorting).
 */
@Controller
@RequestMapping("/tuormanagement")
public class TourController {

    private final TourDAO tourDAO = new TourDAO();
    private final DestinationDAO destinationDAO = new DestinationDAO();

    // ─── DANH SÁCH + TÌM KIẾM + PHÂN TRANG + SẮP XẾP ──────────────────────────

    @GetMapping({"", "/", "/list"})
    public String list(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "destinationId", required = false) Integer destinationId,
            @RequestParam(value = "maxPrice", required = false) BigDecimal maxPrice,
            @RequestParam(value = "maxDurationDays", required = false) Integer maxDurationDays,
            @RequestParam(value = "status", required = false) String statusStr,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            @RequestParam(value = "sortBy", defaultValue = "tourName") String sortBy,
            @RequestParam(value = "sortDir", defaultValue = "ASC") String sortDir,
            Model model) {

        // Phân tích trạng thái enum an toàn
        Tour.Status statusFilter = null;
        if (statusStr != null && !statusStr.isBlank()) {
            try {
                statusFilter = Tour.Status.valueOf(statusStr.toUpperCase());
            } catch (IllegalArgumentException ignored) {}
        }

        // Đảm bảo chỉ số phân trang hợp lệ
        if (page < 1) page = 1;
        if (size < 1) size = 5;
        int offset = (page - 1) * size;

        // Thực hiện truy vấn danh sách & đếm tổng số dòng
        List<Tour> tours = tourDAO.search(keyword, destinationId, maxPrice, maxDurationDays, statusFilter, sortBy, sortDir, size, offset);
        int totalItems = tourDAO.count(keyword, destinationId, maxPrice, maxDurationDays, statusFilter);
        int totalPages = (int) Math.ceil((double) totalItems / size);
        if (totalPages == 0) totalPages = 1;

        // Truyền các bộ dữ liệu cho view
        model.addAttribute("tours", tours);
        model.addAttribute("destinations", destinationDAO.findAll());
        model.addAttribute("statuses", Tour.Status.values());

        // Truyền trạng thái phân trang & sắp xếp
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalItems", totalItems);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("sortDir", sortDir);

        // Giữ lại các bộ lọc đã chọn
        model.addAttribute("filterKeyword", keyword);
        model.addAttribute("filterDestinationId", destinationId);
        model.addAttribute("filterMaxPrice", maxPrice);
        model.addAttribute("filterMaxDurationDays", maxDurationDays);
        model.addAttribute("filterStatus", statusStr);

        return "admin/tour/list";
    }

    // ─── TẠO MỚI ──────────────────────────────────────────────────────────────

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("tour", new Tour());
        model.addAttribute("destinations", destinationDAO.findAll());
        model.addAttribute("statuses", Tour.Status.values());
        return "admin/tour/create";
    }

    @PostMapping("/create")
    public String create(@ModelAttribute("tour") Tour tour,
                         @RequestParam(value = "statusStr", defaultValue = "ACTIVE") String statusStr,
                         @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                         HttpServletRequest request,
                         Model model) {
        tour.setStatus(parseStatus(statusStr));

        // Xu ly upload file anh
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String uploadDir = request.getServletContext().getRealPath("/resources/images/tours");
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                String originalFilename = imageFile.getOriginalFilename();
                String ext = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    ext = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String filename = UUID.randomUUID().toString() + ext;
                File serverFile = new File(dir, filename);
                imageFile.transferTo(serverFile);
                
                // Thiet lap duong dan den file anh moi upload
                tour.setImageUrl(request.getContextPath() + "/resources/images/tours/" + filename);
            } catch (Exception e) {
                System.err.println("[TourController] Upload error: " + e.getMessage());
            }
        }

        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(tour, "tour");
        validateTour(tour, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.tour", bindingResult);
            model.addAttribute("destinations", destinationDAO.findAll());
            model.addAttribute("statuses", Tour.Status.values());
            return "admin/tour/create";
        }
        tourDAO.save(tour);
        return "redirect:/tuormanagement/list";
    }

    // ─── CHỈNH SỬA ────────────────────────────────────────────────────────────

    @GetMapping("/edit")
    public String editForm(@RequestParam int id, Model model) {
        Tour tour = tourDAO.findById(id);
        if (tour == null) {
            return "redirect:/tuormanagement/list";
        }
        model.addAttribute("tour", tour);
        model.addAttribute("destinations", destinationDAO.findAll());
        model.addAttribute("statuses", Tour.Status.values());
        return "admin/tour/edit";
    }

    @PostMapping("/edit")
    public String update(@ModelAttribute("tour") Tour tour,
                         @RequestParam(value = "statusStr", defaultValue = "ACTIVE") String statusStr,
                         @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                         HttpServletRequest request,
                         Model model) {
        tour.setStatus(parseStatus(statusStr));

        // Xu ly upload file anh khi edit
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String uploadDir = request.getServletContext().getRealPath("/resources/images/tours");
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                String originalFilename = imageFile.getOriginalFilename();
                String ext = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    ext = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String filename = UUID.randomUUID().toString() + ext;
                File serverFile = new File(dir, filename);
                imageFile.transferTo(serverFile);
                
                // Cap nhat duong dan moi
                tour.setImageUrl(request.getContextPath() + "/resources/images/tours/" + filename);
            } catch (Exception e) {
                System.err.println("[TourController] Edit upload error: " + e.getMessage());
            }
        }

        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(tour, "tour");
        validateTour(tour, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.tour", bindingResult);
            model.addAttribute("destinations", destinationDAO.findAll());
            model.addAttribute("statuses", Tour.Status.values());
            return "admin/tour/edit";
        }
        tourDAO.update(tour);
        return "redirect:/tuormanagement/list";
    }

    // ─── CHI TIẾT ─────────────────────────────────────────────────────────────

    @GetMapping("/detail")
    public String detail(@RequestParam int id, Model model) {
        Tour tour = tourDAO.findById(id);
        if (tour == null) {
            return "redirect:/tuormanagement/list";
        }
        model.addAttribute("tour", tour);
        model.addAttribute("itineraries", new uef.edu.vn.dao.ItineraryDAO().findByTourId(id));
        return "admin/tour/detail";
    }

    // ─── XÓA ──────────────────────────────────────────────────────────────────

    @GetMapping("/delete")
    public String deleteConfirm(@RequestParam int id, Model model) {
        Tour tour = tourDAO.findById(id);
        if (tour == null) {
            return "redirect:/tuormanagement/list";
        }
        model.addAttribute("tour", tour);
        return "admin/tour/delete";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam int id) {
        tourDAO.delete(id);
        return "redirect:/tuormanagement/list";
    }

    // ─── HELPERS ──────────────────────────────────────────────────────────────

    private Tour.Status parseStatus(String statusStr) {
        try {
            return Tour.Status.valueOf(statusStr.toUpperCase());
        } catch (Exception e) {
            return Tour.Status.ACTIVE;
        }
    }

    private void validateTour(Tour tour, BeanPropertyBindingResult bindingResult) {
        if (tour.getTourName() == null || tour.getTourName().trim().isEmpty()) {
            bindingResult.rejectValue("tourName", "tourName.required", "Tên tour không được để trống");
        }
        if (tour.getDestinationId() <= 0) {
            bindingResult.rejectValue("destinationId", "destinationId.required", "Điểm đến là bắt buộc");
        }
        if (tour.getDurationDays() <= 0) {
            bindingResult.rejectValue("durationDays", "durationDays.positive", "Thời lượng phải lớn hơn 0 ngày");
        }
        BigDecimal price = tour.getPrice();
        if (price == null) {
            bindingResult.rejectValue("price", "price.required", "Giá tour là bắt buộc");
        } else if (price.compareTo(BigDecimal.ZERO) < 0) {
            bindingResult.rejectValue("price", "price.min", "Giá tour không thể âm");
        }
        if (tour.getMaxCapacity() <= 0) {
            bindingResult.rejectValue("maxCapacity", "maxCapacity.positive", "Sức chứa tối đa phải lớn hơn 0");
        }
        if (tour.getStartDate() != null && tour.getEndDate() != null) {
            if (tour.getStartDate().after(tour.getEndDate())) {
                bindingResult.rejectValue("startDate", "startDate.invalid", "Ngày bắt đầu phải trước hoặc trùng ngày kết thúc");
            }
        }
    }
}
