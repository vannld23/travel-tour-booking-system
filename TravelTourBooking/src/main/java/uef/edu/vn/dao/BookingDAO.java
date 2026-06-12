package uef.edu.vn.dao;

import uef.edu.vn.model.Booking;
import uef.edu.vn.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public List<Booking> getAllBookings() {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT * FROM bookings";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Booking booking = new Booking();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setTourId(rs.getInt("tour_id"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setNumberOfPeople(rs.getInt("number_of_people"));
                booking.setTotalPrice(rs.getDouble("total_price"));
                booking.setBookingStatus(rs.getString("booking_status"));

                bookings.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }
}