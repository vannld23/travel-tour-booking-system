package uef.edu.vn.model;

import java.util.Objects;

/**
 * Model class representing Tour Itinerary (schedules table).
 */
public class Itinerary {

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

    private int itineraryId;
    private int tourId;
    private String tourName;
    private String destinationName; // NEW: Liên kết hiển thị điểm đến
    private int dayNumber;
    private String activityDescription;
    private Status status = Status.ACTIVE; // NEW: Cột trạng thái

    public Itinerary() {
    }

    public Itinerary(int itineraryId, int tourId, String tourName, int dayNumber, String activityDescription) {
        this.itineraryId = itineraryId;
        this.tourId = tourId;
        this.tourName = tourName;
        this.dayNumber = dayNumber;
        this.activityDescription = activityDescription;
    }

    public Itinerary(int itineraryId, int tourId, String tourName, String destinationName, int dayNumber, String activityDescription, Status status) {
        this.itineraryId = itineraryId;
        this.tourId = tourId;
        this.tourName = tourName;
        this.destinationName = destinationName;
        this.dayNumber = dayNumber;
        this.activityDescription = activityDescription;
        this.status = status;
    }

    public int getItineraryId() {
        return itineraryId;
    }

    public void setItineraryId(int itineraryId) {
        this.itineraryId = itineraryId;
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

    public String getDestinationName() {
        return destinationName;
    }

    public void setDestinationName(String destinationName) {
        this.destinationName = destinationName;
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

    @Override
    public String toString() {
        return "Itinerary{" + "itineraryId=" + itineraryId + ", tourId=" + tourId + ", dayNumber=" + dayNumber + '}';
    }

    @Override
    public int hashCode() {
        return Objects.hash(itineraryId);
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) {
            return true;
        }
        if (object == null || getClass() != object.getClass()) {
            return false;
        }
        Itinerary that = (Itinerary) object;
        return itineraryId == that.itineraryId;
    }
}
