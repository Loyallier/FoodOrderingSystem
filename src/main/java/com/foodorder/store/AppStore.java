package com.foodorder.store;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import com.foodorder.model.Cart;
import com.foodorder.model.Category;
import com.foodorder.model.Food;
import com.foodorder.model.Order;
import com.foodorder.model.User;

public final class AppStore {
    private static final UserDao USER_DAO = new UserDao();
    private static final CategoryDao CATEGORY_DAO = new CategoryDao();
    private static final FoodDao FOOD_DAO = new FoodDao();
    private static final OrderDao ORDER_DAO = new OrderDao();

    private AppStore() {
    }

    public static User createUser(String username, String email, String phone, String password, User.Role role) {
        return USER_DAO.create(username, email, phone, PasswordUtil.hash(password), role);
    }

    public static Optional<User> authenticate(String loginKey, String password) {
        if (loginKey == null || password == null) {
            return Optional.empty();
        }
        return USER_DAO.findByLoginKey(loginKey)
                .filter(user -> PasswordUtil.matches(password, user.getPassword()));
    }

    public static boolean emailExists(String email) {
        return USER_DAO.emailExists(email);
    }

    public static boolean usernameExists(String username) {
        return USER_DAO.usernameExists(username);
    }

    public static List<User> listUsers() {
        return USER_DAO.listAll();
    }

    public static Category createCategory(String name, String description, boolean available) {
        return CATEGORY_DAO.create(name, description, available);
    }

    public static List<Category> listCategories(boolean onlyAvailable) {
        return CATEGORY_DAO.list(onlyAvailable);
    }

    public static Optional<Category> findCategory(int categoryId) {
        return CATEGORY_DAO.find(categoryId);
    }

    public static void disableCategory(int categoryId) {
        CATEGORY_DAO.disable(categoryId);
    }

    public static Food addFood(String foodName, int categoryId, String description, String ingredients,
            String nutrition, BigDecimal price, double rating, int reviewCount, String imageUrl,
            boolean available, boolean featured, boolean popular) {
        return FOOD_DAO.add(foodName, categoryId, description, ingredients, nutrition, price, rating, reviewCount,
                imageUrl, available, featured, popular);
    }

    public static void saveFood(int foodId, String foodName, int categoryId, String description,
            String ingredients, String nutrition, BigDecimal price, double rating, String imageUrl,
            boolean available, boolean featured, boolean popular) {
        FOOD_DAO.save(foodId, foodName, categoryId, description, ingredients, nutrition, price, rating, imageUrl,
                available, featured, popular);
    }

    public static void disableFood(int foodId) {
        FOOD_DAO.disable(foodId);
    }

    public static List<Food> listFoods(boolean onlyAvailable) {
        return FOOD_DAO.list(onlyAvailable);
    }

    public static List<Food> listFoodsByCategory(int categoryId) {
        return FOOD_DAO.listByCategory(categoryId);
    }

    public static List<Food> listFeaturedFoods() {
        return FOOD_DAO.listFeatured();
    }

    public static List<Food> listPopularFoods() {
        return FOOD_DAO.listPopular();
    }

    public static Optional<Food> findFood(int foodId) {
        return FOOD_DAO.find(foodId);
    }

    public static Order createOrder(User user, Cart cart, String address, String phone, String paymentMethod) {
        return ORDER_DAO.create(user, cart, address, phone, paymentMethod);
    }

    public static List<Order> listOrdersByUser(int userId) {
        return ORDER_DAO.listByUser(userId);
    }

    public static List<Order> listAllOrders() {
        return ORDER_DAO.listAll();
    }

    public static Optional<Order> findOrder(int orderId) {
        return ORDER_DAO.find(orderId);
    }

    public static void updateOrderStatus(int orderId, Order.OrderStatus status) {
        ORDER_DAO.updateStatus(orderId, status);
    }
}
