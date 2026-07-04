package com.foodorder.store;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import com.foodorder.model.Cart;
import com.foodorder.model.Category;
import com.foodorder.model.Food;
import com.foodorder.model.Order;
import com.foodorder.model.OrderItem;
import com.foodorder.model.User;

public final class AppStore {
    private static final Map<Integer, User> USERS = new LinkedHashMap<>();
    private static final Map<Integer, Category> CATEGORIES = new LinkedHashMap<>();
    private static final Map<Integer, Food> FOODS = new LinkedHashMap<>();
    private static final Map<Integer, Order> ORDERS = new LinkedHashMap<>();

    private static final AtomicInteger USER_SEQUENCE = new AtomicInteger(1);
    private static final AtomicInteger CATEGORY_SEQUENCE = new AtomicInteger(1);
    private static final AtomicInteger FOOD_SEQUENCE = new AtomicInteger(1);
    private static final AtomicInteger ORDER_SEQUENCE = new AtomicInteger(1001);
    private static final AtomicInteger ORDER_ITEM_SEQUENCE = new AtomicInteger(1);

    static {
        seedUsers();
        seedCategories();
        seedFoods();
    }

    private AppStore() {
    }

    private static void seedUsers() {
        createUser("admin", "admin@food.test", "0123456789", "admin123", User.Role.ADMIN);
        createUser("customer", "customer@food.test", "0111111111", "password", User.Role.USER);
    }

    private static void seedCategories() {
        createCategory("Main Course", "Rice, noodles, burgers, and full meals.", true);
        createCategory("Snack", "Small bites and side dishes.", true);
        createCategory("Drink", "Cold drinks, tea, and coffee.", true);
        createCategory("Dessert", "Sweet dishes and cakes.", true);
    }

    private static void seedFoods() {
        addFood("Chicken Burger", 1, "Crispy chicken burger with lettuce and cheese.",
                "Chicken, lettuce, cheese, bun", "520 kcal, 31g protein",
                new BigDecimal("12.90"), 4.6, 128, "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=80", true, true, true);
        addFood("Teriyaki Rice Bowl", 1, "Grilled chicken served over steamed rice with teriyaki sauce.",
                "Chicken, rice, broccoli, sesame, teriyaki sauce", "640 kcal, 38g protein",
                new BigDecimal("15.50"), 4.7, 96, "https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=900&q=80", true, true, true);
        addFood("Spicy Pasta", 1, "Pasta tossed with tomato chili sauce and parmesan.",
                "Pasta, tomato, chili, parmesan", "590 kcal, vegetarian",
                new BigDecimal("13.80"), 4.4, 74, "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=900&q=80", true, false, true);
        addFood("French Fries", 2, "Golden fries served with house sauce.",
                "Potato, salt, house sauce", "310 kcal",
                new BigDecimal("6.90"), 4.3, 88, "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=900&q=80", true, false, true);
        addFood("Iced Lemon Tea", 3, "Fresh brewed black tea with lemon and ice.",
                "Black tea, lemon, sugar", "120 kcal",
                new BigDecimal("4.50"), 4.5, 63, "https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=900&q=80", true, false, false);
        addFood("Chocolate Cake", 4, "Rich chocolate cake with smooth ganache.",
                "Chocolate, flour, egg, cream", "430 kcal",
                new BigDecimal("8.80"), 4.8, 109, "https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=900&q=80", true, true, false);
    }

    public static synchronized User createUser(String username, String email, String phone, String password, User.Role role) {
        User user = new User(USER_SEQUENCE.getAndIncrement(), username, email, phone, password, role);
        USERS.put(user.getUserId(), user);
        return user;
    }

    public static Optional<User> authenticate(String loginKey, String password) {
        if (loginKey == null || password == null) {
            return Optional.empty();
        }
        String normalized = loginKey.trim().toLowerCase();
        return USERS.values().stream()
                .filter(user -> (user.getUsername().equalsIgnoreCase(normalized)
                        || user.getEmail().equalsIgnoreCase(normalized))
                        && user.getPassword().equals(password))
                .findFirst();
    }

    public static boolean emailExists(String email) {
        return USERS.values().stream().anyMatch(user -> user.getEmail().equalsIgnoreCase(email));
    }

    public static boolean usernameExists(String username) {
        return USERS.values().stream().anyMatch(user -> user.getUsername().equalsIgnoreCase(username));
    }

    public static List<User> listUsers() {
        return new ArrayList<>(USERS.values());
    }

