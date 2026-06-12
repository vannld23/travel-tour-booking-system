package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import uef.edu.vn.model.Booking;
import uef.edu.vn.service.BookingService;
import uef.edu.vn.service.UserService;
import uef.edu.vn.service.TourService;

@Controller
public class BookingController {

    private UserService userService = new UserService();

    private TourService tourService = new TourService();

    private BookingService bookingService = new BookingService();

    // =========================
    // LIST BOOKING
    // =========================
    @GetMapping("/bookings")
    public String getAllBookings(Model model) {

        model.addAttribute(
                "bookings",
                bookingService.getAllBookings()
        );

        return "booking/list";
    }

    // =========================
    // BOOKING DETAIL
    // =========================
    @GetMapping("/bookings/{id}")
    public String bookingDetail(
            @PathVariable("id") int id,
            Model model) {

        Booking booking
                = bookingService.getBookingById(id);

        model.addAttribute(
                "booking",
                booking
        );

        return "booking/detail";
    }

    // =========================
    // SHOW ADD FORM
    // =========================
    @GetMapping("/bookings/add")
    public String showAddForm(Model model) {

        model.addAttribute(
                "booking",
                new Booking()
        );

        model.addAttribute(
                "users",
                userService.getAllUsers()
        );

        model.addAttribute(
                "tours",
                tourService.getAllTours()
        );

        return "booking/add";
    }

    // =========================
    // ADD BOOKING
    // =========================
    @PostMapping("/bookings/add")
    public String addBooking(
            @ModelAttribute Booking booking) {

        bookingService.addBooking(booking);

        return "redirect:/bookings";
    }

    // =========================
    // SHOW EDIT FORM
    // =========================
    @GetMapping("/bookings/edit/{id}")
    public String showEditForm(
            @PathVariable("id") int id,
            Model model) {

        Booking booking
                = bookingService.getBookingById(id);

        model.addAttribute(
                "booking",
                booking
        );

        return "booking/edit";
    }

    // =========================
    // UPDATE BOOKING
    // =========================
    @PostMapping("/bookings/edit")
    public String updateBooking(
            @ModelAttribute Booking booking) {

        bookingService.updateBooking(
                booking
        );

        return "redirect:/bookings";
    }

    // =========================
    // DELETE BOOKING
    // =========================
    @GetMapping("/bookings/cancel/{id}")
    public String cancelBooking(
            @PathVariable("id") int id) {

        bookingService.cancelBooking(id);

        return "redirect:/bookings";
    }
}
