/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uef.edu.vn.model.Customer;
import uef.edu.vn.model.Order;
import uef.edu.vn.model.OrderDetail;
import uef.edu.vn.model.Product;

/**
 *
 * @author LENOVO
 */
@Service
public class OrderService {

    private final List<Order> orderList = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);
    @Autowired
    private CustomerService customerService;
    @Autowired
    private ProductService productService;

    /**
     * Save orders: add new or update
     */
    public void save(Order order) {
        if (order.getId() == 0) {
            order.setId(idGenerator.getAndIncrement());
        } else {
            deleteById(order.getId());
        }
//Full customer reassignment
        Customer fullCustomer = customerService.findById(order.getCustomer().getId());
        order.setCustomer(fullCustomer);
// Reassign product information in each OrderDetail
        for (OrderDetail d : order.getDetails()) {
            Product p = productService.findById(d.getProduct().getId());
            d.setProduct(p);
            d.setOrder(order); // nếu OrderDetail có thuộc tính order
        }
        orderList.add(order);
    }

    /**
     * Trả về tất cả đơn hàng
     */
    public List<Order> findAll() {
        return orderList;
    }

    /**
     * Find orders by ID
     */
    public Order findById(int id) {
        return orderList.stream()
                .filter(o -> o.getId() == id)
                .findFirst()
                .orElse(null);
    }

    /**
     * Delete orders by ID
     */
    public void deleteById(int id) {
        orderList.removeIf(o -> o.getId() == id);
    }

    /**
     * Search for orders by customer name
     */
    public List<Order> search(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return orderList;
        }
        return orderList.stream()
                .filter(o
                        -> o.getCustomer().getName().toLowerCase().contains(keyword.toLowerCase()))
                .collect(Collectors.toList());
    }

    /**
     * Returns an order list for a specific page
     */
    public List<Order> getPage(List<Order> list, int page, int size) {
        int from = (page - 1) * size;
        int to = Math.min(from + size, list.size());
        if (from >= list.size()) {
            return new ArrayList<>();
        }
        return list.subList(from, to);
    }

    /**
     * Calculate the total number of pages
     */
    public int countPages(List<Order> list, int size) {
        return (int) Math.ceil((double) list.size() / size);
    }
}
