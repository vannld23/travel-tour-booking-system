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
import uef.edu.vn.dao.ScheduleDAO;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.model.Schedule;

/**
 *
 * @author LENOVO
 */
@Controller
@RequestMapping("/schedule")
public class ScheduleController {

    private final ScheduleDAO scheduleDAO = new ScheduleDAO();
    private final TourDAO tourDAO = new TourDAO();

    @GetMapping({"", "/", "/list"})
    public String list(Model model) {
        model.addAttribute("schedules", scheduleDAO.findAll());
        return "schedule/list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("schedule", new Schedule());
        model.addAttribute("tours", tourDAO.findAll());
        return "schedule/create";
    }

    @PostMapping("/create")
    public String create(@ModelAttribute("schedule") Schedule schedule, Model model) {
        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(schedule, "schedule");
        validateSchedule(schedule, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.schedule", bindingResult);
            model.addAttribute("tours", tourDAO.findAll());
            return "schedule/create";
        }
        scheduleDAO.save(schedule);
        return "redirect:/schedule/list";
    }

    @GetMapping("/edit")
    public String editForm(@RequestParam int id, Model model) {
        Schedule schedule = scheduleDAO.findById(id);
        if (schedule == null) {
            return "redirect:/schedule/list";
        }
        model.addAttribute("schedule", schedule);
        model.addAttribute("tours", tourDAO.findAll());
        return "schedule/edit";
    }

    @PostMapping("/edit")
    public String update(@ModelAttribute("schedule") Schedule schedule, Model model) {
        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(schedule, "schedule");
        validateSchedule(schedule, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("org.springframework.validation.BindingResult.schedule", bindingResult);
            model.addAttribute("tours", tourDAO.findAll());
            return "schedule/edit";
        }
        scheduleDAO.update(schedule);
        return "redirect:/schedule/list";
    }

    @GetMapping("/delete")
    public String deleteConfirm(@RequestParam int id, Model model) {
        Schedule schedule = scheduleDAO.findById(id);
        if (schedule == null) {
            return "redirect:/schedule/list";
        }
        model.addAttribute("schedule", schedule);
        return "schedule/delete";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam int id) {
        scheduleDAO.delete(id);
        return "redirect:/schedule/list";
    }

    private void validateSchedule(Schedule schedule, BeanPropertyBindingResult bindingResult) {
        if (schedule.getTourId() <= 0) {
            bindingResult.rejectValue("tourId", "tourId.required", "Tour is required");
        }
        if (schedule.getDayNumber() <= 0) {
            bindingResult.rejectValue("dayNumber", "dayNumber.positive", "Day number must be greater than 0");
        }
        if (schedule.getActivityDescription() == null || schedule.getActivityDescription().trim().isEmpty()) {
            bindingResult.rejectValue("activityDescription", "activityDescription.required", "Activity description is required");
        }
    }
}
