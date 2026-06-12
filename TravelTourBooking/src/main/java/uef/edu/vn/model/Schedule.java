/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.model;

import java.util.Objects;

/**
 *
 * @author LENOVO
 */
public class Schedule {

    private int scheduleId;
    private int tourId;
    private String tourName;
    private int dayNumber;
    private String activityDescription;

    public Schedule() {
    }

    public Schedule(int scheduleId, int tourId, String tourName, int dayNumber, String activityDescription) {
        this.scheduleId = scheduleId;
        this.tourId = tourId;
        this.tourName = tourName;
        this.dayNumber = dayNumber;
        this.activityDescription = activityDescription;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    public int getDayNumber() {
        return dayNumber;
    }

    public void setDayNumber(int dayNumber) {
        this.dayNumber = dayNumber;
    }

    public String getActivityDescription() {
        return activityDescription;
    }

    public void setActivityDescription(String activityDescription) {
        this.activityDescription = activityDescription;
    }

    @Override
    public String toString() {
        return "Schedule{" + "scheduleId=" + scheduleId + ", tourId=" + tourId + ", dayNumber=" + dayNumber + '}';
    }

    @Override
    public int hashCode() {
        return Objects.hash(scheduleId);
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) {
            return true;
        }
        if (object == null || getClass() != object.getClass()) {
            return false;
        }
        Schedule that = (Schedule) object;
        return scheduleId == that.scheduleId;
    }
}
