package uef.edu.vn.service;

import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.model.Booking;

import java.util.List;

public class BookingService {

    private BookingDAO bookingDAO = new BookingDAO();

    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }

    public Booking getBookingById(int id) {
        return bookingDAO.getBookingById(id);
    }

    public boolean addBooking(Booking booking) {
        return bookingDAO.addBooking(booking);
    }

    public boolean cancelBooking(int id) {

        return bookingDAO.cancelBooking(id);
    }

    public boolean updateBooking(
            Booking booking) {

        return bookingDAO.updateBooking(
                booking);
    }
}
