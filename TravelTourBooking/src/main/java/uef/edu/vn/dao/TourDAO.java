/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import uef.edu.vn.model.Tour;
import uef.edu.vn.utils.DBConnection;

/**
 *
 * @author LENOVO
 */
public class TourDAO {

    public List<Tour> findAll() {
        List<Tour> tours = new ArrayList<>();
        String sql = """
                     SELECT t.tour_id, t.tour_name, t.destination_id, d.destination_name,
                            t.duration_days, t.price, t.max_capacity, t.start_date, t.end_date,
                            t.description, t.image_url
                     FROM tours t
                     JOIN destinations d ON t.destination_id = d.destination_id
                     ORDER BY t.tour_name
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                tours.add(mapRow(resultSet));
            }
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to load tours", exception);
        }
        return tours;
    }

    public Tour findById(int tourId) {
        String sql = """
                     SELECT t.tour_id, t.tour_name, t.destination_id, d.destination_name,
                            t.duration_days, t.price, t.max_capacity, t.start_date, t.end_date,
                            t.description, t.image_url
                     FROM tours t
                     JOIN destinations d ON t.destination_id = d.destination_id
                     WHERE t.tour_id = ?
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, tourId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapRow(resultSet);
                }
            }
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to load tour " + tourId, exception);
        }
        return null;
    }

    public List<Tour> findByDestinationId(int destinationId) {
        List<Tour> tours = new ArrayList<>();
        String sql = """
                     SELECT t.tour_id, t.tour_name, t.destination_id, d.destination_name,
                            t.duration_days, t.price, t.max_capacity, t.start_date, t.end_date,
                            t.description, t.image_url
                     FROM tours t
                     JOIN destinations d ON t.destination_id = d.destination_id
                     WHERE t.destination_id = ?
                     ORDER BY t.tour_name
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, destinationId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    tours.add(mapRow(resultSet));
                }
            }
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to load tours by destination", exception);
        }
        return tours;
    }

    public int save(Tour tour) {
        String sql = """
                     INSERT INTO tours (
                         tour_name, destination_id, duration_days, price, max_capacity,
                         start_date, end_date, description, image_url
                     )
                     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(statement, tour);
            int updatedRows = statement.executeUpdate();
            if (updatedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        tour.setTourId(generatedKeys.getInt(1));
                    }
                }
            }
            return updatedRows;
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to save tour", exception);
        }
    }

    public int update(Tour tour) {
        String sql = """
                     UPDATE tours
                     SET tour_name = ?, destination_id = ?, duration_days = ?, price = ?, max_capacity = ?,
                         start_date = ?, end_date = ?, description = ?, image_url = ?
                     WHERE tour_id = ?
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            fillStatement(statement, tour);
            statement.setInt(10, tour.getTourId());
            return statement.executeUpdate();
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to update tour", exception);
        }
    }

    public int delete(int tourId) {
        String sql = "DELETE FROM tours WHERE tour_id = ?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, tourId);
            return statement.executeUpdate();
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to delete tour", exception);
        }
    }

    private void fillStatement(PreparedStatement statement, Tour tour) throws SQLException {
        statement.setString(1, tour.getTourName());
        statement.setInt(2, tour.getDestinationId());
        statement.setInt(3, tour.getDurationDays());
        statement.setBigDecimal(4, tour.getPrice() == null ? BigDecimal.ZERO : tour.getPrice());
        statement.setInt(5, tour.getMaxCapacity());
        if (tour.getStartDate() == null) {
            statement.setNull(6, java.sql.Types.DATE);
        } else {
            statement.setDate(6, Date.valueOf(tour.getStartDate()));
        }
        if (tour.getEndDate() == null) {
            statement.setNull(7, java.sql.Types.DATE);
        } else {
            statement.setDate(7, Date.valueOf(tour.getEndDate()));
        }
        statement.setString(8, tour.getDescription());
        statement.setString(9, tour.getImageUrl());
    }

    private Tour mapRow(ResultSet resultSet) throws SQLException {
        Tour tour = new Tour();
        tour.setTourId(resultSet.getInt("tour_id"));
        tour.setTourName(resultSet.getString("tour_name"));
        tour.setDestinationId(resultSet.getInt("destination_id"));
        tour.setDestinationName(resultSet.getString("destination_name"));
        tour.setDurationDays(resultSet.getInt("duration_days"));
        tour.setPrice(resultSet.getBigDecimal("price"));
        tour.setMaxCapacity(resultSet.getInt("max_capacity"));
        Date startDate = resultSet.getDate("start_date");
        if (startDate != null) {
            tour.setStartDate(startDate.toLocalDate());
        }
        Date endDate = resultSet.getDate("end_date");
        if (endDate != null) {
            tour.setEndDate(endDate.toLocalDate());
        }
        tour.setDescription(resultSet.getString("description"));
        tour.setImageUrl(resultSet.getString("image_url"));
        return tour;
    }
}
