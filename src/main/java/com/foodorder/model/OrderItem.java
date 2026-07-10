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
        this(orderItemId, item.getFoodId(), item.getFoodName(), item.getUnitPrice(), item.getQuantity(),
                item.getAddons(), item.getAddonPrice(), item.getSubtotal());
    }

    public OrderItem(int orderItemId, int foodId, String foodName, BigDecimal unitPrice, int quantity,
            String addons, BigDecimal addonPrice, BigDecimal subtotal) {
        this.orderItemId = orderItemId;
        this.foodId = foodId;
        this.foodName = foodName;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.addons = addons == null ? "" : addons;
        this.addonPrice = addonPrice == null ? BigDecimal.ZERO : addonPrice;
        this.subtotal = subtotal == null ? BigDecimal.ZERO : subtotal;
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
