package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import uef.edu.vn.model.Booking;
import uef.edu.vn.service.BookingService;
import uef.edu.vn.service.UserService;
import uef.edu.vn.service.TourService;
import uef.edu.vn.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;
import uef.edu.vn.model.User;
import uef.edu.vn.model.Tour;

/**
 * Controller quản lý đặt chỗ (Booking).
 *
 * Luồng trạng thái: PENDING → admin xác nhận (sau khi khách đã thanh toán) →
 * CONFIRMED CONFIRMED → admin đánh dấu hoàn thành (tour đã đi xong) → COMPLETED
 * PENDING / CONFIRMED → admin/khách hủy → CANCELLED CANCELLED → không tương tác
 * thêm
 */
@Controller
@RequestMapping("/booking")
public class BookingController {

    private final UserService userService = new UserService();
    private final TourService tourService = new TourService();
    private final BookingService bookingService = new BookingService();
    private final EmailService emailService = new EmailService();

    // ── Root redirect ────────────────────────────────────────────────────────
    @GetMapping({"", "/"})
    public String root() {
        return "redirect:/booking/list";
    }

    // ── ADMIN: Danh sách tất cả booking ─────────────────────────────────────
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("bookings", bookingService.getAllBookings());
        return "admin/booking/list";
    }

    // ── ADMIN: Chi tiết booking ──────────────────────────────────────────────
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") int id, Model model) {
        model.addAttribute("booking", bookingService.getBookingById(id));
        return "admin/booking/detail";
    }

    // ── ADMIN: Xác nhận booking PENDING → CONFIRMED ──────────────────────────
    // Điều kiện: khách đã thanh toán, admin bấm xác nhận
    @GetMapping("/confirm/{id}")
    public String confirm(@PathVariable("id") int id) {
        bookingService.confirmBooking(id);           // guard: chỉ đổi nếu đang PENDING
        return "redirect:/booking/list";
    }

    // ── ADMIN: Hoàn thành tour CONFIRMED → COMPLETED ─────────────────────────
    // Điều kiện: tour đã kết thúc thực tế
    @GetMapping("/complete/{id}")
    public String complete(@PathVariable("id") int id) {
        bookingService.completeBooking(id);          // guard: chỉ đổi nếu đang CONFIRMED
        return "redirect:/booking/list";
    }

    // ── ADMIN/CLIENT: Hủy booking ────────────────────────────────────────────
    // Chỉ hủy được khi đang PENDING (hoặc CONFIRMED nếu admin cho phép)
    @GetMapping("/cancel/{id}")
    public String cancel(@PathVariable("id") int id) {

        Booking booking = bookingService.getBookingById(id);

        if (booking != null
                && "PENDING".equals(
                        booking.getBookingStatus())) {

            bookingService.cancelBooking(id);
        }

        return "redirect:/booking/list";
    }

    // ── ADMIN: Sửa thông tin booking (chỉ khi PENDING) ───────────────────────
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") int id, Model model) {
        Booking booking = bookingService.getBookingById(id);
        if (booking == null || !"PENDING".equals(booking.getBookingStatus())) {
            return "redirect:/booking/list";
        }
        model.addAttribute("booking", booking);
        model.addAttribute("tours", tourService.getAllTours());
        return "admin/booking/edit";
    }

    @PostMapping("/edit")
    public String edit(@ModelAttribute Booking booking) {
        Booking old = bookingService.getBookingById(booking.getBookingId());
        if (old == null || !"PENDING".equals(old.getBookingStatus())) {
            return "redirect:/booking/list";
        }
        booking.setBookingStatus(old.getBookingStatus());
        bookingService.updateBooking(booking);
        return "redirect:/booking/detail/" + booking.getBookingId();
    }

    @GetMapping("/history")
    public String bookingHistory(
            HttpSession session,
            Model model) {

        User currentUser
                = (User) session.getAttribute(
                        "currentUser");

        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute(
                "bookings",
                bookingService.getBookingsByUserId(
                        currentUser.getUserId()));

        return "client/booking/history";
    }

    @GetMapping("/history/detail/{id}")
    public String clientBookingDetail(
            @PathVariable("id") int id,
            Model model) {

        Booking booking
                = bookingService.getBookingById(id);

        if (booking == null) {
            return "redirect:/booking/history";
        }

        model.addAttribute(
                "booking",
                booking);

        return "client/booking/detail";
    }

    @GetMapping("/create")
    public String showCreateForm(
            @RequestParam(required = false) Integer tourId,
            @RequestParam(required = false) String error,
            HttpSession session,
            Model model) {

        User currentUser
                = (User) session.getAttribute(
                        "currentUser");

        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute(
                "booking",
                new Booking());
        model.addAttribute(
                "error",
                error);

        model.addAttribute(
                "tours",
                tourService.getAllTours());

        if (tourId != null) {

            Tour selectedTour
                    = tourService.getTourById(
                            tourId);

            model.addAttribute(
                    "selectedTour",
                    selectedTour);

            model.addAttribute(
                    "relatedTours",
                    tourService.getAllTours());
            model.addAttribute(
                    "remainingSlots",
                    bookingService.getRemainingSlots(
                            tourId));
        }

        return "client/booking/create";
    }

    @PostMapping("/create")
    public String create(
            @ModelAttribute Booking booking,
            HttpSession session) {

        User currentUser
                = (User) session.getAttribute(
                        "currentUser");

        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        booking.setUserId(
                currentUser.getUserId());

        boolean result
                = bookingService.addBooking(
                        booking);

        if (!result) {
            return "redirect:/booking/create?tourId="
                    + booking.getTourId()
                    + "&error=full";
        }

        // Gui email xac nhan dat tour
        try {
            Booking created = bookingService.getBookingsByUserId(currentUser.getUserId())
                    .stream()
                    .filter(b -> b.getTourId() == booking.getTourId())
                    .findFirst().orElse(null);
            if (created != null) {
                emailService.sendBookingConfirmation(created, currentUser.getEmail());
            }
        } catch (Exception e) {
            System.err.println("[BookingController] Email error: " + e.getMessage());
        }

        return "redirect:/booking/history";
    }
    // ── ADMIN: Form tạo booking ─────────────────────

    @GetMapping("/admin/create")
    public String adminCreateForm(
            Model model) {

        model.addAttribute(
                "booking",
                new Booking());

        model.addAttribute(
                "users",
                userService.getAllUsers());

        model.addAttribute(
                "tours",
                tourService.getAllTours());

        return "admin/booking/create";
    }

    @PostMapping("/admin/create")
    public String adminCreate(
            @ModelAttribute Booking booking) {

        boolean result = bookingService.addBooking(booking);
        if (!result) {
            return "redirect:/booking/list?error=full";
        }

        return "redirect:/booking/list";
    }
}
