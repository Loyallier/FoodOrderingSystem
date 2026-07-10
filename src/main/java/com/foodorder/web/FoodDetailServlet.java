package com.foodorder.web;

import java.io.IOException;

import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/food-detail", "/FoodDetailServlet" })
public class FoodDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int foodId = WebUtil.intParam(request, "foodId", 0);
        AppStore.findFood(foodId)
                .filter(food -> food.isAvailable())
                .ifPresent(food -> request.setAttribute("food", food));
        if (request.getAttribute("food") == null) {
            WebUtil.redirectWithMessage(request, response, "/menu", "error", "Food unavailable: This item is currently unavailable.");
            return;
        }
        WebUtil.forward(request, response, "food-detail.jsp");
    }
}
