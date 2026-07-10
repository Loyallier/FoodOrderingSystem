package com.foodorder.web;

import java.io.IOException;

import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/menu", "/MenuServlet" })
public class MenuServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int categoryId = WebUtil.intParam(request, "categoryId", 0);
        request.setAttribute("categoryList", AppStore.listCategories(true));
        request.setAttribute("foodList", AppStore.listFoodsByCategory(categoryId));
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("successMessage", request.getParameter("success"));
        request.setAttribute("errorMessage", request.getParameter("error"));
        WebUtil.forward(request, response, "menu.jsp");
    }
}
