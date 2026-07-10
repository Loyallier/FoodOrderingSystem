package com.foodorder.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Order {
    public enum OrderStatus {
        CONFIRMED,
        COMPLETED,
        CANCELLED
    }

    public enum PaymentStatus {
        PENDING,
        PAID,
        FAILED
    }

    private int orderId;
    private int userId;
    private String customerName;
    private String deliveryAddress;
    private String contactPhone;
    private String paymentMethod;
    private OrderStatus orderStatus;
    private PaymentStatus paymentStatus;
    private BigDecimal totalAmount;
    private LocalDateTime orderTime;
    private LocalDateTime completedTime;
    private List<OrderItem> items = new ArrayList<>();

    public Order(int orderId, User user, String deliveryAddress, String contactPhone, String paymentMethod,
            BigDecimal totalAmount, List<OrderItem> items) {
        this(orderId, user.getUserId(), user.getUsername(), deliveryAddress, contactPhone, paymentMethod,
                OrderStatus.CONFIRMED, PaymentStatus.PAID, totalAmount, LocalDateTime.now(), null, items);
    }

    public Order(int orderId, int userId, String customerName, String deliveryAddress, String contactPhone,
            String paymentMethod, OrderStatus orderStatus, PaymentStatus paymentStatus, BigDecimal totalAmount,
            LocalDateTime orderTime, LocalDateTime completedTime, List<OrderItem> items) {
        this.orderId = orderId;
        this.userId = userId;
        this.customerName = customerName;
        this.deliveryAddress = deliveryAddress;
        this.contactPhone = contactPhone;
        this.paymentMethod = paymentMethod;
        this.orderStatus = orderStatus;
        this.paymentStatus = paymentStatus;
        this.totalAmount = totalAmount;
        this.orderTime = orderTime;
        this.completedTime = completedTime;
        this.items = items == null ? new ArrayList<>() : items;
    }

    public int getOrderId() {
        return orderId;
    }

    public int getUserId() {
        return userId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public LocalDateTime getOrderTime() {
        return orderTime;
    }

    public LocalDateTime getCompletedTime() {
        return completedTime;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
        if (orderStatus == OrderStatus.COMPLETED) {
            this.completedTime = LocalDateTime.now();
        }
    }

    public void setItems(List<OrderItem> items) {
        this.items = items == null ? new ArrayList<>() : items;
    }
}
