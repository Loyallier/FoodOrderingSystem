package com.foodorder.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.foodorder.model.Cart;
import com.foodorder.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public final class WebUtil {
    private WebUtil() {
    }

    public static void forward(HttpServletRequest request, HttpServletResponse response, String jsp)
            throws ServletException, IOException {
        request.getRequestDispatcher("/" + jsp).forward(request, response);
    }

    public static void redirect(HttpServletRequest request, HttpServletResponse response, String path)
            throws IOException {
        response.sendRedirect(request.getContextPath() + path);
    }

    public static void redirectWithMessage(HttpServletRequest request, HttpServletResponse response,
            String path, String messageType, String message) throws IOException {
        String separator = path.contains("?") ? "&" : "?";
        response.sendRedirect(request.getContextPath() + path + separator + messageType + "=" + encode(message));
    }

    public static User currentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object user = session.getAttribute("currentUser");
        return user instanceof User ? (User) user : null;
    }

    public static boolean requireLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (currentUser(request) == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    public static boolean requireAdmin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User user = currentUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        if (!user.isAdmin()) {
            redirectWithMessage(request, response, "/home", "error", "Access denied: Admin only.");
            return false;
        }
        return true;
    }

    public static Cart cart(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Object existing = session.getAttribute("cart");
        if (existing instanceof Cart) {
            return (Cart) existing;
        }
        Cart cart = new Cart();
        session.setAttribute("cart", cart);
        return cart;
    }

    public static int intParam(HttpServletRequest request, String name, int defaultValue) {
        try {
            return Integer.parseInt(request.getParameter(name));
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }

    public static BigDecimal decimalParam(HttpServletRequest request, String name, BigDecimal defaultValue) {
        try {
            return new BigDecimal(request.getParameter(name));
        } catch (Exception ex) {
            return defaultValue;
        }
    }

    public static boolean checkbox(HttpServletRequest request, String name) {
        return request.getParameter(name) != null;
    }

    public static BigDecimal addonPrice(String addons) {
        if (addons == null || addons.isBlank()) {
            return BigDecimal.ZERO;
        }
        BigDecimal total = BigDecimal.ZERO;
        for (String addon : addons.split(",")) {
            String value = addon.trim();
            if ("Extra Cheese".equalsIgnoreCase(value)) {
                total = total.add(new BigDecimal("1.50"));
            } else if ("Drink".equalsIgnoreCase(value)) {
                total = total.add(new BigDecimal("3.00"));
            } else if ("Large Portion".equalsIgnoreCase(value)) {
                total = total.add(new BigDecimal("4.00"));
            }
        }
        return total;
    }

    private static String encode(String value) {
        return URLEncoder.encode(value, StandardCharsets.UTF_8);
    }
}
