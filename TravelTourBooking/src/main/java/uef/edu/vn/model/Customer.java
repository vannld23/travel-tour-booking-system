/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.model;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class Customer {

    private int id;
    @NotBlank(message = "Name is required")
    private String name;
    @Email(message = "Invalid email")
    private String email;
    private List<Order> orders;
// --- Constructors ---

    public Customer() {
    }

    public Customer(int id, String name, String email) {
        this.id = id;
        this.name = name;
        this.email = email;
    }
// --- Getters & Setters ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }
    // --- Optional: toString() ---

    @Override
    public String toString() {
        return "Customer{"
                + "id=" + id
                + ", name='" + name + '\''
                + ", email='" + email + '\''
                + '}';
    }
}
