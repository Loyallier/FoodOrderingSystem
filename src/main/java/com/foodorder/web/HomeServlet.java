package com.foodorder.web;

import java.io.IOException;

import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("featuredFoodList", AppStore.listFeaturedFoods());
        request.setAttribute("popularFoodList", AppStore.listPopularFoods());
        request.setAttribute("successMessage", request.getParameter("success"));
        request.setAttribute("errorMessage", request.getParameter("error"));
        WebUtil.forward(request, response, "home.jsp");
    }
}
