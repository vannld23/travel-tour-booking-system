package uef.edu.vn.service;

import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.dao.PaymentDAO;
import uef.edu.vn.model.Booking;
import uef.edu.vn.model.Payment;

import java.sql.Timestamp;
import java.util.List;

public class PaymentService {

    private PaymentDAO paymentDAO = new PaymentDAO();

    private BookingDAO bookingDAO = new BookingDAO();

    public List<Payment> getAllPayments() {
        return paymentDAO.getAllPayments();
    }

    public Payment getPaymentById(int id) {
        return paymentDAO.getPaymentById(id);
    }

    public Payment getPaymentByBookingId(int bookingId) {
        return paymentDAO.getPaymentByBookingId(bookingId);
    }

    public boolean addPayment(Payment payment) {

        // Không cho tạo thanh toán trùng booking
        Payment existingPayment
                = paymentDAO.getPaymentByBookingId(
                        payment.getBookingId());

        if (existingPayment != null) {
            return false;
        }

        Booking booking
                = bookingDAO.getBookingById(
                        payment.getBookingId());

        if (booking != null) {

            payment.setAmount(
                    booking.getTotalPrice());

            payment.setPaymentDate(
                    new Timestamp(
                            System.currentTimeMillis()));

            payment.setPaymentStatus(
                    "PENDING");
        }

        return paymentDAO.addPayment(
                payment);
    }

    public boolean updatePayment(
            Payment payment) {

        return paymentDAO.updatePayment(
                payment);
    }

    public boolean confirmPayment(
            int paymentId) {

        return paymentDAO.updatePaymentStatus(
                paymentId,
                "PAID");
    }
}