    public static synchronized Category createCategory(String name, String description, boolean available) {
        Category category = new Category(CATEGORY_SEQUENCE.getAndIncrement(), name, description, available);
        CATEGORIES.put(category.getCategoryId(), category);
        return category;
    }

    public static List<Category> listCategories(boolean onlyAvailable) {
        return CATEGORIES.values().stream()
                .filter(category -> !onlyAvailable || category.isAvailable())
                .collect(Collectors.toList());
    }

    public static Optional<Category> findCategory(int categoryId) {
        return Optional.ofNullable(CATEGORIES.get(categoryId));
    }

    public static synchronized void disableCategory(int categoryId) {
        Category category = CATEGORIES.get(categoryId);
        if (category != null) {
            category.setAvailable(false);
        }
    }

    public static synchronized Food addFood(String foodName, int categoryId, String description,
            String ingredients, String nutrition, BigDecimal price, double rating, int reviewCount,
            String imageUrl, boolean available, boolean featured, boolean popular) {
        String categoryName = findCategory(categoryId).map(Category::getCategoryName).orElse("Uncategorized");
        Food food = new Food(FOOD_SEQUENCE.getAndIncrement(), foodName, categoryId, categoryName, description,
                ingredients, nutrition, price, rating, reviewCount, imageUrl, available, featured, popular);
        FOODS.put(food.getFoodId(), food);
        return food;
    }

    public static synchronized void saveFood(int foodId, String foodName, int categoryId, String description,
            String ingredients, String nutrition, BigDecimal price, double rating, String imageUrl,
            boolean available, boolean featured, boolean popular) {
        String categoryName = findCategory(categoryId).map(Category::getCategoryName).orElse("Uncategorized");
        if (foodId > 0 && FOODS.containsKey(foodId)) {
            FOODS.get(foodId).update(foodName, categoryId, categoryName, description, ingredients, nutrition,
                    price, rating, imageUrl, available, featured, popular);
        } else {
            addFood(foodName, categoryId, description, ingredients, nutrition, price, rating, 0,
                    imageUrl, available, featured, popular);
        }
    }

    public static synchronized void disableFood(int foodId) {
        Food food = FOODS.get(foodId);
        if (food != null) {
            food.setAvailable(false);
        }
    }

    public static List<Food> listFoods(boolean onlyAvailable) {
        return FOODS.values().stream()
                .filter(food -> !onlyAvailable || food.isAvailable())
                .sorted(Comparator.comparing(Food::getCategoryName).thenComparing(Food::getFoodName))
                .collect(Collectors.toList());
    }

    public static List<Food> listFoodsByCategory(int categoryId) {
        return FOODS.values().stream()
                .filter(Food::isAvailable)
                .filter(food -> categoryId <= 0 || food.getCategoryId() == categoryId)
                .collect(Collectors.toList());
    }

    public static List<Food> listFeaturedFoods() {
        return FOODS.values().stream().filter(Food::isAvailable).filter(Food::isFeatured).collect(Collectors.toList());
    }

    public static List<Food> listPopularFoods() {
        return FOODS.values().stream().filter(Food::isAvailable).filter(Food::isPopular).collect(Collectors.toList());
    }

    public static Optional<Food> findFood(int foodId) {
        return Optional.ofNullable(FOODS.get(foodId));
    }

    public static synchronized Order createOrder(User user, Cart cart, String address, String phone, String paymentMethod) {
        List<OrderItem> items = cart.getItems().stream()
                .map(item -> new OrderItem(ORDER_ITEM_SEQUENCE.getAndIncrement(), item))
                .collect(Collectors.toList());
        Order order = new Order(ORDER_SEQUENCE.getAndIncrement(), user, address, phone, paymentMethod,
                cart.getTotalAmount(), items);
        ORDERS.put(order.getOrderId(), order);
        return order;
    }

    public static List<Order> listOrdersByUser(int userId) {
        return ORDERS.values().stream()
                .filter(order -> order.getUserId() == userId)
                .sorted(Comparator.comparing(Order::getOrderTime).reversed())
                .collect(Collectors.toList());
    }

    public static List<Order> listAllOrders() {
        return ORDERS.values().stream()
                .sorted(Comparator.comparing(Order::getOrderTime).reversed())
                .collect(Collectors.toList());
    }

    public static Optional<Order> findOrder(int orderId) {
        return Optional.ofNullable(ORDERS.get(orderId));
    }

    public static synchronized void updateOrderStatus(int orderId, Order.OrderStatus status) {
        Order order = ORDERS.get(orderId);
        if (order != null) {
            order.setOrderStatus(status);
        }
    }
}
