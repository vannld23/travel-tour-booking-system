package uef.edu.vn.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import uef.edu.vn.dao.UserDAO;
import uef.edu.vn.model.User;

@Controller
@RequestMapping("/user")
public class UserController {

    private final UserDAO userDAO = new UserDAO();

    @GetMapping("/profile")
    public String profile(
            HttpSession session,
            @RequestParam(required = false) String success,
            Model model) {

        User currentUser
                = (User) session.getAttribute("currentUser");

        if (currentUser == null) {

            return "redirect:/auth/login";
        }

        User user
                = userDAO.findById(currentUser.getUserId());

        if (success != null) {
            model.addAttribute(
                    "success",
                    "Cập nhật thành công.");
        }

        model.addAttribute("user", user);

        return "client/user/profile";
    }

    @PostMapping("/profile")
    public String updateProfile(
            @RequestParam String fullName,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String address,
            HttpSession session,
            Model model) {

        User currentUser
                = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        User user
                = userDAO.findById(currentUser.getUserId());

        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);

        boolean result
                = userDAO.updateProfile(user);

        if (!result) {

            model.addAttribute(
                    "error",
                    "Cập nhật thất bại.");

            model.addAttribute(
                    "user",
                    user);

            return "client/user/profile";
        }

        session.setAttribute(
                "currentUser",
                user);

        return "redirect:/user/profile?success=true";
    }
}
