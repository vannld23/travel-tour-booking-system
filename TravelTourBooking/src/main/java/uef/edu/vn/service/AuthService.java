/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.service;

import uef.edu.vn.dao.UserDAO;
import uef.edu.vn.model.User;

/**
 *
 * @author LENOVO
 */
public class AuthService {

    UserDAO userDAO = new UserDAO();

    public boolean register(User user) {

        if (userDAO.emailExists(user.getEmail())) {
            return false;
        }

        return userDAO.insertUser   (user);
    }

    public User login(String email, String password) {

        return userDAO.login(email, password);
    }
}
