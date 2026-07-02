package uef.edu.vn.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import uef.edu.vn.model.User;

/**
 * RoleInterceptor kiem tra quyen truy cap vao cac trang quan tri (admin).
 *
 * He thong phan quyen:
 *   roleId = 1 : ADMIN       - Toan quyen
 *   roleId = 2 : CUSTOMER    - Chi xem trang client
 *   roleId = 3 : STAFF       - Xu ly booking, payment hang ngay; khong xoa du lieu chinh
 *   roleId = 4 : MANAGER     - Xem bao cao, quan ly gia/lich trinh; khong quan ly user
 */
public class RoleInterceptor implements HandlerInterceptor {

    private static final int ADMIN    = 1;
    private static final int CUSTOMER = 2;
    private static final int STAFF    = 3;
    private static final int MANAGER  = 4;

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return false;
        }

        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return false;
        }

        int roleId = user.getRoleId();
        String path = request.getRequestURI();
        String ctx  = request.getContextPath();

        // CUSTOMER khong co quyen vao khu admin
        if (roleId == CUSTOMER) {
            response.sendRedirect(ctx + "/");
            return false;
        }

        // Chi ADMIN moi quan ly users va system
        if (path.startsWith(ctx + "/admin/user") || path.startsWith(ctx + "/system")) {
            if (roleId != ADMIN) {
                response.sendRedirect(ctx + "/admin/dashboard");
                return false;
            }
        }

        // ADMIN, STAFF, MANAGER deu co the vao admin dashboard va booking/payment/tour/destination
        // (STAFF va MANAGER khong xoa, nhung controller se tu xu ly)
        return true;
    }
}
