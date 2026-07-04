package com.foodorder.web;

import java.io.IOException;
import java.math.BigDecimal;

import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/foods")
public class AdminFoodServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!WebUtil.requireAdmin(request, response)) {
            return;
        }
        request.setAttribute("adminFoodList", AppStore.listFoods(false));
        request.setAttribute("adminCategoryList", AppStore.listCategories(false));
        request.setAttribute("successMessage", request.getParameter("success"));
        request.setAttribute("errorMessage", request.getParameter("error"));
        WebUtil.forward(request, response, "admin/foods.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!WebUtil.requireAdmin(request, response)) {
            return;
        }
        String action = request.getParameter("action");
        int foodId = WebUtil.intParam(request, "foodId", 0);
        if ("disable".equals(action)) {
            AppStore.disableFood(foodId);
            WebUtil.redirectWithMessage(request, response, "/admin/foods", "success", "Food item disabled successfully.");
            return;
        }

        String foodName = trim(request.getParameter("foodName"));
        int categoryId = WebUtil.intParam(request, "categoryId", 1);
        String description = trim(request.getParameter("description"));
        String ingredients = trim(request.getParameter("ingredients"));
        String nutrition = trim(request.getParameter("nutrition"));
        BigDecimal price = WebUtil.decimalParam(request, "price", BigDecimal.ZERO);
        double rating = WebUtil.decimalParam(request, "rating", new BigDecimal("4.0")).doubleValue();
        String imageUrl = trim(request.getParameter("imageUrl"));
        boolean available = WebUtil.checkbox(request, "isAvailable");
        boolean featured = WebUtil.checkbox(request, "isFeatured");
        boolean popular = WebUtil.checkbox(request, "isPopular");

        if (foodName.isBlank() || price.compareTo(BigDecimal.ZERO) <= 0) {
            WebUtil.redirectWithMessage(request, response, "/admin/foods", "error", "Food name is required and price must be greater than 0.");
            return;
        }
        AppStore.saveFood(foodId, foodName, categoryId, description, ingredients, nutrition, price, rating,
                imageUrl, available, featured, popular);
        WebUtil.redirectWithMessage(request, response, "/admin/foods", "success", "Food item updated successfully.");
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
