/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.model;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

/**
 *
 * @author LENOVO
 */
public class OrderDetail {

    private Order order; // Liên kết ngược (tùy chọn)
    @NotNull(message = "Sản phẩm không được để trống")
    private Product product;
    @Min(value = 1, message = "Số lượng phải từ 1 trở lên")
    private int quantity;
// --- Constructors ---

    public OrderDetail() {
    }

    public OrderDetail(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }
// --- Getters & Setters ---

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "OrderDetail{"
                + "product=" + product
                + ", quantity=" + quantity
                + '}';
    }
}
