/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Objects;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author LENOVO
 */
public class Tour {

    public enum Status {
        ACTIVE, INACTIVE, UPCOMING;

        public String getLabel() {
            return switch (this) {
                case ACTIVE   -> "Hoạt động";
                case INACTIVE -> "Ngừng hoạt động";
                case UPCOMING -> "Sắp diễn ra";
            };
        }

        public String getBadgeClass() {
            return switch (this) {
                case ACTIVE   -> "badge-active";
                case INACTIVE -> "badge-inactive";
                case UPCOMING -> "badge-upcoming";
            };
        }
    }

    private int tourId;
    private String tourName;
    private int destinationId;
    private String destinationName;
    private int durationDays;
    private BigDecimal price;
    private int maxCapacity;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate startDate;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate endDate;
    private String description;
    private String imageUrl;
    private Status status = Status.ACTIVE;
    private int bookingCount;

    public Tour() {
    }

    public Tour(int tourId, String tourName, int destinationId, String destinationName, int durationDays, BigDecimal price, int maxCapacity, LocalDate startDate, LocalDate endDate, String description, String imageUrl) {
        this.tourId = tourId;
        this.tourName = tourName;
        this.destinationId = destinationId;
        this.destinationName = destinationName;
        this.durationDays = durationDays;
        this.price = price;
        this.maxCapacity = maxCapacity;
        this.startDate = startDate;
        this.endDate = endDate;
        this.description = description;
        this.imageUrl = imageUrl;
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

    public int getDestinationId() {
        return destinationId;
    }

    public void setDestinationId(int destinationId) {
        this.destinationId = destinationId;
    }

    public String getDestinationName() {
        return destinationName;
    }

    public void setDestinationName(String destinationName) {
        this.destinationName = destinationName;
    }

    public int getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(int durationDays) {
        this.durationDays = durationDays;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getMaxCapacity() {
        return maxCapacity;
    }

    public void setMaxCapacity(int maxCapacity) {
        this.maxCapacity = maxCapacity;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public String getStatusLabel() {
        return status != null ? status.getLabel() : Status.ACTIVE.getLabel();
    }

    public String getStatusBadgeClass() {
        return status != null ? status.getBadgeClass() : Status.ACTIVE.getBadgeClass();
    }

    public int getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(int bookingCount) {
        this.bookingCount = bookingCount;
    }

    @Override
    public String toString() {
        return "Tour{" + "tourId=" + tourId + ", tourName=" + tourName + '}';
    }

    @Override
    public int hashCode() {
        return Objects.hash(tourId);
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) {
            return true;
        }
        if (object == null || getClass() != object.getClass()) {
            return false;
        }
        Tour that = (Tour) object;
        return tourId == that.tourId;
    }
}
