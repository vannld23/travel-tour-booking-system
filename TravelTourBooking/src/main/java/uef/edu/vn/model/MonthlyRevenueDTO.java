package uef.edu.vn.model;

import java.math.BigDecimal;

/**
 * DTO representing monthly revenue for statistical reporting.
 */
public class MonthlyRevenueDTO {
    private int month;
    private BigDecimal revenue;

    public MonthlyRevenueDTO() {
        this.revenue = BigDecimal.ZERO;
    }

    public MonthlyRevenueDTO(int month, BigDecimal revenue) {
        this.month = month;
        this.revenue = revenue != null ? revenue : BigDecimal.ZERO;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public void setRevenue(BigDecimal revenue) {
        this.revenue = revenue != null ? revenue : BigDecimal.ZERO;
    }
}
