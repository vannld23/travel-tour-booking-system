package uef.edu.vn.interceptor;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

/**
 * Global Exception Handler cho toan bo ung dung Spring MVC.
 * Giup bat tat ca cac loai exception (Database error, NullPointer, Syntax...)
 * va hien thi trang loi 500/404 dep cho nguoi dung, tranh lo thong tin bao mat (stack trace).
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    /**
     * Xu ly loi 404 Not Found (khi khong tim thay URL hop le)
     */
    @ExceptionHandler(NoHandlerFoundException.class)
    public String handle404(NoHandlerFoundException ex, Model model) {
        model.addAttribute("errorTitle", "Trang khong ton tai (404)");
        model.addAttribute("errorMessage", "Duong dan ban truy cap khong ton tai hoac da bi xoa.");
        return "client/error/404";
    }

    /**
     * Xu ly tat ca cac loai Exception con lai (Loi 500 - Database, System, Runtime...)
     */
    @ExceptionHandler(Exception.class)
    public String handleAllExceptions(Exception ex, Model model) {
        // Ghi log chi tiet ra console de lap trinh vien fix bug
        System.err.println("===== GLOBL EXCEPTION CAUGHT =====");
        ex.printStackTrace();

        model.addAttribute("errorTitle", "Loi he thong (500)");
        model.addAttribute("errorMessage", "He thong dang gap su co ket noi. Vui long thu lai sau.");
        
        // Co the truyen them thong tin loi rut gon neu can
        model.addAttribute("exceptionType", ex.getClass().getSimpleName());
        model.addAttribute("exceptionMessage", ex.getMessage());
        
        return "client/error/500";
    }
}
