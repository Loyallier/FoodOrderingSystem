package com.foodorder.model;

import java.time.LocalDateTime;

public class User {
    public enum Role {
        USER,
        ADMIN
    }

    private int userId;
    private String username;
    private String email;
    private String phoneNumber;
    private String password;
    private Role role;
    private LocalDateTime createdAt;

    public User(int userId, String username, String email, String phoneNumber, String password, Role role) {
        this(userId, username, email, phoneNumber, password, role, LocalDateTime.now());
    }

    public User(int userId, String username, String email, String phoneNumber, String password, Role role,
            LocalDateTime createdAt) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
        this.createdAt = createdAt == null ? LocalDateTime.now() : createdAt;
    }

    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public Role getRole() {
        return role;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public boolean isAdmin() {
        return role == Role.ADMIN;
    }
}
