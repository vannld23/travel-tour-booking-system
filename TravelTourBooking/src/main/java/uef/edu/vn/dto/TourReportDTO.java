/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.dto;

/**
 *
 * @author bphun
 */
public class TourReportDTO {

    private String tourName;
    private int totalBookings;

    // Constructor, Getters, Setters
    public TourReportDTO(String tourName, int totalBookings) {
        this.tourName = tourName;
        this.totalBookings = totalBookings;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    public int getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(int totalBookings) {
        this.totalBookings = totalBookings;
    }
    
    
}
