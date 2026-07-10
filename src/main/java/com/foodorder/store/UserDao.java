package com.foodorder.store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.foodorder.model.User;

public class UserDao {
    public User create(String username, String email, String phone, String password, User.Role role) {
        String sql = "INSERT INTO users (username, email, phone_number, password, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, username);
            statement.setString(2, email);
            statement.setString(3, phone);
            statement.setString(4, password);
            statement.setString(5, role.name());
            statement.executeUpdate();
            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (keys.next()) {
                    return new User(keys.getInt(1), username, email, phone, password, role);
                }
            }
            throw new SQLException("Creating user did not return a generated key.");
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to create user.", ex);
        }
    }

    public Optional<User> findByLoginKey(String loginKey) {
        String sql = "SELECT user_id, username, email, phone_number, password, role, created_at FROM users WHERE LOWER(username) = ? OR LOWER(email) = ?";
        String normalized = loginKey == null ? "" : loginKey.trim().toLowerCase();
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, normalized);
            statement.setString(2, normalized);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? Optional.of(mapUser(resultSet)) : Optional.empty();
            }
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to find user.", ex);
        }
    }

    public boolean emailExists(String email) {
        return exists("SELECT 1 FROM users WHERE LOWER(email) = ?", email);
    }

    public boolean usernameExists(String username) {
        return exists("SELECT 1 FROM users WHERE LOWER(username) = ?", username);
    }

    public List<User> listAll() {
        String sql = "SELECT user_id, username, email, phone_number, password, role, created_at FROM users ORDER BY user_id";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            List<User> users = new ArrayList<>();
            while (resultSet.next()) {
                users.add(mapUser(resultSet));
            }
            return users;
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to list users.", ex);
        }
    }

    private boolean exists(String sql, String value) {
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, value == null ? "" : value.trim().toLowerCase());
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to check user uniqueness.", ex);
        }
    }

    private User mapUser(ResultSet resultSet) throws SQLException {
        LocalDateTime createdAt = resultSet.getTimestamp("created_at") == null
                ? LocalDateTime.now()
                : resultSet.getTimestamp("created_at").toLocalDateTime();
        return new User(
                resultSet.getInt("user_id"),
                resultSet.getString("username"),
                resultSet.getString("email"),
                resultSet.getString("phone_number"),
                resultSet.getString("password"),
                User.Role.valueOf(resultSet.getString("role")),
                createdAt);
    }
}
