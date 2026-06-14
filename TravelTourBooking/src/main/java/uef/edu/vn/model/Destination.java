package uef.edu.vn.model;

import java.util.Objects;

/**
 * Model đại diện cho một điểm đến du lịch.
 * Bổ sung: trường status (Active / Inactive / Upcoming) và bookingCount (số booking liên quan).
 */
public class Destination {

    /** Trạng thái hoạt động của điểm đến */
    public enum Status {
        ACTIVE, INACTIVE, UPCOMING;

        /** Trả về nhãn hiển thị tiếng Việt */
        public String getLabel() {
            return switch (this) {
                case ACTIVE   -> "Đang hoạt động";
                case INACTIVE -> "Ngừng hoạt động";
                case UPCOMING -> "Sắp mở";
            };
        }

        /** Trả về class màu CSS để hiển thị badge */
        public String getBadgeClass() {
            return switch (this) {
                case ACTIVE   -> "badge-active";
                case INACTIVE -> "badge-inactive";
                case UPCOMING -> "badge-upcoming";
            };
        }
    }

    private int    destinationId;
    private String destinationName;
    private String country;
    private String city;
    private String description;
    private String imageUrl;
    private Status status;        // trạng thái điểm đến (NEW)
    private int    bookingCount;  // số lượt đặt tour liên quan (NEW - computed from DB join)
    private int    tourCount;     // số lượng tour (NEW - computed from DB join)

    public Destination() {
        this.status = Status.ACTIVE; // mặc định là ACTIVE
    }

    public Destination(int destinationId, String destinationName, String country, String city,
                       String description, String imageUrl) {
        this.destinationId   = destinationId;
        this.destinationName = destinationName;
        this.country         = country;
        this.city            = city;
        this.description     = description;
        this.imageUrl        = imageUrl;
        this.status          = Status.ACTIVE;
    }

    public Destination(int destinationId, String destinationName, String country, String city,
                       String description, String imageUrl, Status status) {
        this.destinationId   = destinationId;
        this.destinationName = destinationName;
        this.country         = country;
        this.city            = city;
        this.description     = description;
        this.imageUrl        = imageUrl;
        this.status          = status != null ? status : Status.ACTIVE;
    }

    // ─── Getters & Setters ───────────────────────────────────────────────────

    public int getDestinationId() { return destinationId; }
    public void setDestinationId(int destinationId) { this.destinationId = destinationId; }

    public String getDestinationName() { return destinationName; }
    public void setDestinationName(String destinationName) { this.destinationName = destinationName; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status != null ? status : Status.ACTIVE; }

    /** Tiện ích: lấy nhãn tiếng Việt của trạng thái */
    public String getStatusLabel() {
        return status != null ? status.getLabel() : Status.ACTIVE.getLabel();
    }

    /** Tiện ích: lấy CSS class badge của trạng thái */
    public String getStatusBadgeClass() {
        return status != null ? status.getBadgeClass() : Status.ACTIVE.getBadgeClass();
    }

    public int getBookingCount() { return bookingCount; }
    public void setBookingCount(int bookingCount) { this.bookingCount = bookingCount; }

    public int getTourCount() { return tourCount; }
    public void setTourCount(int tourCount) { this.tourCount = tourCount; }

    /** Tiện ích: xác định mã vùng miền dựa trên tên thành phố */
    public String getRegionCode() {
        if (city == null) return "all";
        String normalized = city.toLowerCase().trim();
        if (normalized.contains("quảng ninh") || normalized.contains("lào cai") || normalized.contains("sơn la") || 
            normalized.contains("hải phòng") || normalized.contains("hà nội") || normalized.contains("ha noi") ||
            normalized.contains("sapa") || normalized.contains("hạ long") || normalized.contains("moc chau") ||
            normalized.contains("cat ba")) {
            return "north";
        }
        if (normalized.contains("đà nẵng") || normalized.contains("da nang") || normalized.contains("quảng nam") || 
            normalized.contains("hội an") || normalized.contains("thừa thiên") || normalized.contains("huế") || 
            normalized.contains("hue") || normalized.contains("quảng bình") || normalized.contains("quang nam")) {
            return "central";
        }
        if (normalized.contains("kiên giang") || normalized.contains("phú quốc") || normalized.contains("lâm đồng") || 
            normalized.contains("đà lạt") || normalized.contains("nha trang") || normalized.contains("vũng tàu") || 
            normalized.contains("hồ chí minh") || normalized.contains("hcm") || normalized.contains("cần thơ") || 
            normalized.contains("phu quoc") || normalized.contains("da lat")) {
            return "south";
        }
        return "all";
    }

    /** Tiện ích: lấy nhãn hiển thị vùng miền tiếng Việt */
    public String getRegionLabel() {
        String code = getRegionCode();
        return switch (code) {
            case "north"   -> "MIỀN BẮC";
            case "central" -> "MIỀN TRUNG";
            case "south"   -> "MIỀN NAM";
            default        -> "MIỀN BẮC"; // fallback mặc định đẹp mắt
        };
    }

    // ─── Standard overrides ──────────────────────────────────────────────────

    @Override
    public String toString() {
        return "Destination{id=" + destinationId + ", name=" + destinationName + ", status=" + status + "}";
    }

    @Override
    public int hashCode() { return Objects.hash(destinationId); }

    @Override
    public boolean equals(Object object) {
        if (this == object) return true;
        if (object == null || getClass() != object.getClass()) return false;
        Destination that = (Destination) object;
        return destinationId == that.destinationId;
    }
}
