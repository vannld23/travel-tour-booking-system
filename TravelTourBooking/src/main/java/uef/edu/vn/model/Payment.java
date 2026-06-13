/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.model;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Payment {

    private int paymentId;

    private int bookingId;

    private double amount;

    private String paymentMethod;

    private Timestamp paymentDate;

    private String paymentStatus;

    // Hiển thị thông tin JOIN
    private String fullName;

    private String tourName;

    public Payment() {
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }   
    

    public String getFullName() {
        return fullName;   
    }
     public void setFullName(String fullName) {
        this.fullName = fullName;
     }
     public String getTourName() {
        return tourName;
     }
     public void setTourName(String tourName) {
        this.tourName = tourName;
     }
}