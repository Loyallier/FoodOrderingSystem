package com.foodorder.store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.foodorder.model.Category;

public class CategoryDao {
    public Category create(String name, String description, boolean available) {
        String sql = "INSERT INTO categories (category_name, description, available) VALUES (?, ?, ?)";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setBoolean(3, available);
            statement.executeUpdate();
            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (keys.next()) {
                    return new Category(keys.getInt(1), name, description, available);
                }
            }
            throw new SQLException("Creating category did not return a generated key.");
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to create category.", ex);
        }
    }

    public void save(int categoryId, String name, String description) {
        if (categoryId > 0 && find(categoryId).isPresent()) {
            update(categoryId, name, description);
            return;
        }
        create(name, description, true);
    }

    public List<Category> list(boolean onlyAvailable) {
        String sql = "SELECT category_id, category_name, description, available FROM categories"
                + (onlyAvailable ? " WHERE available = 1" : "")
                + " ORDER BY category_id";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            List<Category> categories = new ArrayList<>();
            while (resultSet.next()) {
                categories.add(mapCategory(resultSet));
            }
            return categories;
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to list categories.", ex);
        }
    }

    public Optional<Category> find(int categoryId) {
        String sql = "SELECT category_id, category_name, description, available FROM categories WHERE category_id = ?";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, categoryId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? Optional.of(mapCategory(resultSet)) : Optional.empty();
            }
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to find category.", ex);
        }
    }

    public void delete(int categoryId) {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, categoryId);
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to delete category.", ex);
        }
    }

    private void update(int categoryId, String name, String description) {
        String sql = "UPDATE categories SET category_name = ?, description = ? WHERE category_id = ?";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setInt(3, categoryId);
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to update category.", ex);
        }
    }

    private Category mapCategory(ResultSet resultSet) throws SQLException {
        return new Category(
                resultSet.getInt("category_id"),
                resultSet.getString("category_name"),
                resultSet.getString("description"),
                resultSet.getBoolean("available"));
    }
}
