/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author LENOVO
 */
@Controller
@RequestMapping("/booking")
public class BookingController {

    @GetMapping({"", "/", "/list"})
    public String list() {
        return "admin/booking/list";
    }

    @GetMapping("/history")
    public String history() {
        return "client/booking/history";
    }

    @GetMapping("/detail")
    public String detail() {
        return "admin/booking/detail";
    }

    @GetMapping("/create")
    public String create() {
        return "client/booking/create";
    }
}
