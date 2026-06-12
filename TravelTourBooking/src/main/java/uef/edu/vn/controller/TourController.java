/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import java.math.BigDecimal;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uef.edu.vn.dao.DestinationDAO;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.model.Tour;

/**
 *
 * @author LENOVO
 */
@Controller
@RequestMapping("/tuormanagement")
public class TourController {

    private final TourDAO tourDAO = new TourDAO();
    private final DestinationDAO destinationDAO = new DestinationDAO();

    @GetMapping({"", "/", "/list"})
    public String list(Model model) {
        model.addAttribute("tours", tourDAO.findAll());
        return "tour/list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("tour", new Tour());
        model.addAttribute("destinations", destinationDAO.findAll());
        return "tour/create";
    }

    @PostMapping("/create")
    public String create(@ModelAttribute("tour") Tour tour, Model model) {
        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(tour, "tour");
        validateTour(tour, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.tour", bindingResult);
            model.addAttribute("destinations", destinationDAO.findAll());
            return "tour/create";
        }
        tourDAO.save(tour);
        return "redirect:/tuormanagement/list";
    }

    @GetMapping("/edit")
    public String editForm(@RequestParam int id, Model model) {
        Tour tour = tourDAO.findById(id);
        if (tour == null) {
            return "redirect:/tuormanagement/list";
        }
        model.addAttribute("tour", tour);
        model.addAttribute("destinations", destinationDAO.findAll());
        return "tour/edit";
    }

    @PostMapping("/edit")
    public String update(@ModelAttribute("tour") Tour tour, Model model) {
        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(tour, "tour");
        validateTour(tour, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.tour", bindingResult);
            model.addAttribute("destinations", destinationDAO.findAll());
            return "tour/edit";
        }
        tourDAO.update(tour);
        return "redirect:/tuormanagement/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam int id, Model model) {
        Tour tour = tourDAO.findById(id);
        if (tour == null) {
            return "redirect:/tuormanagement/list";
        }
        model.addAttribute("tour", tour);
        model.addAttribute("schedules", new uef.edu.vn.dao.ScheduleDAO().findByTourId(id));
        return "tour/detail";
    }

    @GetMapping("/delete")
    public String deleteConfirm(@RequestParam int id, Model model) {
        Tour tour = tourDAO.findById(id);
        if (tour == null) {
            return "redirect:/tuormanagement/list";
        }
        model.addAttribute("tour", tour);
        return "tour/delete";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam int id) {
        tourDAO.delete(id);
        return "redirect:/tuormanagement/list";
    }

    private void validateTour(Tour tour, BeanPropertyBindingResult bindingResult) {
        if (tour.getTourName() == null || tour.getTourName().trim().isEmpty()) {
            bindingResult.rejectValue("tourName", "tourName.required", "Tour name is required");
        }
        if (tour.getDestinationId() <= 0) {
            bindingResult.rejectValue("destinationId", "destinationId.required", "Destination is required");
        }
        if (tour.getDurationDays() <= 0) {
            bindingResult.rejectValue("durationDays", "durationDays.positive", "Duration must be greater than 0");
        }
        BigDecimal price = tour.getPrice();
        if (price == null) {
            bindingResult.rejectValue("price", "price.required", "Price is required");
        } else if (price.compareTo(BigDecimal.ZERO) < 0) {
            bindingResult.rejectValue("price", "price.min", "Price must be at least 0");
        }
        if (tour.getMaxCapacity() <= 0) {
            bindingResult.rejectValue("maxCapacity", "maxCapacity.positive", "Max capacity must be greater than 0");
        }
    }
}
