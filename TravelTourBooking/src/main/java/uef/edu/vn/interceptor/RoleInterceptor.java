package uef.edu.vn.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import uef.edu.vn.model.User;

/**
 * RoleInterceptor kiểm tra quyền truy cập vào các trang quản trị (admin).
 *
 * Quy tắc (cấu hình trong dispatcher-servlet.xml):
 *  - Đường dẫn được bảo vệ: /dashboard/**, /admin/**, /booking/**,
 *                            /tuormanagement/**, /destination/**, /itinerary/**,
 *                            /payment/**, /system/**
 *  - Đường dẫn được loại trừ: /booking/create, /booking/history/**, /payment/history/**
 *
 * Chỉ cho phép truy cập khi người dùng đã đăng nhập và có roleId == 1 (Admin).
 * Các trường hợp còn lại sẽ bị chuyển hướng về trang đăng nhập hoặc trang chủ.
 */
public class RoleInterceptor implements HandlerInterceptor {

    /** roleId của Admin trong hệ thống */
    private static final int ADMIN_ROLE_ID = 1;

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false);

        // Chưa có phiên đăng nhập → chuyển đến trang đăng nhập
        if (session == null) {
            chuyenHuongDangNhap(request, response);
            return false;
        }

        User nguoiDungHienTai = (User) session.getAttribute("currentUser");

        // Chưa đăng nhập → chuyển đến trang đăng nhập
        if (nguoiDungHienTai == null) {
            chuyenHuongDangNhap(request, response);
            return false;
        }

        // Đã đăng nhập nhưng không phải Admin → chuyển về trang chủ
        if (nguoiDungHienTai.getRoleId() != ADMIN_ROLE_ID) {
            response.sendRedirect(request.getContextPath() + "/");
            return false;
        }

        // Hợp lệ → cho phép tiếp tục
        return true;
    }

    // -------------------------------------------------------------------------
    // Phương thức hỗ trợ
    // -------------------------------------------------------------------------

    /**
     * Chuyển hướng người dùng về trang đăng nhập.
     */
    private void chuyenHuongDangNhap(HttpServletRequest request,
                                     HttpServletResponse response) throws Exception {
        response.sendRedirect(request.getContextPath() + "/auth/login");
    }
}
