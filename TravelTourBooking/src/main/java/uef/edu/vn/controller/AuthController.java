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
            model.addAttribute("message", "Đăng ký tài khoản thành công. Vui lòng đăng nhập.");
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
            model.addAttribute("error", "Email hoặc mật khẩu không đúng.");
            model.addAttribute("email", email);
            return "client/auth/login";
        }

        session.setAttribute("currentUser", user);

        // Phân quyền
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

        // Trim inputs
        fullName = fullName != null ? fullName.trim() : "";
        email    = email    != null ? email.trim()    : "";
        password = password != null ? password.trim() : "";
        confirmPassword = confirmPassword != null ? confirmPassword.trim() : "";

        // Carry back entered values
        model.addAttribute("fullName", fullName);
        model.addAttribute("email", email);

        // Validation
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

        // Create user
        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setPhone(phone != null ? phone.trim() : "");
        newUser.setAddress(address != null ? address.trim() : "");
        newUser.setActive(true);
        newUser.setRoleId(2); // CUSTOMER role

        boolean saved = userDAO.save(newUser);

        if (!saved) {
            model.addAttribute("error", "Đăng ký không thành công do lỗi hệ thống. Vui lòng thử lại.");
            return "client/auth/register";
        }

        return "redirect:/auth/login?registerSuccess=true";
    }

    // =========================
    // LOGOUT
    // =========================
    @GetMapping("/logout")
    public String logout(HttpSession session) {
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

        model.addAttribute("message",
                "Liên kết đặt lại mật khẩu đã được gửi tới " + email);

        return "client/auth/forgot-password";
    }

    // =========================
    // CHANGE PASSWORD
    // =========================
    @GetMapping("/change-password")
    public String changePasswordForm(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/auth/login";
        }
        return "client/auth/change-password";
    }

    @PostMapping("/change-password")
    public String changePassword(
            @RequestParam String currentPassword,
            @RequestParam String newPassword,
            @RequestParam String confirmNewPassword,
            HttpSession session,
            Model model) {

        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/auth/login";
        }

        if (!currentPassword.equals(user.getPassword())) {
            model.addAttribute("error", "Mật khẩu hiện tại không đúng.");
            return "client/auth/change-password";
        }

        if (newPassword.length() < 6) {
            model.addAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự.");
            return "client/auth/change-password";
        }

        if (!newPassword.equals(confirmNewPassword)) {
            model.addAttribute("error", "Xác nhận mật khẩu mới không khớp.");
            return "client/auth/change-password";
        }

        user.setPassword(newPassword);
        boolean updated = userDAO.updateProfile(user);

        if (updated) {
            session.setAttribute("currentUser", user);
            model.addAttribute("message", "Đổi mật khẩu thành công.");
        } else {
            model.addAttribute("error", "Đổi mật khẩu thất bại. Vui lòng thử lại.");
        }

        return "client/auth/change-password";
    }
}
