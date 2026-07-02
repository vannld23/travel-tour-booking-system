package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.dao.VoucherDAO;
import uef.edu.vn.model.Voucher;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@Controller
@RequestMapping("/admin/voucher")
public class VoucherController {

    private final VoucherDAO voucherDAO = new VoucherDAO();

    @GetMapping({"", "/", "/list"})
    public String list(Model model) {
        List<Voucher> list = voucherDAO.findAll();
        model.addAttribute("vouchers", list);
        model.addAttribute("activePage", "admin-voucher");
        return "admin/voucher/list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("voucher", new Voucher());
        model.addAttribute("activePage", "admin-voucher");
        return "admin/voucher/create";
    }

    @PostMapping("/create")
    public String create(
            @RequestParam String code,
            @RequestParam double discountPercentage,
            @RequestParam(required = false) Double maxDiscountAmount,
            @RequestParam(required = false) Double minOrderAmount,
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam(defaultValue = "100") int usageLimit,
            @RequestParam(defaultValue = "ACTIVE") String status) {

        Voucher voucher = new Voucher();
        voucher.setCode(code);
        voucher.setDiscountPercentage(BigDecimal.valueOf(discountPercentage));
        voucher.setMaxDiscountAmount(maxDiscountAmount != null ? BigDecimal.valueOf(maxDiscountAmount) : BigDecimal.ZERO);
        voucher.setMinOrderAmount(minOrderAmount != null ? BigDecimal.valueOf(minOrderAmount) : BigDecimal.ZERO);
        try {
            voucher.setStartDate(Date.valueOf(startDate));
            voucher.setEndDate(Date.valueOf(endDate));
        } catch (Exception ignored) {}
        voucher.setUsageLimit(usageLimit);
        voucher.setStatus(status);

        voucherDAO.save(voucher);
        return "redirect:/admin/voucher/list";
    }

    @GetMapping("/edit")
    public String editForm(@RequestParam int id, Model model) {
        Voucher voucher = voucherDAO.findById(id);
        if (voucher == null) {
            return "redirect:/admin/voucher/list";
        }
        model.addAttribute("voucher", voucher);
        model.addAttribute("activePage", "admin-voucher");
        return "admin/voucher/edit";
    }

    @PostMapping("/edit")
    public String edit(
            @RequestParam int voucherId,
            @RequestParam String code,
            @RequestParam double discountPercentage,
            @RequestParam(required = false) Double maxDiscountAmount,
            @RequestParam(required = false) Double minOrderAmount,
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam int usageLimit,
            @RequestParam String status) {

        Voucher voucher = voucherDAO.findById(voucherId);
        if (voucher != null) {
            voucher.setCode(code);
            voucher.setDiscountPercentage(BigDecimal.valueOf(discountPercentage));
            voucher.setMaxDiscountAmount(maxDiscountAmount != null ? BigDecimal.valueOf(maxDiscountAmount) : BigDecimal.ZERO);
            voucher.setMinOrderAmount(minOrderAmount != null ? BigDecimal.valueOf(minOrderAmount) : BigDecimal.ZERO);
            try {
                voucher.setStartDate(Date.valueOf(startDate));
                voucher.setEndDate(Date.valueOf(endDate));
            } catch (Exception ignored) {}
            voucher.setUsageLimit(usageLimit);
            voucher.setStatus(status);
            voucherDAO.update(voucher);
        }
        return "redirect:/admin/voucher/list";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam int id) {
        voucherDAO.delete(id);
        return "redirect:/admin/voucher/list";
    }
}
