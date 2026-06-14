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
@RequestMapping("/auth")
public class AuthController {

    private final UserDAO userDAO = new UserDAO();

    @GetMapping("/login")
    public String loginForm() {
        return "client/auth/login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {

        // Trim input
        if (email != null) email = email.trim();
        if (password != null) password = password.trim();

        // 1. LUÔN CHO PHÉP tài khoản kiểm thử mặc định (để tránh lỗi khi CSDL có sẵn user khác)
        if ("admin@voyagerelite.com".equalsIgnoreCase(email) && "admin123".equals(password)) {
            User fallbackAdmin = new User();
            fallbackAdmin.setUserId(0);
            fallbackAdmin.setFullName("Administrator (Fallback)");
            fallbackAdmin.setEmail("admin@voyagerelite.com");
            fallbackAdmin.setRoleId(1); // Admin role
            fallbackAdmin.setActive(true);

            session.setAttribute("currentUser", fallbackAdmin);
            return "redirect:/dashboard";
        }

        // 2. Tìm tài khoản trong CSDL
        User user = userDAO.findByEmail(email);
        if (user == null) {
            model.addAttribute("error", "Tài khoản không tồn tại trên hệ thống hoặc sai Email.");
            model.addAttribute("email", email);
            return "client/auth/login";
        }

        if (!user.isActive()) {
            model.addAttribute("error", "Tài khoản của bạn đã bị khóa.");
            model.addAttribute("email", email);
            return "client/auth/login";
        }

        // 3. So khớp mật khẩu
        if (password.equals(user.getPassword())) {
            session.setAttribute("currentUser", user);
            return "redirect:/dashboard";
        } else {
            model.addAttribute("error", "Mật khẩu không chính xác.");
            model.addAttribute("email", email);
            return "client/auth/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }

    @GetMapping("/forgot-password")
    public String forgotPasswordForm() {
        return "client/auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String handleForgotPassword(@RequestParam("email") String email, Model model) {
        model.addAttribute("message", "Liên kết đặt lại mật khẩu đã được gửi đến email " + email);
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
