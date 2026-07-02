package uef.edu.vn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.dao.UserDAO;
import uef.edu.vn.model.User;

import java.util.List;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {

    private final UserDAO userDAO = new UserDAO();

    @GetMapping({"", "/", "/list"})
    public String list(Model model) {
        List<User> list = userDAO.findAll();
        model.addAttribute("users", list);
        model.addAttribute("activePage", "admin-user");
        return "admin/user/list";
    }

    @GetMapping("/edit")
    public String editForm(@RequestParam int id, Model model) {
        User user = userDAO.findById(id);
        if (user == null) {
            return "redirect:/admin/user/list";
        }
        model.addAttribute("user", user);
        model.addAttribute("activePage", "admin-user");
        return "admin/user/edit";
    }

    @PostMapping("/edit")
    public String edit(
            @RequestParam int userId,
            @RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String phone,
            @RequestParam String address,
            @RequestParam int roleId,
            @RequestParam(value = "isActive", defaultValue = "false") boolean isActive) {

        User user = userDAO.findById(userId);
        if (user != null) {
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRoleId(roleId);
            user.setActive(isActive);
            userDAO.update(user);
        }
        return "redirect:/admin/user/list";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam int id) {
        User user = userDAO.findById(id);
        if (user != null && user.getRoleId() == 1) {
            // Ngăn chặn xóa tài khoản Admin để bảo mật hệ thống
            return "redirect:/admin/user/list?error=cannot_delete_admin";
        }
        userDAO.delete(id);
        return "redirect:/admin/user/list";
    }
}
