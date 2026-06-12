package uef.edu.vn.service;

import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.model.Booking;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.model.Tour;

import java.util.List;

public class BookingService {

    private TourDAO tourDAO = new TourDAO();

    private BookingDAO bookingDAO = new BookingDAO();

    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }

    public Booking getBookingById(int id) {
        return bookingDAO.getBookingById(id);
    }

    public boolean addBooking(Booking booking) {

        Tour tour
                = tourDAO.getTourById(
                        booking.getTourId()
                );

        if (tour != null) {

            double totalPrice
                    = tour.getPrice()
                    * booking.getNumberOfPeople();

            booking.setTotalPrice(
                    totalPrice
            );
        }

        return bookingDAO.addBooking(
                booking
        );
    }

    public boolean cancelBooking(int id) {

        return bookingDAO.cancelBooking(id);
    }

    public boolean updateBooking(
            Booking booking) {

        Tour tour
                = tourDAO.getTourById(
                        booking.getTourId()
                );

        if (tour != null) {

            double totalPrice
                    = tour.getPrice()
                    * booking.getNumberOfPeople();

            booking.setTotalPrice(
                    totalPrice
            );
        }

        return bookingDAO.updateBooking(
                booking);
    }
}
