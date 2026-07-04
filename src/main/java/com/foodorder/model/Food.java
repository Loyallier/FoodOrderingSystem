package com.foodorder.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Food {
    private int foodId;
    private String foodName;
    private int categoryId;
    private String categoryName;
    private String description;
    private String ingredients;
    private String nutrition;
    private BigDecimal price;
    private double rating;
    private int reviewCount;
    private String imageUrl;
    private boolean available;
    private boolean featured;
    private boolean popular;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Food(int foodId, String foodName, int categoryId, String categoryName, String description,
            String ingredients, String nutrition, BigDecimal price, double rating, int reviewCount,
            String imageUrl, boolean available, boolean featured, boolean popular) {
        this.foodId = foodId;
        this.foodName = foodName;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.ingredients = ingredients;
        this.nutrition = nutrition;
        this.price = price;
        this.rating = rating;
        this.reviewCount = reviewCount;
        this.imageUrl = imageUrl;
        this.available = available;
        this.featured = featured;
        this.popular = popular;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    public int getFoodId() {
        return foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public String getDescription() {
        return description;
    }

    public String getIngredients() {
        return ingredients;
    }

    public String getNutrition() {
        return nutrition;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public double getRating() {
        return rating;
    }

    public int getReviewCount() {
        return reviewCount;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public boolean isAvailable() {
        return available;
    }

    public boolean isFeatured() {
        return featured;
    }

    public boolean isPopular() {
        return popular;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void update(String foodName, int categoryId, String categoryName, String description,
            String ingredients, String nutrition, BigDecimal price, double rating, String imageUrl,
            boolean available, boolean featured, boolean popular) {
        this.foodName = foodName;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.ingredients = ingredients;
        this.nutrition = nutrition;
        this.price = price;
        this.rating = rating;
        this.imageUrl = imageUrl;
        this.available = available;
        this.featured = featured;
        this.popular = popular;
        this.updatedAt = LocalDateTime.now();
    }

    public void setAvailable(boolean available) {
        this.available = available;
        this.updatedAt = LocalDateTime.now();
    }
}
