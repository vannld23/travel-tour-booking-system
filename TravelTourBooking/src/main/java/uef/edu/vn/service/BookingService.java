package uef.edu.vn.service;

import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.model.Booking;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.model.Tour;
import uef.edu.vn.dao.PaymentDAO;
import uef.edu.vn.model.Payment;

import java.math.BigDecimal;
import java.util.List;

public class BookingService {

    private TourDAO tourDAO = new TourDAO();

    private BookingDAO bookingDAO = new BookingDAO();

    private PaymentDAO paymentDAO = new PaymentDAO();

    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }

    public Booking getBookingById(int id) {
        return bookingDAO.getBookingById(id);
    }

    public boolean addBooking(Booking booking) {

        // Sử dụng findById() thay vì getTourById() (đúng tên method của TourDAO)
        Tour tour = tourDAO.findById(booking.getTourId());

        if (tour != null && tour.getPrice() != null) {
            // BigDecimal không dùng * trực tiếp; phải dùng multiply()
            double totalPrice = tour.getPrice()
                    .multiply(BigDecimal.valueOf(booking.getNumberOfPeople()))
                    .doubleValue();
            booking.setTotalPrice(totalPrice);
        }

        return bookingDAO.addBooking(booking);
    }

    public boolean cancelBooking(int id) {
        return bookingDAO.cancelBooking(id);
    }

    public boolean updateBooking(Booking booking) {

        // Sử dụng findById() thay vì getTourById()
        Tour tour = tourDAO.findById(booking.getTourId());

        if (tour != null && tour.getPrice() != null) {
            double totalPrice = tour.getPrice()
                    .multiply(BigDecimal.valueOf(booking.getNumberOfPeople()))
                    .doubleValue();
            booking.setTotalPrice(totalPrice);
        }

        boolean updated = bookingDAO.updateBooking(booking);

        if (updated) {
            Payment payment = paymentDAO.getPaymentByBookingId(booking.getBookingId());

            if (payment != null && "PENDING".equals(payment.getPaymentStatus())) {
                paymentDAO.updatePaymentAmount(booking.getBookingId(), booking.getTotalPrice());
            }
        }

        return updated;
    }

    public List<Booking> getBookingsWithoutPayment() {
        return bookingDAO.getBookingsWithoutPayment();
    }

    public boolean updateBookingStatus(int bookingId, String status) {
        return bookingDAO.updateBookingStatus(bookingId, status);
    }

    /**
     * Admin xác nhận booking (PENDING → CONFIRMED).
     * Yêu cầu: booking đang PENDING.
     * Ghi chú: kiểm tra thanh toán là trách nhiệm của admin trước khi bấm nút.
     *
     * @return true nếu thành công, false nếu booking không đúng trạng thái
     */
    public boolean confirmBooking(int bookingId) {
        Booking booking = bookingDAO.getBookingById(bookingId);
        if (booking == null || !"PENDING".equals(booking.getBookingStatus())) {
            return false;
        }
        return bookingDAO.updateBookingStatus(bookingId, "CONFIRMED");
    }

    /**
     * Admin đánh dấu tour đã hoàn thành (CONFIRMED → COMPLETED).
     * Chỉ áp dụng khi booking đang ở trạng thái CONFIRMED.
     *
     * @return true nếu thành công, false nếu booking không đúng trạng thái
     */
    public boolean completeBooking(int bookingId) {
        Booking booking = bookingDAO.getBookingById(bookingId);
        if (booking == null || !"CONFIRMED".equals(booking.getBookingStatus())) {
            return false;
        }
        return bookingDAO.updateBookingStatus(bookingId, "COMPLETED");
    }
}
