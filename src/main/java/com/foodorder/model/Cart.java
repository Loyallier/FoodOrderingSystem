package com.foodorder.model;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
    private final Map<Integer, CartItem> items = new LinkedHashMap<>();

    public void addItem(Food food, int quantity, String addons, BigDecimal addonPrice) {
        CartItem existing = items.get(food.getFoodId());
        if (existing == null) {
            items.put(food.getFoodId(), new CartItem(food, quantity, addons, addonPrice));
        } else {
            existing.setQuantity(existing.getQuantity() + quantity);
        }
    }

    public void updateQuantity(int foodId, int quantity) {
        if (quantity <= 0) {
            items.remove(foodId);
            return;
        }
        CartItem item = items.get(foodId);
        if (item != null) {
            item.setQuantity(quantity);
        }
    }

    public void removeItem(int foodId) {
        items.remove(foodId);
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
}
