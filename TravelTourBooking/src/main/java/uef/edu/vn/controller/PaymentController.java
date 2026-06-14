package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import uef.edu.vn.model.Payment;
import uef.edu.vn.service.PaymentService;
import uef.edu.vn.service.BookingService;
import jakarta.servlet.http.HttpSession;
import uef.edu.vn.model.User;

/**
 * Controller quản lý thanh toán (Payment).
 */
@Controller
@RequestMapping("/payment")
public class PaymentController {

    private final PaymentService paymentService = new PaymentService();
    private final BookingService bookingService = new BookingService();

    // ── Root redirect ────────────────────────────────────────────────────────
    @GetMapping({"", "/"})
    public String root() {
        return "redirect:/payment/list";
    }

    // =========================
    // LIST PAYMENT
    // =========================
    @GetMapping("/list")
    public String getAllPayments(Model model) {
        model.addAttribute("payments", paymentService.getAllPayments());
        return "admin/payment/list";
    }

    // =========================
    // PAYMENT DETAIL
    // =========================
    @GetMapping("/detail/{id}")
    public String paymentDetail(
            @PathVariable("id") int id,
            Model model) {

        Payment payment = paymentService.getPaymentById(id);
        model.addAttribute("payment", payment);

        return "admin/payment/detail";
    }

    // =========================
    // SHOW ADD FORM
    // =========================
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("payment", new Payment());
        model.addAttribute("bookings", bookingService.getBookingsWithoutPayment());
        return "admin/payment/add";
    }

    // =========================
    // ADD PAYMENT
    // =========================
    @PostMapping("/add")
    public String addPayment(
            @ModelAttribute Payment payment) {

        System.out.println("===== CREATE PAYMENT =====");
        System.out.println("BOOKING ID = " + payment.getBookingId());
        System.out.println("METHOD = " + payment.getPaymentMethod());

        boolean result
                = paymentService.addPayment(payment);

        System.out.println("RESULT = " + result);

        return "redirect:/payment/list";
    }

    @GetMapping("/history")
    public String paymentHistory(
            HttpSession session,
            Model model) {

        User currentUser
                = (User) session.getAttribute(
                        "currentUser");

        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute(
                "payments",
                paymentService.getPaymentsByUserId(
                        currentUser.getUserId()));

        return "client/payment/history";
    }

    @GetMapping("/history/detail/{id}")
    public String paymentDetailClient(
            @PathVariable("id") int id,
            Model model) {

        Payment payment
                = paymentService.getPaymentById(id);

        if (payment == null) {
            return "redirect:/payment/history";
        }

        model.addAttribute(
                "payment",
                payment);

        return "client/payment/detail";
    }
    // =========================
// CONFIRM PAYMENT
// =========================

    @GetMapping("/confirm/{id}")
    public String confirmPayment(
            @PathVariable("id") int id) {

        paymentService.confirmPayment(id);

        return "redirect:/payment/list";
    }
}
