package com.foodorder.web;

import java.io.IOException;

import com.foodorder.model.User;
import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/orders/history")
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!WebUtil.requireLogin(request, response)) {
            return;
        }
        User user = WebUtil.currentUser(request);
        request.setAttribute("userOrderList", AppStore.listOrdersByUser(user.getUserId()));
        WebUtil.forward(request, response, "order-history.jsp");
    }
}
