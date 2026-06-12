package uef.edu.vn.dao;

import uef.edu.vn.model.Tour;
import uef.edu.vn.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TourDAO {

    public List<Tour> getAllTours() {

        List<Tour> tours = new ArrayList<>();

        String sql
                = "SELECT tour_id, tour_name, price "
                + "FROM tours";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Tour tour = new Tour();

                tour.setTourId(
                        rs.getInt("tour_id"));

                tour.setTourName(
                        rs.getString("tour_name"));

                tour.setPrice(
                        rs.getDouble("price"));

                tours.add(tour);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tours;
    }

    public Tour getTourById(int tourId) {

        String sql
                = "SELECT * FROM tours "
                + "WHERE tour_id = ?";

        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, tourId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Tour tour = new Tour();

                tour.setTourId(
                        rs.getInt("tour_id"));

                tour.setTourName(
                        rs.getString("tour_name"));

                tour.setPrice(
                        rs.getDouble("price"));

                return tour;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
