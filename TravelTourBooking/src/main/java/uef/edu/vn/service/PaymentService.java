/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.service;

import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.dao.PaymentDAO;
import uef.edu.vn.model.Booking;
import uef.edu.vn.model.Payment;

import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author LENOVO
 */
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

        Payment payment
                = paymentDAO.getPaymentById(
                        paymentId);

        if (payment == null) {
            return false;
        }

        // Không xác nhận lại nếu đã PAID
        if ("PAID".equals(
                payment.getPaymentStatus())) {

            return false;
        }

        boolean paymentUpdated
                = paymentDAO.updatePaymentStatus(
                        paymentId,
                        "PAID");

        if (paymentUpdated) {

            bookingDAO.updateBookingStatus(
                    payment.getBookingId(),
                    "CONFIRMED");
        }

        return paymentUpdated;
    }
}
