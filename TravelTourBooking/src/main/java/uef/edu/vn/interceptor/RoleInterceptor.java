package uef.edu.vn.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import uef.edu.vn.model.User;

public class RoleInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        // Chưa đăng nhập
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return false;
        }

        // Không phải Admin (roleId != 1)
        if (currentUser.getRoleId() != 1) {
            response.sendRedirect(request.getContextPath() + "/user/profile");
            return false;
        }

        return true;
    }
}
