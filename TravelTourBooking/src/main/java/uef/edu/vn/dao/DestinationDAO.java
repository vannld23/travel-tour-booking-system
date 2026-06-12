/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import uef.edu.vn.model.Destination;
import uef.edu.vn.utils.DBConnection;

/**
 *
 * @author LENOVO
 */
public class DestinationDAO {

    public List<Destination> findAll() {
        List<Destination> destinations = new ArrayList<>();
        String sql = """
                     SELECT destination_id, destination_name, country, city, description, image_url
                     FROM destinations
                     ORDER BY destination_name
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                destinations.add(mapRow(resultSet));
            }
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to load destinations", exception);
        }
        return destinations;
    }

    public Destination findById(int destinationId) {
        String sql = """
                     SELECT destination_id, destination_name, country, city, description, image_url
                     FROM destinations
                     WHERE destination_id = ?
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, destinationId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapRow(resultSet);
                }
            }
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to load destination " + destinationId, exception);
        }
        return null;
    }

    public int save(Destination destination) {
        String sql = """
                     INSERT INTO destinations (destination_name, country, city, description, image_url)
                     VALUES (?, ?, ?, ?, ?)
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(statement, destination);
            int updatedRows = statement.executeUpdate();
            if (updatedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        destination.setDestinationId(generatedKeys.getInt(1));
                    }
                }
            }
            return updatedRows;
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to save destination", exception);
        }
    }

    public int update(Destination destination) {
        String sql = """
                     UPDATE destinations
                     SET destination_name = ?, country = ?, city = ?, description = ?, image_url = ?
                     WHERE destination_id = ?
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            fillStatement(statement, destination);
            statement.setInt(6, destination.getDestinationId());
            return statement.executeUpdate();
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to update destination", exception);
        }
    }

    public int delete(int destinationId) {
        String sql = "DELETE FROM destinations WHERE destination_id = ?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, destinationId);
            return statement.executeUpdate();
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to delete destination", exception);
        }
    }

    private void fillStatement(PreparedStatement statement, Destination destination) throws SQLException {
        statement.setString(1, destination.getDestinationName());
        statement.setString(2, destination.getCountry());
        statement.setString(3, destination.getCity());
        statement.setString(4, destination.getDescription());
        statement.setString(5, destination.getImageUrl());
    }

    private Destination mapRow(ResultSet resultSet) throws SQLException {
        return new Destination(
                resultSet.getInt("destination_id"),
                resultSet.getString("destination_name"),
                resultSet.getString("country"),
                resultSet.getString("city"),
                resultSet.getString("description"),
                resultSet.getString("image_url")
        );
    }
}
