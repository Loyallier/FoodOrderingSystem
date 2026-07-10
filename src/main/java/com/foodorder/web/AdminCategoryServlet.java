package com.foodorder.web;

import java.io.IOException;

import com.foodorder.store.AppStore;
import com.foodorder.store.DataAccessException;

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
        int editCategoryId = WebUtil.intParam(request, "editCategoryId", 0);
        if (editCategoryId > 0) {
            request.setAttribute("editCategory", AppStore.findCategory(editCategoryId).orElse(null));
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
        if ("delete".equals(action)) {
            int categoryId = WebUtil.intParam(request, "categoryId", 0);
            if (categoryId <= 0) {
                WebUtil.redirectWithMessage(request, response, "/admin/categories", "error", "Category is required for delete.");
                return;
            }
            try {
                AppStore.deleteCategory(categoryId);
                WebUtil.redirectWithMessage(request, response, "/admin/categories", "success", "Category deleted successfully.");
            } catch (DataAccessException ex) {
                WebUtil.redirectWithMessage(request, response, "/admin/categories", "error",
                        "Category could not be deleted because it is used by existing foods.");
            }
            return;
        }
        int categoryId = WebUtil.intParam(request, "categoryId", 0);
        String name = trim(request.getParameter("categoryName"));
        String description = trim(request.getParameter("description"));
        if (name.isBlank()) {
            WebUtil.redirectWithMessage(request, response, "/admin/categories", "error", "Category name is required.");
            return;
        }
        AppStore.saveCategory(categoryId, name, description);
        String message = categoryId > 0 ? "Category edited successfully." : "Category added successfully.";
        WebUtil.redirectWithMessage(request, response, "/admin/categories", "success", message);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
