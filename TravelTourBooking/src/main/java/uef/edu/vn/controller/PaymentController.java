package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import uef.edu.vn.model.Payment;
import uef.edu.vn.service.PaymentService;
import uef.edu.vn.service.BookingService;

@Controller
public class PaymentController {

    private PaymentService paymentService = new PaymentService();

    private BookingService bookingService = new BookingService();

    // =========================
    // LIST PAYMENT
    // =========================
    @GetMapping("/payments")
    public String getAllPayments(Model model) {

        model.addAttribute(
                "payments",
                paymentService.getAllPayments()
        );

        return "payment/list";
    }

    // =========================
    // PAYMENT DETAIL
    // =========================
    @GetMapping("/payments/{id}")
    public String paymentDetail(
            @PathVariable("id") int id,
            Model model) {

        Payment payment
                = paymentService.getPaymentById(id);

        model.addAttribute(
                "payment",
                payment
        );

        return "payment/detail";
    }

    // =========================
    // SHOW ADD FORM
    // =========================
    @GetMapping("/payments/add")
    public String showAddForm(Model model) {

        model.addAttribute(
                "payment",
                new Payment()
        );

        model.addAttribute(
                "bookings",
                bookingService.getBookingsWithoutPayment()
        );

        return "payment/add";
    }

    // =========================
    // ADD PAYMENT
    // =========================
    @PostMapping("/payments/add")
    public String addPayment(
            @ModelAttribute Payment payment) {

        paymentService.addPayment(payment);

        return "redirect:/payments";
    }

    // =========================
    // CONFIRM PAYMENT
    // =========================
    @GetMapping("/payments/confirm/{id}")
    public String confirmPayment(
            @PathVariable("id") int id) {

        paymentService.confirmPayment(id);

        return "redirect:/payments";
    }
}
