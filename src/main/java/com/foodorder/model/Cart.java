package com.foodorder.model;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
    private final Map<String, CartItem> items = new LinkedHashMap<>();

    public void addItem(Food food, int quantity, String addons, BigDecimal addonPrice) {
        String lineId = lineId(food.getFoodId(), addons);
        CartItem existing = items.get(lineId);
        if (existing == null) {
            items.put(lineId, new CartItem(lineId, food, quantity, addons, addonPrice));
        } else {
            existing.setQuantity(existing.getQuantity() + quantity);
        }
    }

    public void updateQuantity(String lineId, int quantity) {
        if (quantity <= 0) {
            items.remove(lineId);
            return;
        }
        CartItem item = items.get(lineId);
        if (item != null) {
            item.setQuantity(quantity);
        }
    }

    public void removeItem(String lineId) {
        items.remove(lineId);
    }

    public void clear() {
        items.clear();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }

    public int getTotalQuantity() {
        return items.values().stream().mapToInt(CartItem::getQuantity).sum();
    }

    public BigDecimal getTotalAmount() {
        return items.values().stream()
                .map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private String lineId(int foodId, String addons) {
        return foodId + "|" + (addons == null ? "" : addons.trim());
    }
}
