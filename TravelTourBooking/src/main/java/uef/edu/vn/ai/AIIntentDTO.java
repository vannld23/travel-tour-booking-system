/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.ai;

import java.util.List;

public class AIIntentDTO {

    private String intent;          // VD: REVENUE_REPORT, TOP_TOUR, CUSTOMER_GROWTH
    private String timePeriod;      // VD: "2026-01-01", "2026-03-31", "current_month"
    private String chartType;       // VD: BAR, PIE, LINE, NONE
    private String summary;         // AI tự viết một câu giải thích ngắn gọn
    private boolean isValid;        // Kiểm tra xem yêu cầu có hợp lệ không
    private List<Double> data;

    // Constructor, Getters, Setters
    public AIIntentDTO() {
    }

    public AIIntentDTO(String intent, String timePeriod, String chartType, String summary, boolean isValid) {
        this.intent = intent;
        this.timePeriod = timePeriod;
        this.chartType = chartType;
        this.summary = summary;
        this.isValid = isValid;

    }

    // Thêm các getter/setter tại đây
    public String getIntent() {
        return intent;
    }

    public void setIntent(String intent) {
        this.intent = intent;
    }

    public String getTimePeriod() {
        return timePeriod;
    }

    public void setTimePeriod(String timePeriod) {
        this.timePeriod = timePeriod;
    }

    public String getChartType() {
        return chartType;
    }

    public void setChartType(String chartType) {
        this.chartType = chartType;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public boolean isIsValid() {
        return isValid;
    }

    public void setIsValid(boolean isValid) {
        this.isValid = isValid;
    }

    public void setData(List<Double> data) {
        this.data = data;
    }

    // Đảm bảo có getter này:
    public List<Double> getData() {
        return data;
    }
}
