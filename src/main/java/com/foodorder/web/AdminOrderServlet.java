package com.foodorder.web;

import java.io.IOException;

import com.foodorder.model.Order;
import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/admin/orders", "/AdminOrderServlet" })
public class AdminOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!WebUtil.requireAdmin(request, response)) {
            return;
        }
        request.setAttribute("globalOrderList", AppStore.listAllOrders());
        request.setAttribute("successMessage", request.getParameter("success"));
        WebUtil.forward(request, response, "admin/orders.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!WebUtil.requireAdmin(request, response)) {
            return;
        }
        int orderId = WebUtil.intParam(request, "orderId", 0);
        String status = request.getParameter("status");
        if ("COMPLETED".equals(status)) {
            AppStore.updateOrderStatus(orderId, Order.OrderStatus.COMPLETED);
        } else if ("CANCELLED".equals(status)) {
            AppStore.updateOrderStatus(orderId, Order.OrderStatus.CANCELLED);
        }
        WebUtil.redirectWithMessage(request, response, "/admin/orders", "success", "Order status updated successfully.");
    }
}
