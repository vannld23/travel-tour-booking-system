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
 * DAO cho điểm đến. Sử dụng JDBC thuần với try-with-resources.
 * Bổ sung: tìm kiếm/lọc, join booking count, hỗ trợ cột status.
 *
 * LƯU Ý VỀ DATABASE:
 *   Bạn cần chạy câu SQL sau để thêm cột status vào bảng destinations:
 *   ALTER TABLE destinations ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE';
 */
public class DestinationDAO {

    // ─── Kiểm tra sự tồn tại của cột 'status' trong bảng destinations ────────
    // Dùng để chạy đúng SQL dù cột chưa được ALTER TABLE.
    private static volatile Boolean statusColumnExists = null;

    /**
     * Kiểm tra xem cột 'status' đã tồn tại trong bảng 'destinations' chưa.
     * Kết quả được cache lại sau lần kiểm tra đầu tiên để tránh gọi DB nhiều lần.
     */
    private boolean hasStatusColumn() {
        if (statusColumnExists != null) {
            return statusColumnExists;
        }
        String sql = """
                SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_SCHEMA = DATABASE()
                  AND TABLE_NAME   = 'destinations'
                  AND COLUMN_NAME  = 'status'
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            statusColumnExists = rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            // Nếu kiểm tra thất bại, coi như cột chưa tồn tại
            statusColumnExists = false;
        }
        return statusColumnExists;
    }

    // ─── SQL nền: join booking count ──────────────────────────────────────────
    // Phần SELECT status được tạo động dựa trên kết quả hasStatusColumn()

    private String buildBaseSelect() {
        String statusExpr = hasStatusColumn()
                ? "COALESCE(d.status, 'ACTIVE') AS status"
                : "'ACTIVE' AS status";

        return "SELECT d.destination_id, d.destination_name, d.country, d.city, d.description, d.image_url, "
             + statusExpr + ", "
             + "COUNT(DISTINCT b.booking_id) AS booking_count, "
             + "COUNT(DISTINCT t.tour_id) AS tour_count "
             + "FROM destinations d "
             + "LEFT JOIN tours    t ON t.destination_id = d.destination_id "
             + "LEFT JOIN bookings b ON b.tour_id         = t.tour_id ";
    }



    /**
     * Tạo mệnh đề GROUP BY phù hợp tuỳ theo việc cột 'status' có tồn tại hay không.
     * Nếu cột chưa được thêm vào DB, không đưa d.status vào GROUP BY để tránh lỗi SQL.
     */
    private String buildGroupBy() {
        return hasStatusColumn()
                ? " GROUP BY d.destination_id, d.destination_name, d.country, d.city, d.description, d.image_url, d.status "
                : " GROUP BY d.destination_id, d.destination_name, d.country, d.city, d.description, d.image_url ";
    }

    // ─── 1. Lấy tất cả điểm đến ─────────────────────────────────────────────

    /**
     * Lấy toàn bộ danh sách điểm đến kèm số lượng booking liên quan.
     */
    public List<Destination> findAll() {
        String groupBy = buildGroupBy();
        String sql = buildBaseSelect() + groupBy + " ORDER BY d.destination_name ";
        return executeList(sql);
    }

    // ─── 2. Tìm kiếm và lọc ─────────────────────────────────────────────────

    /**
     * Tìm kiếm điểm đến theo từ khóa, quốc gia, thành phố và trạng thái.
     * Bất kỳ tham số nào null/rỗng đều bị bỏ qua (không lọc theo trường đó).
     *
     * @param keyword  từ khóa tìm kiếm (tên điểm đến, mô tả)
     * @param country  quốc gia cần lọc
     * @param city     thành phố cần lọc
     * @param status   trạng thái cần lọc (ACTIVE / INACTIVE / UPCOMING), null = tất cả
     */
    public List<Destination> search(String keyword, String country, String city, Destination.Status status) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder(buildBaseSelect()).append(" WHERE 1=1 ");

        // Lọc theo từ khóa (tìm trong tên và mô tả)
        if (isNotBlank(keyword)) {
            sql.append(" AND (d.destination_name LIKE ? OR d.description LIKE ?) ");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }

        // Lọc theo quốc gia
        if (isNotBlank(country)) {
            sql.append(" AND d.country = ? ");
            params.add(country.trim());
        }

        // Lọc theo thành phố
        if (isNotBlank(city)) {
            sql.append(" AND d.city LIKE ? ");
            params.add("%" + city.trim() + "%");
        }

        // Lọc theo trạng thái (chỉ áp dụng nếu cột tồn tại)
        if (status != null && hasStatusColumn()) {
            sql.append(" AND COALESCE(d.status, 'ACTIVE') = ? ");
            params.add(status.name());
        }

        sql.append(buildGroupBy()).append(" ORDER BY d.destination_name ");
        return executeList(sql.toString(), params);
    }

    // ─── 3. Tìm theo ID ──────────────────────────────────────────────────────

    public Destination findById(int destinationId) {
        String sql = buildBaseSelect()
                   + " WHERE d.destination_id = ? "
                   + buildGroupBy();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, destinationId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to load destination " + destinationId, e);
        }
        return null;
    }

    // ─── 4. Lấy danh sách quốc gia (cho dropdown filter) ────────────────────

    /**
     * Lấy danh sách các quốc gia duy nhất để đổ vào dropdown bộ lọc.
     */
    public List<String> findAllCountries() {
        List<String> countries = new ArrayList<>();
        String sql = "SELECT DISTINCT country FROM destinations WHERE country IS NOT NULL ORDER BY country";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                countries.add(rs.getString("country"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to load countries", e);
        }
        return countries;
    }

    // ─── 5. Lưu mới ──────────────────────────────────────────────────────────

    public int save(Destination destination) {
        // Chọn SQL phù hợp tùy theo việc cột 'status' đã tồn tại hay chưa
        String sql = hasStatusColumn()
                ? "INSERT INTO destinations (destination_name, country, city, description, image_url, status) VALUES (?, ?, ?, ?, ?, ?)"
                : "INSERT INTO destinations (destination_name, country, city, description, image_url) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(stmt, destination);
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        destination.setDestinationId(keys.getInt(1));
                    }
                }
            }
            return rows;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to save destination", e);
        }
    }

    // ─── 6. Cập nhật ─────────────────────────────────────────────────────────

    public int update(Destination destination) {
        // Chọn SQL phù hợp tùy theo việc cột 'status' đã tồn tại hay chưa
        String sql = hasStatusColumn()
                ? "UPDATE destinations SET destination_name=?, country=?, city=?, description=?, image_url=?, status=? WHERE destination_id=?"
                : "UPDATE destinations SET destination_name=?, country=?, city=?, description=?, image_url=? WHERE destination_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            fillStatement(stmt, destination);
            // Tham số cuối là destination_id — vị trí phụ thuộc số cột
            stmt.setInt(hasStatusColumn() ? 7 : 6, destination.getDestinationId());
            return stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to update destination", e);
        }
    }

    // ─── 7. Xóa ──────────────────────────────────────────────────────────────

    public int delete(int destinationId) {
        String sql = "DELETE FROM destinations WHERE destination_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, destinationId);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to delete destination", e);
        }
    }

    // ─── Utilities ───────────────────────────────────────────────────────────

    /** Thực thi câu SELECT không có tham số động */
    private List<Destination> executeList(String sql) {
        List<Destination> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to load destination list", e);
        }
        return list;
    }

    /** Thực thi câu SELECT với danh sách tham số động (dùng cho search) */
    private List<Destination> executeList(String sql, List<Object> params) {
        List<Destination> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Bind từng tham số theo thứ tự
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to search destinations", e);
        }
        return list;
    }

    /** Điền tham số vào PreparedStatement cho INSERT / UPDATE */
    private void fillStatement(PreparedStatement stmt, Destination d) throws SQLException {
        stmt.setString(1, d.getDestinationName());
        stmt.setString(2, d.getCountry());
        stmt.setString(3, d.getCity());
        stmt.setString(4, d.getDescription());
        stmt.setString(5, d.getImageUrl());
        // Chỉ bind tham số status khi cột đã tồn tại trong DB
        if (hasStatusColumn()) {
            stmt.setString(6, d.getStatus() != null ? d.getStatus().name() : Destination.Status.ACTIVE.name());
        }
    }

    /** Chuyển đổi một hàng ResultSet thành đối tượng Destination */
    private Destination mapRow(ResultSet rs) throws SQLException {
        // Parse status an toàn: nếu giá trị trong DB không hợp lệ thì fallback ACTIVE
        Destination.Status status;
        try {
            String rawStatus = rs.getString("status");
            status = (rawStatus != null && !rawStatus.isBlank())
                     ? Destination.Status.valueOf(rawStatus.toUpperCase())
                     : Destination.Status.ACTIVE;
        } catch (IllegalArgumentException e) {
            status = Destination.Status.ACTIVE;
        }

        Destination dest = new Destination(
                rs.getInt("destination_id"),
                rs.getString("destination_name"),
                rs.getString("country"),
                rs.getString("city"),
                rs.getString("description"),
                rs.getString("image_url"),
                status
        );
        dest.setBookingCount(rs.getInt("booking_count"));
        try {
            dest.setTourCount(rs.getInt("tour_count"));
        } catch (SQLException e) {
            dest.setTourCount(0);
        }
        return dest;
    }

    /** Kiểm tra chuỗi không rỗng và không chỉ chứa khoảng trắng */
    private boolean isNotBlank(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
