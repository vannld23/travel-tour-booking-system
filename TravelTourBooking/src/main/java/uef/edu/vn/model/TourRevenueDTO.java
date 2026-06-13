package uef.edu.vn.model;

import java.math.BigDecimal;

/**
 * DTO representing revenue generated per tour.
 */
public class TourRevenueDTO {
    private String tourName;
    private BigDecimal revenue;

    public TourRevenueDTO() {
        this.revenue = BigDecimal.ZERO;
    }

    public TourRevenueDTO(String tourName, BigDecimal revenue) {
        this.tourName = tourName;
        this.revenue = revenue != null ? revenue : BigDecimal.ZERO;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public void setRevenue(BigDecimal revenue) {
        this.revenue = revenue != null ? revenue : BigDecimal.ZERO;
    }
}
