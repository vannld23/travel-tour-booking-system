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
import uef.edu.vn.model.Schedule;
import uef.edu.vn.utils.DBConnection;

/**
 *
 * @author LENOVO
 */
public class ScheduleDAO {

    public List<Schedule> findAll() {
        List<Schedule> schedules = new ArrayList<>();
        String sql = """
                     SELECT s.schedule_id, s.tour_id, t.tour_name, s.day_number, s.activity_description
                     FROM schedules s
                     JOIN tours t ON s.tour_id = t.tour_id
                     ORDER BY s.tour_id, s.day_number
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                schedules.add(mapRow(resultSet));
            }
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to load schedules", exception);
        }
        return schedules;
    }

    public Schedule findById(int scheduleId) {
        String sql = """
                     SELECT s.schedule_id, s.tour_id, t.tour_name, s.day_number, s.activity_description
                     FROM schedules s
                     JOIN tours t ON s.tour_id = t.tour_id
                     WHERE s.schedule_id = ?
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, scheduleId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapRow(resultSet);
                }
            }
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to load schedule " + scheduleId, exception);
        }
        return null;
    }

    public List<Schedule> findByTourId(int tourId) {
        List<Schedule> schedules = new ArrayList<>();
        String sql = """
                     SELECT s.schedule_id, s.tour_id, t.tour_name, s.day_number, s.activity_description
                     FROM schedules s
                     JOIN tours t ON s.tour_id = t.tour_id
                     WHERE s.tour_id = ?
                     ORDER BY s.day_number
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, tourId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    schedules.add(mapRow(resultSet));
                }
            }
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to load schedules by tour", exception);
        }
        return schedules;
    }

    public int save(Schedule schedule) {
        String sql = """
                     INSERT INTO schedules (tour_id, day_number, activity_description)
                     VALUES (?, ?, ?)
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, schedule.getTourId());
            statement.setInt(2, schedule.getDayNumber());
            statement.setString(3, schedule.getActivityDescription());
            int updatedRows = statement.executeUpdate();
            if (updatedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        schedule.setScheduleId(generatedKeys.getInt(1));
                    }
                }
            }
            return updatedRows;
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to save schedule", exception);
        }
    }

    public int update(Schedule schedule) {
        String sql = """
                     UPDATE schedules
                     SET tour_id = ?, day_number = ?, activity_description = ?
                     WHERE schedule_id = ?
                     """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, schedule.getTourId());
            statement.setInt(2, schedule.getDayNumber());
            statement.setString(3, schedule.getActivityDescription());
            statement.setInt(4, schedule.getScheduleId());
            return statement.executeUpdate();
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to update schedule", exception);
        }
    }

    public int delete(int scheduleId) {
        String sql = "DELETE FROM schedules WHERE schedule_id = ?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, scheduleId);
            return statement.executeUpdate();
        } catch (SQLException exception) {
            throw new RuntimeException("Failed to delete schedule", exception);
        }
    }

    private Schedule mapRow(ResultSet resultSet) throws SQLException {
        return new Schedule(
                resultSet.getInt("schedule_id"),
                resultSet.getInt("tour_id"),
                resultSet.getString("tour_name"),
                resultSet.getInt("day_number"),
                resultSet.getString("activity_description")
        );
    }
}
