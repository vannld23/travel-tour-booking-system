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
 * DAO xử lý CRUD, tìm kiếm, phân trang và thống kê booking cho Tour.
 * Hỗ trợ tự động tương thích ngược khi DB chưa chạy ALTER TABLE thêm cột status.
 */
public class TourDAO {

    private static volatile Boolean statusColumnExists = null;

    /**
     * Kiểm tra xem cột 'status' đã được thêm vào bảng 'tours' chưa.
     */
    private boolean hasStatusColumn() {
        if (statusColumnExists != null) {
            return statusColumnExists;
        }
        String sql = """
                SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_SCHEMA = DATABASE()
                  AND TABLE_NAME   = 'tours'
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
     * Xây dựng SQL SELECT cơ bản để lấy thông tin Tour và số lượt Bookings.
     */
    private String buildBaseSelect() {
        String statusExpr = hasStatusColumn()
                ? "COALESCE(t.status, 'ACTIVE') AS status"
                : "'ACTIVE' AS status";

        return "SELECT t.tour_id, t.tour_name, t.destination_id, d.destination_name, "
             + "t.duration_days, t.price, t.max_capacity, t.start_date, t.end_date, "
             + "t.description, t.image_url, " + statusExpr + ", "
             + "COUNT(b.booking_id) AS booking_count "
             + "FROM tours t "
             + "JOIN destinations d ON t.destination_id = d.destination_id "
             + "LEFT JOIN bookings b ON b.tour_id = t.tour_id ";
    }

    /**
     * Xây dựng mệnh đề GROUP BY dựa trên sự tồn tại của cột status.
     */
    private String buildGroupBy() {
        return hasStatusColumn()
                ? " GROUP BY t.tour_id, t.tour_name, t.destination_id, d.destination_name, "
                  + "t.duration_days, t.price, t.max_capacity, t.start_date, t.end_date, "
                  + "t.description, t.image_url, t.status "
                : " GROUP BY t.tour_id, t.tour_name, t.destination_id, d.destination_name, "
                  + "t.duration_days, t.price, t.max_capacity, t.start_date, t.end_date, "
                  + "t.description, t.image_url ";
    }

    // ─── 1. LẤY TOÀN BỘ ──────────────────────────────────────────────────────

    public List<Tour> findAll() {
        String sql = buildBaseSelect() + buildGroupBy() + " ORDER BY t.tour_name ";
        return executeList(sql);
    }

    // ─── 2. TÌM KIẾM, PHÂN TRANG & SẮP XẾP ─────────────────────────────────────

    /**
     * Tìm kiếm và lọc nâng cao với Phân trang & Sắp xếp.
     */
    public List<Tour> search(String keyword, Integer destinationId, BigDecimal maxPrice,
                             Integer maxDurationDays, Tour.Status status,
                             String sortBy, String sortDir, int limit, int offset) {
        
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder(buildBaseSelect()).append(" WHERE 1=1 ");

        buildSearchQuery(sql, params, keyword, destinationId, maxPrice, maxDurationDays, status);

        sql.append(buildGroupBy());

        // Whitelist cột để tránh SQL Injection khi sắp xếp
        String orderCol = "t.tour_name";
        if ("tourId".equalsIgnoreCase(sortBy)) orderCol = "t.tour_id";
        else if ("price".equalsIgnoreCase(sortBy)) orderCol = "t.price";
        else if ("durationDays".equalsIgnoreCase(sortBy)) orderCol = "t.duration_days";
        else if ("bookingCount".equalsIgnoreCase(sortBy)) orderCol = "booking_count";
        else if ("destinationName".equalsIgnoreCase(sortBy)) orderCol = "d.destination_name";

        String orderDir = "DESC".equalsIgnoreCase(sortDir) ? "DESC" : "ASC";
        sql.append(" ORDER BY ").append(orderCol).append(" ").append(orderDir);

        // Thêm phân trang (MySQL)
        sql.append(" LIMIT ? OFFSET ? ");
        params.add(limit);
        params.add(offset);

        return executeList(sql.toString(), params);
    }

    /**
     * Tính tổng số tour khớp bộ lọc (cho tính toán số trang).
     */
    public int count(String keyword, Integer destinationId, BigDecimal maxPrice,
                     Integer maxDurationDays, Tour.Status status) {
        
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT t.tour_id) FROM tours t ");
        sql.append("JOIN destinations d ON t.destination_id = d.destination_id WHERE 1=1 ");

        buildSearchQuery(sql, params, keyword, destinationId, maxPrice, maxDurationDays, status);

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
            throw new RuntimeException("Failed to count tours", e);
        }
        return 0;
    }

    private void buildSearchQuery(StringBuilder sql, List<Object> params,
                                  String keyword, Integer destinationId, BigDecimal maxPrice,
                                  Integer maxDurationDays, Tour.Status status) {
        if (isNotBlank(keyword)) {
            sql.append(" AND (t.tour_name LIKE ? OR t.description LIKE ? OR d.destination_name LIKE ? OR d.city LIKE ?) ");
            String likePattern = "%" + keyword.trim() + "%";
            params.add(likePattern);
            params.add(likePattern);
            params.add(likePattern);
            params.add(likePattern);
        }
        if (destinationId != null && destinationId > 0) {
            sql.append(" AND t.destination_id = ? ");
            params.add(destinationId);
        }
        if (maxPrice != null && maxPrice.compareTo(BigDecimal.ZERO) >= 0) {
            sql.append(" AND t.price <= ? ");
            params.add(maxPrice);
        }
        if (maxDurationDays != null && maxDurationDays > 0) {
            sql.append(" AND t.duration_days <= ? ");
            params.add(maxDurationDays);
        }
        if (status != null && hasStatusColumn()) {
            sql.append(" AND COALESCE(t.status, 'ACTIVE') = ? ");
            params.add(status.name());
        }
    }

    // ─── 3. CÁC HÀM TRUY VẤN CHI TIẾT ──────────────────────────────────────────

    public Tour findById(int tourId) {
        String sql = buildBaseSelect() + " WHERE t.tour_id = ? " + buildGroupBy();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tourId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to load tour " + tourId, e);
        }
        return null;
    }

    public List<Tour> findByDestinationId(int destinationId) {
        String sql = buildBaseSelect() + " WHERE t.destination_id = ? " + buildGroupBy() + " ORDER BY t.tour_name";
        List<Object> params = new ArrayList<>();
        params.add(destinationId);
        return executeList(sql, params);
    }

    // ─── 4. LƯU & CẬP NHẬT ────────────────────────────────────────────────────

    public int save(Tour tour) {
        String sql = hasStatusColumn()
                ? """
                  INSERT INTO tours (tour_name, destination_id, duration_days, price, max_capacity,
                                     start_date, end_date, description, image_url, status)
                  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                  """
                : """
                  INSERT INTO tours (tour_name, destination_id, duration_days, price, max_capacity,
                                     start_date, end_date, description, image_url)
                  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                  """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(stmt, tour);
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        tour.setTourId(keys.getInt(1));
                    }
                }
            }
            return rows;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to save tour", e);
        }
    }

    public int update(Tour tour) {
        String sql = hasStatusColumn()
                ? """
                  UPDATE tours
                  SET tour_name = ?, destination_id = ?, duration_days = ?, price = ?, max_capacity = ?,
                      start_date = ?, end_date = ?, description = ?, image_url = ?, status = ?
                  WHERE tour_id = ?
                  """
                : """
                  UPDATE tours
                  SET tour_name = ?, destination_id = ?, duration_days = ?, price = ?, max_capacity = ?,
                      start_date = ?, end_date = ?, description = ?, image_url = ?
                  WHERE tour_id = ?
                  """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            fillStatement(stmt, tour);
            stmt.setInt(hasStatusColumn() ? 11 : 10, tour.getTourId());
            return stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to update tour", e);
        }
    }

    public int delete(int tourId) {
        String sql = "DELETE FROM tours WHERE tour_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tourId);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to delete tour", e);
        }
    }

    // ─── 5. HELPERS ──────────────────────────────────────────────────────────

    private void fillStatement(PreparedStatement stmt, Tour t) throws SQLException {
        stmt.setString(1, t.getTourName());
        stmt.setInt(2, t.getDestinationId());
        stmt.setInt(3, t.getDurationDays());
        stmt.setBigDecimal(4, t.getPrice() == null ? BigDecimal.ZERO : t.getPrice());
        stmt.setInt(5, t.getMaxCapacity());
        
        if (t.getStartDate() == null) {
            stmt.setNull(6, java.sql.Types.DATE);
        } else {
            stmt.setDate(6, Date.valueOf(t.getStartDate()));
        }
        
        if (t.getEndDate() == null) {
            stmt.setNull(7, java.sql.Types.DATE);
        } else {
            stmt.setDate(7, Date.valueOf(t.getEndDate()));
        }
        
        stmt.setString(8, t.getDescription());
        stmt.setString(9, t.getImageUrl());

        if (hasStatusColumn()) {
            stmt.setString(10, t.getStatus() != null ? t.getStatus().name() : Tour.Status.ACTIVE.name());
        }
    }

    private Tour mapRow(ResultSet rs) throws SQLException {
        Tour tour = new Tour();
        tour.setTourId(rs.getInt("tour_id"));
        tour.setTourName(rs.getString("tour_name"));
        tour.setDestinationId(rs.getInt("destination_id"));
        tour.setDestinationName(rs.getString("destination_name"));
        tour.setDurationDays(rs.getInt("duration_days"));
        tour.setPrice(rs.getBigDecimal("price"));
        tour.setMaxCapacity(rs.getInt("max_capacity"));
        
        Date start = rs.getDate("start_date");
        if (start != null) tour.setStartDate(start.toLocalDate());
        
        Date end = rs.getDate("end_date");
        if (end != null) tour.setEndDate(end.toLocalDate());
        
        tour.setDescription(rs.getString("description"));
        tour.setImageUrl(rs.getString("image_url"));
        
        // Parse status an toàn
        Tour.Status status = Tour.Status.ACTIVE;
        try {
            String rawStatus = rs.getString("status");
            if (rawStatus != null && !rawStatus.isBlank()) {
                status = Tour.Status.valueOf(rawStatus.toUpperCase());
            }
        } catch (IllegalArgumentException e) {
            // fallback
        }
        tour.setStatus(status);
        tour.setBookingCount(rs.getInt("booking_count"));

        return tour;
    }

    private List<Tour> executeList(String sql) {
        List<Tour> list = new ArrayList<>();
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

    private List<Tour> executeList(String sql, List<Object> params) {
        List<Tour> list = new ArrayList<>();
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

    private boolean isNotBlank(String val) {
        return val != null && !val.trim().isEmpty();
    }
}
