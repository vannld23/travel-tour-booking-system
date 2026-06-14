package uef.edu.vn.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import uef.edu.vn.dao.UserDAO;
import uef.edu.vn.model.User;

@Controller
@RequestMapping("/auth")
public class AuthController {

    private final UserDAO userDAO = new UserDAO();

    // =========================
    // LOGIN
    // =========================
    @GetMapping("/login")
    public String loginForm(HttpSession session,
            @RequestParam(required = false) String registerSuccess,
            Model model) {
        if (session.getAttribute("currentUser") != null) {

            return "redirect:/";
        }

        if (registerSuccess != null) {

            model.addAttribute(
                    "message",
                    "Đăng ký tài khoản thành công. Vui lòng đăng nhập.");
        }
        return "client/auth/login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        User user = userDAO.login(email, password);

        if (user == null) {

            model.addAttribute(
                    "error",
                    "Email hoặc mật khẩu không đúng.");

            model.addAttribute(
                    "email",
                    email);

            return "client/auth/login";
        }

        session.setAttribute(
                "currentUser",
                user);

        // phân quyền
        if (user.getRoleId() == 1) {

            return "redirect:/admin/dashboard";
        }

        return "redirect:/";
    }

    // =========================
    // REGISTER
    // =========================
    @GetMapping("/register")
    public String registerForm() {

        return "client/auth/register";
    }

    @PostMapping("/register")
    public String register(
            @RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String address,
            Model model) {

        if (!password.equals(confirmPassword)) {

            model.addAttribute(
                    "error",
                    "Mật khẩu xác nhận không khớp.");

            return "client/auth/register";
        }

        if (userDAO.emailExists(email)) {

            model.addAttribute(
                    "error",
                    "Email đã tồn tại.");

            return "client/auth/register";
        }

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setAddress(address);

        // CUSTOMER
        user.setRoleId(2);

        boolean result
                = userDAO.insertUser(user);

        if (!result) {

            model.addAttribute(
                    "error",
                    "Đăng ký thất bại.");

            return "client/auth/register";
        }

        return "redirect:/auth/login?registerSuccess=true";
    }

    // =========================
    // LOGOUT
    // =========================
    @GetMapping("/logout")
    public String logout(
            HttpSession session) {

        session.invalidate();

        return "redirect:/auth/login";
    }

    // =========================
    // FORGOT PASSWORD
    // =========================
    @GetMapping("/forgot-password")
    public String forgotPasswordForm() {

        return "client/auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String forgotPassword(
            @RequestParam String email,
            Model model) {

        model.addAttribute(
                "message",
                "Liên kết đặt lại mật khẩu đã được gửi tới "
                + email);

        return "client/auth/forgot-password";
    }

    @GetMapping("/register")
    public String registerForm() {
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String register(
            @RequestParam("fullName") String fullName,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword,
            Model model) {

        fullName = fullName != null ? fullName.trim() : "";
        email = email != null ? email.trim() : "";
        password = password != null ? password.trim() : "";
        confirmPassword = confirmPassword != null ? confirmPassword.trim() : "";

        model.addAttribute("fullName", fullName);
        model.addAttribute("email", email);

        if (fullName.isEmpty() || email.isEmpty() || password.isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập đầy đủ các trường thông tin bắt buộc.");
            return "client/auth/register";
        }

        if (password.length() < 6) {
            model.addAttribute("error", "Mật khẩu phải có độ dài tối thiểu 6 ký tự.");
            return "client/auth/register";
        }

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp.");
            return "client/auth/register";
        }

        if (userDAO.findByEmail(email) != null) {
            model.addAttribute("error", "Địa chỉ email này đã được sử dụng.");
            return "client/auth/register";
        }

        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setPhone("");
        newUser.setAddress("");
        newUser.setActive(true);
        newUser.setRoleId(2); // CUSTOMER role

        boolean saved = userDAO.save(newUser);
        if (saved) {
            return "redirect:/auth/login";
        } else {
            model.addAttribute("error", "Đăng ký không thành công do lỗi hệ thống.");
            return "client/auth/register";
        }
    }
}
