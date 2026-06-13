package uef.edu.vn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import uef.edu.vn.model.Itinerary;
import uef.edu.vn.utils.DBConnection;

/**
 * DAO class for Itinerary (schedules table).
 * Tích hợp tìm kiếm nâng cao, phân trang, sắp xếp và tương thích ngược với DB chưa thêm cột status.
 */
public class ItineraryDAO {

    private static volatile Boolean statusColumnExists = null;

    /**
     * Kiểm tra động xem cột 'status' đã được thêm vào bảng 'schedules' chưa.
     */
    private boolean hasStatusColumn() {
        if (statusColumnExists != null) {
            return statusColumnExists;
        }
        String sql = """
                SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_SCHEMA = DATABASE()
                  AND TABLE_NAME   = 'schedules'
                  AND COLUMN_NAME  = 'status'
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            statusColumnExists = rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            statusColumnExists = false;
        }
        return statusColumnExists;
    }

    /**
     * Base select query joining schedules, tours and destinations tables.
     */
    private String buildBaseSelect() {
        String statusExpr = hasStatusColumn()
                ? "COALESCE(s.status, 'ACTIVE') AS status"
                : "'ACTIVE' AS status";

        return "SELECT s.schedule_id, s.tour_id, t.tour_name, d.destination_name, "
             + "s.day_number, s.activity_description, " + statusExpr + " "
             + "FROM schedules s "
             + "JOIN tours t ON s.tour_id = t.tour_id "
             + "LEFT JOIN destinations d ON t.destination_id = d.destination_id ";
    }

    // ─── 1. LẤY TOÀN BỘ ──────────────────────────────────────────────────────

    public List<Itinerary> findAll() {
        String sql = buildBaseSelect() + " ORDER BY s.tour_id, s.day_number ";
        return executeList(sql);
    }

    // ─── 2. TÌM KIẾM, PHÂN TRANG & SẮP XẾP ─────────────────────────────────────

    public List<Itinerary> search(Integer tourId, Integer dayNumber, String keyword, Itinerary.Status status,
                                 String sortBy, String sortDir, int limit, int offset) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder(buildBaseSelect()).append(" WHERE 1=1 ");

        buildSearchQuery(sql, params, tourId, dayNumber, keyword, status);

        // Sorting columns mapping
        String orderCol = "s.tour_id, s.day_number";
        if ("itineraryId".equalsIgnoreCase(sortBy)) orderCol = "s.schedule_id";
        else if ("tourName".equalsIgnoreCase(sortBy)) orderCol = "t.tour_name";
        else if ("dayNumber".equalsIgnoreCase(sortBy)) orderCol = "s.day_number";
        else if ("activityDescription".equalsIgnoreCase(sortBy)) orderCol = "s.activity_description";

        String orderDir = "DESC".equalsIgnoreCase(sortDir) ? "DESC" : "ASC";
        sql.append(" ORDER BY ").append(orderCol).append(" ").append(orderDir);

        // Pagination limit offset
        sql.append(" LIMIT ? OFFSET ? ");
        params.add(limit);
        params.add(offset);

        return executeList(sql.toString(), params);
    }

    public int count(Integer tourId, Integer dayNumber, String keyword, Itinerary.Status status) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM schedules s ");
        sql.append("JOIN tours t ON s.tour_id = t.tour_id WHERE 1=1 ");

        buildSearchQuery(sql, params, tourId, dayNumber, keyword, status);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to count itineraries", e);
        }
        return 0;
    }

    private void buildSearchQuery(StringBuilder sql, List<Object> params,
                                  Integer tourId, Integer dayNumber, String keyword, Itinerary.Status status) {
        if (tourId != null && tourId > 0) {
            sql.append(" AND s.tour_id = ? ");
            params.add(tourId);
        }
        if (dayNumber != null && dayNumber > 0) {
            sql.append(" AND s.day_number = ? ");
            params.add(dayNumber);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND s.activity_description LIKE ? ");
            params.add("%" + keyword.trim() + "%");
        }
        if (status != null && hasStatusColumn()) {
            sql.append(" AND COALESCE(s.status, 'ACTIVE') = ? ");
            params.add(status.name());
        }
    }

    // ─── 3. TRUY VẤN CHI TIẾT ──────────────────────────────────────────────────

    public Itinerary findById(int itineraryId) {
        String sql = buildBaseSelect() + " WHERE s.schedule_id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, itineraryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to load itinerary " + itineraryId, e);
        }
        return null;
    }

    public List<Itinerary> findByTourId(int tourId) {
        String sql = buildBaseSelect() + " WHERE s.tour_id = ? ORDER BY s.day_number ";
        List<Object> params = new ArrayList<>();
        params.add(tourId);
        return executeList(sql, params);
    }

    // ─── 4. LƯU & CẬP NHẬT ────────────────────────────────────────────────────

    public int save(Itinerary itinerary) {
        String sql = hasStatusColumn()
                ? "INSERT INTO schedules (tour_id, day_number, activity_description, status) VALUES (?, ?, ?, ?)"
                : "INSERT INTO schedules (tour_id, day_number, activity_description) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, itinerary.getTourId());
            stmt.setInt(2, itinerary.getDayNumber());
            stmt.setString(3, itinerary.getActivityDescription());
            if (hasStatusColumn()) {
                stmt.setString(4, itinerary.getStatus() != null ? itinerary.getStatus().name() : Itinerary.Status.ACTIVE.name());
            }
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        itinerary.setItineraryId(keys.getInt(1));
                    }
                }
            }
            return rows;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to save itinerary", e);
        }
    }

    public int update(Itinerary itinerary) {
        String sql = hasStatusColumn()
                ? "UPDATE schedules SET tour_id = ?, day_number = ?, activity_description = ?, status = ? WHERE schedule_id = ?"
                : "UPDATE schedules SET tour_id = ?, day_number = ?, activity_description = ? WHERE schedule_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, itinerary.getTourId());
            stmt.setInt(2, itinerary.getDayNumber());
            stmt.setString(3, itinerary.getActivityDescription());
            if (hasStatusColumn()) {
                stmt.setString(4, itinerary.getStatus() != null ? itinerary.getStatus().name() : Itinerary.Status.ACTIVE.name());
                stmt.setInt(5, itinerary.getItineraryId());
            } else {
                stmt.setInt(4, itinerary.getItineraryId());
            }
            return stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to update itinerary", e);
        }
    }

    public int delete(int itineraryId) {
        String sql = "DELETE FROM schedules WHERE schedule_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, itineraryId);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to delete itinerary", e);
        }
    }

    // ─── 5. HELPERS ──────────────────────────────────────────────────────────

    private Itinerary mapRow(ResultSet rs) throws SQLException {
        Itinerary.Status status = Itinerary.Status.ACTIVE;
        try {
            String rawStatus = rs.getString("status");
            if (rawStatus != null && !rawStatus.isBlank()) {
                status = Itinerary.Status.valueOf(rawStatus.toUpperCase());
            }
        } catch (IllegalArgumentException e) {
            // fallback
        }

        return new Itinerary(
                rs.getInt("schedule_id"),
                rs.getInt("tour_id"),
                rs.getString("tour_name"),
                rs.getString("destination_name"),
                rs.getInt("day_number"),
                rs.getString("activity_description"),
                status
        );
    }

    private List<Itinerary> executeList(String sql) {
        List<Itinerary> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to execute query", e);
        }
        return list;
    }

    private List<Itinerary> executeList(String sql, List<Object> params) {
        List<Itinerary> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to execute query with params", e);
        }
        return list;
    }
}
