package uef.edu.vn.controller;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import uef.edu.vn.service.ExportService;

/**
 * Controller xu ly xuat file Excel va PDF.
 *
 * URL:
 *   GET /export/bookings/excel      -> Xuat danh sach tat ca booking ra Excel
 *   GET /export/invoice/pdf/{id}    -> Xuat hoa don 1 booking ra PDF
 *   GET /export/revenue/excel       -> Xuat bao cao doanh thu ra Excel
 */
@Controller
@RequestMapping("/export")
public class ExportController {

    private final ExportService exportService = new ExportService();

    /**
     * Xuat danh sach booking ra file Excel (.xlsx)
     */
    @GetMapping("/bookings/excel")
    public void exportBookingsExcel(HttpServletResponse response) {
        try {
            exportService.exportBookingsToExcel(response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Xuat hoa don PDF cho mot booking cu the
     */
    @GetMapping("/invoice/pdf/{id}")
    public void exportInvoicePdf(
            @PathVariable("id") int bookingId,
            HttpServletResponse response) {
        try {
            exportService.exportBookingInvoicePdf(bookingId, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Xuat bao cao doanh thu theo thang ra file Excel (.xlsx)
     */
    @GetMapping("/revenue/excel")
    public void exportRevenueExcel(HttpServletResponse response) {
        try {
            exportService.exportRevenueToExcel(response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
