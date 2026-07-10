package com.foodorder.web;

import java.io.IOException;

import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!WebUtil.requireAdmin(request, response)) {
            return;
        }
        request.setAttribute("adminCategoryList", AppStore.listCategories(false));
        request.setAttribute("successMessage", request.getParameter("success"));
        request.setAttribute("errorMessage", request.getParameter("error"));
        WebUtil.forward(request, response, "admin/categories.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!WebUtil.requireAdmin(request, response)) {
            return;
        }
        String action = request.getParameter("action");
        if ("disable".equals(action)) {
            int categoryId = WebUtil.intParam(request, "categoryId", 0);
            AppStore.disableCategory(categoryId);
            WebUtil.redirectWithMessage(request, response, "/admin/categories", "success", "Category disabled successfully.");
            return;
        }
        String name = trim(request.getParameter("categoryName"));
        String description = trim(request.getParameter("description"));
        if (name.isBlank()) {
            WebUtil.redirectWithMessage(request, response, "/admin/categories", "error", "Category name is required.");
            return;
        }
        AppStore.createCategory(name, description, true);
        WebUtil.redirectWithMessage(request, response, "/admin/categories", "success", "Category added successfully.");
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
