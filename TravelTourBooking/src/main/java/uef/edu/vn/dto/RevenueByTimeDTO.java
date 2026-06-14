package uef.edu.vn.dto;

import java.math.BigDecimal;

public class RevenueByTimeDTO {
    private String period;    // Lưu trữ mốc thời gian (ví dụ: "2026-05")
    private BigDecimal totalRevenue; // Dùng BigDecimal để chính xác tuyệt đối về tài chính

    // Constructor mặc định
    public RevenueByTimeDTO() {}

    // Constructor đầy đủ
    public RevenueByTimeDTO(String period, BigDecimal totalRevenue) {
        this.period = period;
        this.totalRevenue = totalRevenue;
    }

    // Getters và Setters
    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}