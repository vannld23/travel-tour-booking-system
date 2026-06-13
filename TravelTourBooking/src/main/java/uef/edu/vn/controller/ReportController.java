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
@RequestMapping("/report")
public class ReportController {

    @GetMapping("/revenue")
    public String revenue() {
        return "admin/report/revenue";
    }

    @GetMapping("/booking-report")
    public String bookingReport() {
        return "admin/report/booking-report";
    }

    @GetMapping("/export")
    public String export() {
        return "admin/report/export";
    }
}
