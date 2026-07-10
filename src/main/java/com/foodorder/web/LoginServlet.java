package com.foodorder.web;

import java.io.IOException;

import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/login", "/LoginServlet" })
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("successMessage", request.getParameter("success"));
        WebUtil.forward(request, response, "login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String loginKey = request.getParameter("loginKey");
        String password = request.getParameter("password");
        AppStore.authenticate(loginKey, password).ifPresentOrElse(user -> {
            request.getSession().setAttribute("currentUser", user);
            try {
                if (user.isAdmin()) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
            } catch (IOException ex) {
                throw new IllegalStateException(ex);
            }
        }, () -> {
            try {
                request.setAttribute("loginError", "Login failed: Invalid email or password.");
                WebUtil.forward(request, response, "login.jsp");
            } catch (ServletException | IOException ex) {
                throw new IllegalStateException(ex);
            }
        });
    }
}
