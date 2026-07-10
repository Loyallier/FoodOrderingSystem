package com.foodorder.model;

import java.math.BigDecimal;

public class CartItem {
    private String lineId;
    private int foodId;
    private String foodName;
    private String imageUrl;
    private BigDecimal unitPrice;
    private int quantity;
    private String addons;
    private BigDecimal addonPrice;

    public CartItem(Food food, int quantity, String addons, BigDecimal addonPrice) {
        this(food.getFoodId() + "|" + (addons == null ? "" : addons.trim()), food, quantity, addons, addonPrice);
    }

    public CartItem(String lineId, Food food, int quantity, String addons, BigDecimal addonPrice) {
        this.lineId = lineId;
        this.foodId = food.getFoodId();
        this.foodName = food.getFoodName();
        this.imageUrl = food.getImageUrl();
        this.unitPrice = food.getPrice();
        this.quantity = quantity;
        this.addons = addons == null ? "" : addons;
        this.addonPrice = addonPrice == null ? BigDecimal.ZERO : addonPrice;
    }

    public String getLineId() {
        return lineId;
    }

    public int getFoodId() {
        return foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getAddons() {
        return addons;
    }

    public BigDecimal getAddonPrice() {
        return addonPrice;
    }

    public BigDecimal getSubtotal() {
        return unitPrice.add(addonPrice).multiply(BigDecimal.valueOf(quantity));
    }
}
