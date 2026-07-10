package com.foodorder.store;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.foodorder.model.Food;

public class FoodDao {
    private static final String FOOD_COLUMNS = "f.food_id, f.food_name, f.category_id, c.category_name, f.description, "
            + "f.ingredients, f.nutrition, f.price, f.rating, f.review_count, f.image_url, f.available, "
            + "f.featured, f.popular, f.created_at, f.updated_at";

    public Food add(String foodName, int categoryId, String description, String ingredients, String nutrition,
            BigDecimal price, double rating, int reviewCount, String imageUrl, boolean available,
            boolean featured, boolean popular) {
        String sql = "INSERT INTO foods (food_name, category_id, description, ingredients, nutrition, price, rating, review_count, image_url, available, featured, popular) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, foodName);
            statement.setInt(2, categoryId);
            statement.setString(3, description);
            statement.setString(4, ingredients);
            statement.setString(5, nutrition);
            statement.setBigDecimal(6, price);
            statement.setDouble(7, rating);
            statement.setInt(8, reviewCount);
            statement.setString(9, imageUrl);
            statement.setBoolean(10, available);
            statement.setBoolean(11, featured);
            statement.setBoolean(12, popular);
            statement.executeUpdate();
            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (keys.next()) {
                    return find(keys.getInt(1)).orElseThrow(() -> new SQLException("Created food cannot be loaded."));
                }
            }
            throw new SQLException("Creating food did not return a generated key.");
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to add food.", ex);
        }
    }

    public void save(int foodId, String foodName, int categoryId, String description, String ingredients,
            String nutrition, BigDecimal price, double rating, String imageUrl, boolean available,
            boolean featured, boolean popular) {
        if (foodId > 0 && find(foodId).isPresent()) {
            update(foodId, foodName, categoryId, description, ingredients, nutrition, price, rating, imageUrl,
                    available, featured, popular);
            return;
        }
        add(foodName, categoryId, description, ingredients, nutrition, price, rating, 0, imageUrl, available,
                featured, popular);
    }

    public void disable(int foodId) {
        String sql = "UPDATE foods SET available = 0 WHERE food_id = ?";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, foodId);
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to disable food.", ex);
        }
    }

    public void delete(int foodId) {
        String sql = "DELETE FROM foods WHERE food_id = ?";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, foodId);
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to delete food.", ex);
        }
    }

    public List<Food> list(boolean onlyAvailable) {
        String sql = "SELECT " + FOOD_COLUMNS + " FROM foods f JOIN categories c ON f.category_id = c.category_id"
                + (onlyAvailable ? " WHERE f.available = 1" : "")
                + " ORDER BY c.category_name, f.food_name";
        return listBySql(sql);
    }

    public List<Food> listByCategory(int categoryId) {
        String sql = "SELECT " + FOOD_COLUMNS + " FROM foods f JOIN categories c ON f.category_id = c.category_id "
                + "WHERE f.available = 1 AND (? <= 0 OR f.category_id = ?) ORDER BY f.food_name";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, categoryId);
            statement.setInt(2, categoryId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return collect(resultSet);
            }
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to list foods by category.", ex);
        }
    }

    public List<Food> listFeatured() {
        return listByFlag("featured");
    }

    public List<Food> listPopular() {
        return listByFlag("popular");
    }

    public Optional<Food> find(int foodId) {
        String sql = "SELECT " + FOOD_COLUMNS + " FROM foods f JOIN categories c ON f.category_id = c.category_id WHERE f.food_id = ?";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, foodId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? Optional.of(mapFood(resultSet)) : Optional.empty();
            }
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to find food.", ex);
        }
    }

    private void update(int foodId, String foodName, int categoryId, String description, String ingredients,
            String nutrition, BigDecimal price, double rating, String imageUrl, boolean available,
            boolean featured, boolean popular) {
        String sql = "UPDATE foods SET food_name = ?, category_id = ?, description = ?, ingredients = ?, nutrition = ?, "
                + "price = ?, rating = ?, image_url = ?, available = ?, featured = ?, popular = ? WHERE food_id = ?";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, foodName);
            statement.setInt(2, categoryId);
            statement.setString(3, description);
            statement.setString(4, ingredients);
            statement.setString(5, nutrition);
            statement.setBigDecimal(6, price);
            statement.setDouble(7, rating);
            statement.setString(8, imageUrl);
            statement.setBoolean(9, available);
            statement.setBoolean(10, featured);
            statement.setBoolean(11, popular);
            statement.setInt(12, foodId);
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to update food.", ex);
        }
    }

    private List<Food> listByFlag(String flagColumn) {
        String sql = "SELECT " + FOOD_COLUMNS + " FROM foods f JOIN categories c ON f.category_id = c.category_id "
                + "WHERE f.available = 1 AND f." + flagColumn + " = 1 ORDER BY f.food_name";
        return listBySql(sql);
    }

    private List<Food> listBySql(String sql) {
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            return collect(resultSet);
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to list foods.", ex);
        }
    }

    private List<Food> collect(ResultSet resultSet) throws SQLException {
        List<Food> foods = new ArrayList<>();
        while (resultSet.next()) {
            foods.add(mapFood(resultSet));
        }
        return foods;
    }

    private Food mapFood(ResultSet resultSet) throws SQLException {
        LocalDateTime createdAt = resultSet.getTimestamp("created_at") == null
                ? LocalDateTime.now()
                : resultSet.getTimestamp("created_at").toLocalDateTime();
        LocalDateTime updatedAt = resultSet.getTimestamp("updated_at") == null
                ? createdAt
                : resultSet.getTimestamp("updated_at").toLocalDateTime();
        return new Food(
                resultSet.getInt("food_id"),
                resultSet.getString("food_name"),
                resultSet.getInt("category_id"),
                resultSet.getString("category_name"),
                resultSet.getString("description"),
                resultSet.getString("ingredients"),
                resultSet.getString("nutrition"),
                resultSet.getBigDecimal("price"),
                resultSet.getDouble("rating"),
                resultSet.getInt("review_count"),
                resultSet.getString("image_url"),
                resultSet.getBoolean("available"),
                resultSet.getBoolean("featured"),
                resultSet.getBoolean("popular"),
                createdAt,
                updatedAt);
    }
}
