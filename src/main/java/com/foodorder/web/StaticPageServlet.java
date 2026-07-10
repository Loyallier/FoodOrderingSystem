package com.foodorder.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/about", "/faq", "/contact" })
public class StaticPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/about".equals(path)) {
            WebUtil.forward(request, response, "about.jsp");
        } else if ("/faq".equals(path)) {
            WebUtil.forward(request, response, "faq.jsp");
        } else {
            WebUtil.forward(request, response, "contact.jsp");
        }
    }
}
