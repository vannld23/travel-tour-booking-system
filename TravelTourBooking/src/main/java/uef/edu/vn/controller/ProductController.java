package uef.edu.vn.controller;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import uef.edu.vn.model.Product;
import uef.edu.vn.service.ProductService;

@Controller
@RequestMapping("/products")
public class ProductController {
@Autowired
private ProductService productService;

@GetMapping
public String listProducts(Model model) {

    model.addAttribute("products", productService.findAll());

    model.addAttribute("body",
            "/WEB-INF/views/product/list.jsp");

    return "layout/main";
}

@GetMapping("/add")
public String showAddForm(Model model) {

    model.addAttribute("product", new Product());

    model.addAttribute("body",
            "/WEB-INF/views/product/form.jsp");

    return "layout/main";
}

@GetMapping("/edit/{id}")
public String showEditForm(@PathVariable int id,
        Model model) {

    Product product = productService.findById(id);

    if (product == null) {
        return "redirect:/products";
    }

    model.addAttribute("product", product);

    model.addAttribute("body",
            "/WEB-INF/views/product/form.jsp");

    return "layout/main";
}

@PostMapping("/save")
public String saveProduct(
        @ModelAttribute("product")
        @Valid Product product,
        BindingResult result,
        Model model) {

    if (result.hasErrors()) {

        model.addAttribute("body",
                "/WEB-INF/views/product/form.jsp");

        return "layout/main";
    }

    if (product.getId() == 0) {
        productService.add(product);
    } else {
        productService.update(product);
    }

    return "redirect:/products";
}

@GetMapping("/delete/{id}")
public String deleteProduct(@PathVariable int id) {

    productService.deleteById(id);

    return "redirect:/products";
}
}
