package com.foodorder.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.stream.Collectors;

import com.foodorder.model.Cart;
import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/cart", "/CartServlet", "/UpdateCartServlet" })
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!WebUtil.requireLogin(request, response)) {
            return;
        }
        request.setAttribute("successMessage", request.getParameter("success"));
        request.setAttribute("errorMessage", request.getParameter("error"));
        WebUtil.forward(request, response, "cart.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!WebUtil.requireLogin(request, response)) {
            return;
        }
        String action = request.getParameter("action");
        Cart cart = WebUtil.cart(request);
        int foodId = WebUtil.intParam(request, "foodId", 0);
        String lineId = request.getParameter("lineId");
        if ((lineId == null || lineId.isBlank()) && foodId > 0) {
            lineId = foodId + "|";
        }

        if ("add".equals(action)) {
            int quantity = WebUtil.intParam(request, "quantity", 1);
            if (quantity < 1) {
                WebUtil.redirectWithMessage(request, response, "/menu", "error", "Quantity must be at least 1.");
                return;
            }
            String addons = addonString(request.getParameterValues("addons"));
            BigDecimal addonPrice = WebUtil.addonPrice(addons);
            AppStore.findFood(foodId).filter(food -> food.isAvailable()).ifPresent(food -> cart.addItem(food, quantity, addons, addonPrice));
            WebUtil.redirectWithMessage(request, response, "/cart", "success", "Item added to cart successfully.");
            return;
        }

        if ("update".equals(action)) {
            int quantity = WebUtil.intParam(request, "quantity", 1);
            cart.updateQuantity(lineId, quantity);
            WebUtil.redirectWithMessage(request, response, "/cart", "success", "Cart updated successfully.");
            return;
        }

        if ("remove".equals(action)) {
            cart.removeItem(lineId);
            WebUtil.redirectWithMessage(request, response, "/cart", "success", "Item removed from cart.");
            return;
        }

        WebUtil.redirect(request, response, "/cart");
    }

    private String addonString(String[] addons) {
        if (addons == null || addons.length == 0) {
            return "";
        }
        return Arrays.stream(addons).filter(value -> value != null && !value.isBlank()).collect(Collectors.joining(", "));
    }
}
