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
import jakarta.servlet.http.HttpSession;
import uef.edu.vn.model.User;

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
    public String bookingHistory(Model model) {

        model.addAttribute(
                "bookings",
                bookingService.getAllBookings());

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
    public String showCreateForm(Model model) {

        model.addAttribute(
                "booking",
                new Booking());

        model.addAttribute(
                "tours",
                tourService.getAllTours());

        return "client/booking/create";
    }

    @PostMapping("/create")
    public String create(
            @ModelAttribute Booking booking) {

        // User test tạm
        booking.setUserId(2);

        bookingService.addBooking(
                booking);

        return "redirect:/booking/history";
    }
}
