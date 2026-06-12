package uef.edu.vn.service;

import uef.edu.vn.dao.UserDAO;
import uef.edu.vn.model.User;

import java.util.List;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public List<User> getAllUsers() {

        return userDAO.getAllUsers();
    }
}
