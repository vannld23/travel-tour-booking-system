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

        String sql
                = "SELECT b.*, "
                + "u.full_name, "
                + "t.tour_name "
                + "FROM bookings b "
                + "JOIN users u "
                + "ON b.user_id = u.user_id "
                + "JOIN tours t "
                + "ON b.tour_id = t.tour_id";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Booking booking = new Booking();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setTourId(rs.getInt("tour_id"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setNumberOfPeople(rs.getInt("number_of_people"));
                booking.setTotalPrice(rs.getDouble("total_price"));
                booking.setBookingStatus(rs.getString("booking_status"));

                booking.setFullName(
                        rs.getString("full_name"));

                booking.setTourName(
                        rs.getString("tour_name"));

                bookings.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }

    public Booking getBookingById(int bookingId) {

        String sql
                = "SELECT b.*, "
                + "u.full_name, "
                + "t.tour_name "
                + "FROM bookings b "
                + "JOIN users u "
                + "ON b.user_id = u.user_id "
                + "JOIN tours t "
                + "ON b.tour_id = t.tour_id "
                + "WHERE b.booking_id = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Booking booking = new Booking();

                booking.setBookingId(
                        rs.getInt("booking_id"));

                booking.setUserId(
                        rs.getInt("user_id"));

                booking.setTourId(
                        rs.getInt("tour_id"));

                booking.setBookingDate(
                        rs.getTimestamp("booking_date"));

                booking.setNumberOfPeople(
                        rs.getInt("number_of_people"));

                booking.setTotalPrice(
                        rs.getDouble("total_price"));

                booking.setBookingStatus(
                        rs.getString("booking_status"));

                booking.setFullName(
                        rs.getString("full_name"));

                booking.setTourName(
                        rs.getString("tour_name"));

                return booking;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addBooking(Booking booking) {

        String sql = "INSERT INTO bookings "
                + "(user_id, tour_id, booking_date, "
                + "number_of_people, total_price, booking_status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, booking.getUserId());

            ps.setInt(2, booking.getTourId());

            ps.setTimestamp(
                    3,
                    new java.sql.Timestamp(
                            System.currentTimeMillis()
                    )
            );

            ps.setInt(
                    4,
                    booking.getNumberOfPeople()
            );

            ps.setDouble(
                    5,
                    booking.getTotalPrice()
            );

            ps.setString(
                    6,
                    "PENDING"
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean cancelBooking(int bookingId) {

        String sql
                = "UPDATE bookings "
                + "SET booking_status = 'CANCELLED' "
                + "WHERE booking_id = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateBooking(Booking booking) {

        String sql
                = "UPDATE bookings "
                + "SET number_of_people = ?, "
                + "total_price = ?, "
                + "booking_status = ? "
                + "WHERE booking_id = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(
                    1,
                    booking.getNumberOfPeople()
            );

            ps.setDouble(
                    2,
                    booking.getTotalPrice()
            );

            ps.setString(
                    3,
                    booking.getBookingStatus()
            );

            ps.setInt(
                    4,
                    booking.getBookingId()
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
