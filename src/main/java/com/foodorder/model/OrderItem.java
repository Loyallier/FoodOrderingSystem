package com.foodorder.model;

import java.math.BigDecimal;

public class OrderItem {
    private int orderItemId;
    private int foodId;
    private String foodName;
    private BigDecimal unitPrice;
    private int quantity;
    private String addons;
    private BigDecimal addonPrice;
    private BigDecimal subtotal;

    public OrderItem(int orderItemId, CartItem item) {
        this.orderItemId = orderItemId;
        this.foodId = item.getFoodId();
        this.foodName = item.getFoodName();
        this.unitPrice = item.getUnitPrice();
        this.quantity = item.getQuantity();
        this.addons = item.getAddons();
        this.addonPrice = item.getAddonPrice();
        this.subtotal = item.getSubtotal();
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public int getFoodId() {
        return foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getAddons() {
        return addons;
    }

    public BigDecimal getAddonPrice() {
        return addonPrice;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }
}
