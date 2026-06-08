/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.model;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class Order {
    private int id;
    @NotNull(message = "Must choose a customer")
    private Customer customer;
    @NotNull(message = "The order date must not be empty")
    private LocalDate orderDate;
    @Size(min = 1, message = "The order must have at least 1 product")
    private List<OrderDetail> details;
// --- Constructors ---

    public Order() {
    }

    public Order(int id, Customer customer, LocalDate orderDate, List<OrderDetail> details) {
        this.id = id;
        this.customer = customer;
        this.orderDate = orderDate;
        this.details = details;
    }
// --- Getters & Setters ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public List<OrderDetail> getDetails() {
        return details;
    }

    public void setDetails(List<OrderDetail> details) {
        this.details = details;
    }

public double getTotalAmount() {
        if (details == null) {
            return 0;
        }
        return details.stream()
                .mapToDouble(d -> d.getProduct().getPrice() * d.getQuantity())
                .sum();
    }
// --- Optional: toString() ---

    @Override
    public String toString() {
        return "Order{"
                + "id=" + id
                + ", customer=" + customer
                + ", orderDate=" + orderDate
                + ", details=" + details
                + '}';
    }
}
