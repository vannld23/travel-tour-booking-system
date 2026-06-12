package uef.edu.vn.test;

import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.model.Booking;

import java.util.List;

public class BookingDAOTest {

    public static void main(String[] args) {

        BookingDAO bookingDAO = new BookingDAO();

        List<Booking> bookings = bookingDAO.getAllBookings();

        System.out.println("So booking: " + bookings.size());

        for (Booking booking : bookings) {

            System.out.println(
                    booking.getBookingId()
                    + " | "
                    + booking.getUserId()
                    + " | "
                    + booking.getTourId()
                    + " | "
                    + booking.getBookingStatus()
            );
        }
    }
}
