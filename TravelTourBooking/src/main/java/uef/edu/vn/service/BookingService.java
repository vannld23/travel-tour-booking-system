package uef.edu.vn.service;

import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.model.Booking;

import java.util.List;

public class BookingService {

    private BookingDAO bookingDAO = new BookingDAO();

    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }
}
