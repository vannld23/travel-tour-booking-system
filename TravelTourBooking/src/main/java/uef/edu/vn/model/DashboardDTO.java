package uef.edu.vn.model;

import java.math.BigDecimal;

/**
 * DTO representing dashboard overview statistics.
 */
public class DashboardDTO {
    private int totalUsers;
    private int totalTours;
    private int totalBookings;
    private BigDecimal totalRevenue;

    public DashboardDTO() {
        this.totalRevenue = BigDecimal.ZERO;
    }

    public DashboardDTO(int totalUsers, int totalTours, int totalBookings, BigDecimal totalRevenue) {
        this.totalUsers = totalUsers;
        this.totalTours = totalTours;
        this.totalBookings = totalBookings;
        this.totalRevenue = totalRevenue != null ? totalRevenue : BigDecimal.ZERO;
    }

    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }

    public int getTotalTours() {
        return totalTours;
    }

    public void setTotalTours(int totalTours) {
        this.totalTours = totalTours;
    }

    public int getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(int totalBookings) {
        this.totalBookings = totalBookings;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue != null ? totalRevenue : BigDecimal.ZERO;
    }
}
