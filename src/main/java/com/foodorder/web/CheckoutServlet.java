package com.foodorder.web;

import java.io.IOException;
import java.time.LocalTime;

import com.foodorder.model.Cart;
import com.foodorder.model.Order;
import com.foodorder.model.User;
import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/checkout", "/CheckoutServlet" })
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!WebUtil.requireLogin(request, response)) {
            return;
        }
        Cart cart = WebUtil.cart(request);
        if (cart.isEmpty()) {
            WebUtil.redirectWithMessage(request, response, "/cart", "error", "Checkout failed: Your cart is empty.");
            return;
        }
        WebUtil.forward(request, response, "checkout.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!WebUtil.requireLogin(request, response)) {
            return;
        }
        User user = WebUtil.currentUser(request);
        Cart cart = WebUtil.cart(request);
        if (cart.isEmpty()) {
            WebUtil.redirectWithMessage(request, response, "/cart", "error", "Checkout failed: Your cart is empty.");
            return;
        }

        String address = trim(request.getParameter("delivery_address"));
        String phone = trim(request.getParameter("contact_phone"));
        String payment = trim(request.getParameter("payment_method"));
        if (address.isBlank() || phone.isBlank() || payment.isBlank()) {
            request.setAttribute("errorMessage", "Please complete delivery address, contact phone, and payment method.");
            WebUtil.forward(request, response, "checkout.jsp");
            return;
        }

        Order order = AppStore.createOrder(user, cart, address, phone, payment);
        cart.clear();
        request.setAttribute("orderId", order.getOrderId());
        request.setAttribute("estimatedTime", LocalTime.now().plusMinutes(35).toString());
        request.setAttribute("finalAmount", order.getTotalAmount());
        WebUtil.forward(request, response, "orderSuccess.jsp");
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
