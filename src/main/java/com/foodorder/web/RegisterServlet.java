package com.foodorder.web;

import java.io.IOException;

import com.foodorder.model.User;
import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/register", "/RegisterServlet" })
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        WebUtil.forward(request, response, "register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = trim(request.getParameter("username"));
        String email = trim(request.getParameter("email"));
        String phone = trim(request.getParameter("phone_number"));
        String password = request.getParameter("password") == null ? "" : request.getParameter("password");

        String error = validate(username, email, phone, password);
        if (error != null) {
            request.setAttribute("registerError", error);
            WebUtil.forward(request, response, "register.jsp");
            return;
        }

        AppStore.createUser(username, email, phone, password, User.Role.USER);
        WebUtil.redirectWithMessage(request, response, "/login", "success", "Registration successful. Please login.");
    }

    private String validate(String username, String email, String phone, String password) {
        if (username.length() < 3 || username.length() > 20) {
            return "Username must be 3-20 characters.";
        }
        if (!email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            return "Please enter a valid email address.";
        }
        if (AppStore.emailExists(email)) {
            return "Email already exists.";
        }
        if (AppStore.usernameExists(username)) {
            return "Username already exists.";
        }
        if (phone.isBlank()) {
            return "Phone number is required.";
        }
        if (password.length() < 6) {
            return "Password must be at least 6 characters.";
        }
        return null;
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
