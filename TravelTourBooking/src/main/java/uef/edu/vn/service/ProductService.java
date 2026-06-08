/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.service;

import jakarta.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import org.springframework.stereotype.Service;
import uef.edu.vn.model.Product;

/**
 *
 * @author LENOVO
 */
@Service
public class ProductService {

    private final List<Product> productList = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);
    //Initialize sample data after starting the app
@PostConstruct

    public void init() {
        add(new Product(0, "Laptop", 20000000));
        add(new Product(0, "Chuột không dây", 500000));
        add(new Product(0, "Bàn phím cơ", 800000));
    }

    /**
     * Return a list of all products
     * @return 
     */
    public List<Product> findAll() {
        return productList;
    }

    /**
     * Find products by ID Product ID @param Product @return or null if not
     * found
     * @param id
     * @return 
     */
    public Product findById(int id) {
        return productList.stream()
                .filter(p -> p.getId() == id)
                .findFirst()
                .orElse(null);
    }

    /**
     * Add new products (automatic ID assignment)
     *
     * @param product
     */
    public void add(Product product) {
        product.setId(idGenerator.getAndIncrement());
        productList.add(product);
    }

    /**
     * Update product information by ID
     *
     * @param product products need to be updated
     */
    public void update(Product product) {
        for (int i = 0; i < productList.size(); i++) {
            if (productList.get(i).getId() == product.getId()) {
                productList.set(i, product);
                return;
            }
        }
    }

    /**
     * Remove products from the list by ID
     *
     * @param id
     */
    public void deleteById(int id) {
        productList.removeIf(p -> p.getId() == id);
    }

    /**
     * Search for products by keyword (name or 1 part of the name)
     *
     * @param keyword
     * @return suitable product list
     */
    public List<Product> search(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return productList;
        }
        return productList.stream()
                .filter(p -> p.getName().toLowerCase().contains(keyword.toLowerCase()))
                .toList();
    }

    /**
     * Returns paginated listings
     *
     * @param list
     * @param page
     * @param size of the number of lines per page
     * @return 
     */
    public List<Product> getPage(List<Product> list, int page, int size) {
        int from = (page - 1) * size;
        int to = Math.min(from + size, list.size());
        if (from >= list.size()) {
            return new ArrayList<>();
        }
        return list.subList(from, to);
    }

    /**
     * Calculate the total number of pages from the list and page size
     * @param list
     * @param size
     * @return 
     */
    public int countPages(List<Product> list, int size) {
        return (int) Math.ceil((double) list.size() / size);
    }
}
