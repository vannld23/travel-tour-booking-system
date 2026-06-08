/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.service;

import jakarta.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import uef.edu.vn.model.Customer;

/**
 *
 * @author LENOVO
 */
@Service
public class CustomerService {

    private final List<Customer> customerList = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);
    //Initializing Sample Data

    @PostConstruct

    public void init() {
        add(new Customer(0, "Nguyễn Văn A", "a@example.com"));
        add(new Customer(0, "Trần Thị B", "b@example.com"));
        add(new Customer(0, "Lê Minh C", "c@example.com"));
        add(new Customer(0, "Phạm Văn D", "d@example.com"));
    }
    //Get All Clients

    public List<Customer> findAll() {
        return customerList;
    }
    //Search by ID

    public Customer findById(int id) {
        return customerList.stream()
                .filter(c -> c.getId() == id)
                .findFirst()
                .orElse(null);
    }
    //Add new customers

    public void add(Customer customer) {
        customer.setId(idGenerator.getAndIncrement());
        customerList.add(customer);
    }
    //Update customer information

    public void update(Customer customer) {
        for (int i = 0; i < customerList.size(); i++) {
            if (customerList.get(i).getId() == customer.getId()) {
                customerList.set(i, customer);
                return;
            }
        }
    }
// Xoá theo ID

    public void deleteById(int id) {
        customerList.removeIf(c -> c.getId() == id);
    }
    //Search by name or email

    public List<Customer> search(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return customerList;
        }
        return customerList.stream()
                .filter(c -> c.getName().toLowerCase().contains(keyword.toLowerCase())
                || c.getEmail().toLowerCase().contains(keyword.toLowerCase()))
                .collect(Collectors.toList());
    }
    //Get the list by pagination

    public List<Customer> getPage(List<Customer> list, int page, int size) {
        int from = (page - 1) * size;
        int to = Math.min(from + size, list.size());
        if (from >= list.size()) {
            return new ArrayList<>();
        }
        return list.subList(from, to);
    }
    //Calculate the number of pages needed

    public int countPages(List<Customer> list, int size) {
        return (int) Math.ceil((double) list.size() / size);
    }
}
