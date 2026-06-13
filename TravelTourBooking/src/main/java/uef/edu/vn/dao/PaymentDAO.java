/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.dao;

import uef.edu.vn.model.Payment;
import uef.edu.vn.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class PaymentDAO {

    public List<Payment> getAllPayments() {

        List<Payment> payments = new ArrayList<>();

        String sql
                = "SELECT p.*, "
                + "u.full_name, "
                + "t.tour_name "
                + "FROM payments p "
                + "JOIN bookings b "
                + "ON p.booking_id = b.booking_id "
                + "JOIN users u "
                + "ON b.user_id = u.user_id "
                + "JOIN tours t "
                + "ON b.tour_id = t.tour_id";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Payment payment = new Payment();

                payment.setPaymentId(
                        rs.getInt("payment_id"));

                payment.setBookingId(
                        rs.getInt("booking_id"));

                payment.setAmount(
                        rs.getDouble("amount"));

                payment.setPaymentMethod(
                        rs.getString("payment_method"));

                payment.setPaymentDate(
                        rs.getTimestamp("payment_date"));

                payment.setPaymentStatus(
                        rs.getString("payment_status"));

                payment.setFullName(
                        rs.getString("full_name"));

                payment.setTourName(
                        rs.getString("tour_name"));

                payments.add(payment);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return payments;
    }

    public Payment getPaymentById(int paymentId) {

        String sql
                = "SELECT p.*, "
                + "u.full_name, "
                + "t.tour_name "
                + "FROM payments p "
                + "JOIN bookings b "
                + "ON p.booking_id = b.booking_id "
                + "JOIN users u "
                + "ON b.user_id = u.user_id "
                + "JOIN tours t "
                + "ON b.tour_id = t.tour_id "
                + "WHERE p.payment_id = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, paymentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Payment payment = new Payment();

                payment.setPaymentId(
                        rs.getInt("payment_id"));

                payment.setBookingId(
                        rs.getInt("booking_id"));

                payment.setAmount(
                        rs.getDouble("amount"));

                payment.setPaymentMethod(
                        rs.getString("payment_method"));

                payment.setPaymentDate(
                        rs.getTimestamp("payment_date"));

                payment.setPaymentStatus(
                        rs.getString("payment_status"));

                payment.setFullName(
                        rs.getString("full_name"));

                payment.setTourName(
                        rs.getString("tour_name"));

                return payment;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public Payment getPaymentByBookingId(int bookingId) {

        String sql
                = "SELECT * "
                + "FROM payments "
                + "WHERE booking_id = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Payment payment = new Payment();

                payment.setPaymentId(
                        rs.getInt("payment_id"));

                payment.setBookingId(
                        rs.getInt("booking_id"));

                payment.setAmount(
                        rs.getDouble("amount"));

                payment.setPaymentMethod(
                        rs.getString("payment_method"));

                payment.setPaymentDate(
                        rs.getTimestamp("payment_date"));

                payment.setPaymentStatus(
                        rs.getString("payment_status"));

                return payment;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addPayment(Payment payment) {

        String sql
                = "INSERT INTO payments "
                + "(booking_id, amount, payment_method, "
                + "payment_date, payment_status) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(
                    1,
                    payment.getBookingId());

            ps.setDouble(
                    2,
                    payment.getAmount());

            ps.setString(
                    3,
                    payment.getPaymentMethod());

            ps.setTimestamp(
                    4,
                    payment.getPaymentDate());

            ps.setString(
                    5,
                    payment.getPaymentStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updatePayment(Payment payment) {

        String sql
                = "UPDATE payments "
                + "SET payment_method = ?, "
                + "payment_status = ? "
                + "WHERE payment_id = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(
                    1,
                    payment.getPaymentMethod());

            ps.setString(
                    2,
                    payment.getPaymentStatus());

            ps.setInt(
                    3,
                    payment.getPaymentId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updatePaymentStatus(int paymentId, String status) {

        String sql
                = "UPDATE payments "
                + "SET payment_status = ? "
                + "WHERE payment_id = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);

            ps.setInt(2, paymentId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updatePaymentAmount(
            int bookingId,
            double amount) {

        String sql
                = "UPDATE payments "
                + "SET amount = ? "
                + "WHERE booking_id = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, amount);

            ps.setInt(2, bookingId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
