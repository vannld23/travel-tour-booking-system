/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uef.edu.vn.dao.DestinationDAO;
import uef.edu.vn.model.Destination;

/**
 *
 * @author LENOVO
 */
@Controller
@RequestMapping("/destination")
public class DestinationController {

    private final DestinationDAO destinationDAO = new DestinationDAO();

    @GetMapping({"", "/", "/list"})
    public String list(Model model) {
        model.addAttribute("destinations", destinationDAO.findAll());
        return "destination/list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("destination", new Destination());
        return "destination/create";
    }

    @PostMapping("/create")
    public String create(@ModelAttribute("destination") Destination destination, Model model) {
        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(destination, "destination");
        validateDestination(destination, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.destination", bindingResult);
            return "destination/create";
        }
        destinationDAO.save(destination);
        return "redirect:/destination/list";
    }

    @GetMapping("/edit")
    public String editForm(@RequestParam int id, Model model) {
        Destination destination = destinationDAO.findById(id);
        if (destination == null) {
            return "redirect:/destination/list";
        }
        model.addAttribute("destination", destination);
        return "destination/edit";
    }

    @PostMapping("/edit")
    public String update(@ModelAttribute("destination") Destination destination, Model model) {
        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(destination, "destination");
        validateDestination(destination, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.destination", bindingResult);
            return "destination/edit";
        }
        destinationDAO.update(destination);
        return "redirect:/destination/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam int id, Model model) {
        Destination destination = destinationDAO.findById(id);
        if (destination == null) {
            return "redirect:/destination/list";
        }
        model.addAttribute("destination", destination);
        return "destination/detail";
    }

    @GetMapping("/delete")
    public String deleteConfirm(@RequestParam int id, Model model) {
        Destination destination = destinationDAO.findById(id);
        if (destination == null) {
            return "redirect:/destination/list";
        }
        model.addAttribute("destination", destination);
        return "destination/delete";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam int id) {
        destinationDAO.delete(id);
        return "redirect:/destination/list";
    }

    private void validateDestination(Destination destination, BeanPropertyBindingResult bindingResult) {
        if (destination.getDestinationName() == null || destination.getDestinationName().trim().isEmpty()) {
            bindingResult.rejectValue("destinationName", "destinationName.required", "Destination name is required");
        }
    }
}
