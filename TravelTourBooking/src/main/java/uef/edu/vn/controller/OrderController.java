package uef.edu.vn.controller;

import jakarta.validation.Valid;
import java.time.LocalDate;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uef.edu.vn.model.Order;
import uef.edu.vn.service.CustomerService;
import uef.edu.vn.service.OrderService;
import uef.edu.vn.service.ProductService;

@Controller
@RequestMapping("/orders")
public class OrderController {
@Autowired
private OrderService orderService;

@Autowired
private CustomerService customerService;

@Autowired
private ProductService productService;

@GetMapping
public String listOrders(
        @RequestParam(name = "page", defaultValue = "1") int page,
        @RequestParam(name = "keyword", required = false) String keyword,
        Model model) {

    List<Order> filtered = orderService.search(keyword);

    int size = 5;

    model.addAttribute("orders",
            orderService.getPage(filtered, page, size));

    model.addAttribute("totalPages",
            orderService.countPages(filtered, size));

    model.addAttribute("currentPage", page);

    model.addAttribute("keyword", keyword);

    model.addAttribute("body",
            "/WEB-INF/views/order/list.jsp");

    return "layout/main";
}

@GetMapping("/create")
public String showCreateForm(Model model) {

    Order order = new Order();

    order.setOrderDate(LocalDate.now());

    model.addAttribute("order", order);

    model.addAttribute("customers",
            customerService.findAll());

    model.addAttribute("products",
            productService.findAll());

    model.addAttribute("body",
            "/WEB-INF/views/order/form.jsp");

    return "layout/main";
}

@GetMapping("/edit/{id}")
public String showEditForm(
        @PathVariable int id,
        Model model) {

    Order order = orderService.findById(id);

    if (order == null) {
        return "redirect:/orders";
    }

    model.addAttribute("order", order);

    model.addAttribute("customers",
            customerService.findAll());

    model.addAttribute("products",
            productService.findAll());

    model.addAttribute("body",
            "/WEB-INF/views/order/form.jsp");

    return "layout/main";
}

@PostMapping("/save")
public String saveOrder(
        @ModelAttribute("order")
        @Valid Order order,
        BindingResult result,
        Model model) {

    if (result.hasErrors()) {

        model.addAttribute("customers",
                customerService.findAll());

        model.addAttribute("products",
                productService.findAll());

        model.addAttribute("body",
                "/WEB-INF/views/order/form.jsp");

        return "layout/main";
    }

    orderService.save(order);

    return "redirect:/orders";
}

@GetMapping("/delete/{id}")
public String deleteOrder(@PathVariable int id) {

    orderService.deleteById(id);

    return "redirect:/orders";
}
}
