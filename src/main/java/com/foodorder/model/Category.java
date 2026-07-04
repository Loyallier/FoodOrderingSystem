package com.foodorder.model;

public class Category {
    private int categoryId;
    private String categoryName;
    private String description;
    private boolean available;

    public Category(int categoryId, String categoryName, String description, boolean available) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.available = available;
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

    public boolean isAvailable() {
        return available;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }
}
