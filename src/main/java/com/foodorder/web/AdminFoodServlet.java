package com.foodorder.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import com.foodorder.store.AppStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
@WebServlet({ "/admin/foods", "/AdminMenuServlet", "/AdminSaveFoodServlet", "/AdminDeleteFoodServlet" })
public class AdminFoodServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!WebUtil.requireAdmin(request, response)) {
            return;
        }
        if ("/AdminDeleteFoodServlet".equals(request.getServletPath())) {
            disableFood(request, response);
            return;
        }
        String action = request.getParameter("action");
        if ("disable".equals(action)) {
            disableFood(request, response);
            return;
        }

        String foodName = trim(request.getParameter("foodName"));
        int categoryId = WebUtil.intParam(request, "categoryId", 1);
        String description = trim(request.getParameter("description"));
        String ingredients = trim(request.getParameter("ingredients"));
        String nutrition = trim(request.getParameter("nutrition"));
        BigDecimal price = WebUtil.decimalParam(request, "price", BigDecimal.ZERO);
        double rating = WebUtil.decimalParam(request, "rating", new BigDecimal("4.0")).doubleValue();
        String imageUrl = resolveImageUrl(request);
        boolean available = WebUtil.checkbox(request, "isAvailable");
        boolean featured = WebUtil.checkbox(request, "isFeatured");
        boolean popular = WebUtil.checkbox(request, "isPopular");

        if (foodName.isBlank() || price.compareTo(BigDecimal.ZERO) <= 0) {
            WebUtil.redirectWithMessage(request, response, "/admin/foods", "error", "Food name is required and price must be greater than 0.");
            return;
        }
        int foodId = WebUtil.intParam(request, "foodId", 0);
        AppStore.saveFood(foodId, foodName, categoryId, description, ingredients, nutrition, price, rating,
                imageUrl, available, featured, popular);
        WebUtil.redirectWithMessage(request, response, "/admin/foods", "success", "Food item updated successfully.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!WebUtil.requireAdmin(request, response)) {
            return;
        }
        if ("/AdminDeleteFoodServlet".equals(request.getServletPath())) {
            disableFood(request, response);
            return;
        }
        try {
            request.setAttribute("adminFoodList", AppStore.listFoods(false));
            request.setAttribute("adminCategoryList", AppStore.listCategories(false));
            request.setAttribute("successMessage", request.getParameter("success"));
            request.setAttribute("errorMessage", request.getParameter("error"));
            WebUtil.forward(request, response, "admin/foods.jsp");
        } catch (ServletException ex) {
            throw new IOException(ex);
        }
    }

    private void disableFood(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int foodId = WebUtil.intParam(request, "foodId", 0);
        AppStore.disableFood(foodId);
        WebUtil.redirectWithMessage(request, response, "/admin/foods", "success", "Food item disabled successfully.");
    }

    private String resolveImageUrl(HttpServletRequest request) throws IOException, ServletException {
        Part imagePart = request.getPart("foodImage");
        if (imagePart != null && imagePart.getSize() > 0) {
            String submittedName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String extension = "";
            int dotIndex = submittedName.lastIndexOf('.');
            if (dotIndex >= 0) {
                extension = submittedName.substring(dotIndex).toLowerCase();
            }
            String fileName = UUID.randomUUID() + extension;
            String uploadRoot = request.getServletContext().getRealPath("/assets/uploads");
            if (uploadRoot == null) {
                throw new IOException("Upload directory cannot be resolved by the servlet container.");
            }
            Path uploadDir = Paths.get(uploadRoot);
            Files.createDirectories(uploadDir);
            imagePart.write(uploadDir.resolve(fileName).toString());
            return request.getContextPath() + "/assets/uploads/" + fileName;
        }
        return trim(request.getParameter("imageUrl"));
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
