/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import uef.edu.vn.model.Customer;
import uef.edu.vn.service.CustomerService;

/**
 *
 * @author LENOVO
 */
@Controller
@RequestMapping("/customers")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("customers", customerService.findAll());
        model.addAttribute("body", "/WEB-INF/views/customer/list.jsp");
        return "layout/main";
    }

    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("customer", new Customer());
        model.addAttribute("body", "/WEB-INF/views/customer/form.jsp");
        return "layout/main";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute Customer customer) {
        if (customer.getId() == 0) {
            customerService.add(customer);
        } else {
            customerService.update(customer);
        }
        return "redirect:/customers";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model) {
        model.addAttribute("customer", customerService.findById(id));
        model.addAttribute("body", "/WEB-INF/views/customer/form.jsp");
        return "layout/main";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        customerService.deleteById(id);
        return "redirect:/customers";
    }
}
