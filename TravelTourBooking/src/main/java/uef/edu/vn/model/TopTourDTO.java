package uef.edu.vn.model;

/**
 * DTO representing top booking statistics for a tour.
 */
public class TopTourDTO {
    private String tourName;
    private int bookingCount;
    private int totalPeople;

    public TopTourDTO() {
    }

    public TopTourDTO(String tourName, int bookingCount, int totalPeople) {
        this.tourName = tourName;
        this.bookingCount = bookingCount;
        this.totalPeople = totalPeople;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    public int getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(int bookingCount) {
        this.bookingCount = bookingCount;
    }

    public int getTotalPeople() {
        return totalPeople;
    }

    public void setTotalPeople(int totalPeople) {
        this.totalPeople = totalPeople;
    }
}
