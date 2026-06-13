package uef.edu.vn.service;

import java.util.List;
import uef.edu.vn.dao.UserDAO;
import uef.edu.vn.model.User;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    /**
     * Lấy toàn bộ danh sách người dùng (dùng trong BookingController).
     */
    public List<User> getAllUsers() {
        return userDAO.findAll();
    }

    /**
     * Tìm người dùng theo email.
     */
    public User getUserByEmail(String email) {
        return userDAO.findByEmail(email);
    }
}
