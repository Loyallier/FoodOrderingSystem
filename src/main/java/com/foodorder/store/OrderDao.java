package com.foodorder.store;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.foodorder.model.Cart;
import com.foodorder.model.CartItem;
import com.foodorder.model.Order;
import com.foodorder.model.OrderItem;
import com.foodorder.model.User;

public class OrderDao {
    public Order create(User user, Cart cart, String address, String phone, String paymentMethod) {
        String orderSql = "INSERT INTO orders (user_id, customer_name, delivery_address, contact_phone, payment_method, order_status, payment_status, total_amount) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        String itemSql = "INSERT INTO order_items (order_id, food_id, food_name, unit_price, quantity, addons, addon_price, subtotal) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DbUtil.getConnection()) {
            connection.setAutoCommit(false);
            try (PreparedStatement orderStatement = connection.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                orderStatement.setInt(1, user.getUserId());
                orderStatement.setString(2, user.getUsername());
                orderStatement.setString(3, address);
                orderStatement.setString(4, phone);
                orderStatement.setString(5, paymentMethod);
                orderStatement.setString(6, Order.OrderStatus.CONFIRMED.name());
                orderStatement.setString(7, Order.PaymentStatus.PAID.name());
                orderStatement.setBigDecimal(8, cart.getTotalAmount());
                orderStatement.executeUpdate();
                int orderId;
                try (ResultSet keys = orderStatement.getGeneratedKeys()) {
                    if (!keys.next()) {
                        throw new SQLException("Creating order did not return a generated key.");
                    }
                    orderId = keys.getInt(1);
                }
                try (PreparedStatement itemStatement = connection.prepareStatement(itemSql)) {
                    for (CartItem item : cart.getItems()) {
                        itemStatement.setInt(1, orderId);
                        itemStatement.setInt(2, item.getFoodId());
                        itemStatement.setString(3, item.getFoodName());
                        itemStatement.setBigDecimal(4, item.getUnitPrice());
                        itemStatement.setInt(5, item.getQuantity());
                        itemStatement.setString(6, item.getAddons());
                        itemStatement.setBigDecimal(7, item.getAddonPrice());
                        itemStatement.setBigDecimal(8, item.getSubtotal());
                        itemStatement.addBatch();
                    }
                    itemStatement.executeBatch();
                }
                connection.commit();
                return find(orderId).orElseThrow(() -> new SQLException("Created order cannot be loaded."));
            } catch (SQLException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(true);
            }
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to create order.", ex);
        }
    }

    public List<Order> listByUser(int userId) {
        String sql = baseOrderSql() + " WHERE o.user_id = ? ORDER BY o.order_time DESC";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                List<Order> orders = collectOrders(resultSet);
                loadItems(connection, orders);
                return orders;
            }
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to list user orders.", ex);
        }
    }

    public List<Order> listAll() {
        String sql = baseOrderSql() + " ORDER BY o.order_time DESC";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            List<Order> orders = collectOrders(resultSet);
            loadItems(connection, orders);
            return orders;
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to list orders.", ex);
        }
    }

    public Optional<Order> find(int orderId) {
        String sql = baseOrderSql() + " WHERE o.order_id = ?";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            try (ResultSet resultSet = statement.executeQuery()) {
                List<Order> orders = collectOrders(resultSet);
                loadItems(connection, orders);
                return orders.isEmpty() ? Optional.empty() : Optional.of(orders.get(0));
            }
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to find order.", ex);
        }
    }

    public void updateStatus(int orderId, Order.OrderStatus status) {
        String sql = "UPDATE orders SET order_status = ?, completed_time = ? WHERE order_id = ?";
        try (Connection connection = DbUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status.name());
            if (status == Order.OrderStatus.COMPLETED) {
                statement.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            } else {
                statement.setTimestamp(2, null);
            }
            statement.setInt(3, orderId);
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new DataAccessException("Failed to update order status.", ex);
        }
    }

    private String baseOrderSql() {
        return "SELECT o.order_id, o.user_id, o.customer_name, o.delivery_address, o.contact_phone, "
                + "o.payment_method, o.order_status, o.payment_status, o.total_amount, o.order_time, o.completed_time FROM orders o";
    }

    private List<Order> collectOrders(ResultSet resultSet) throws SQLException {
        List<Order> orders = new ArrayList<>();
        while (resultSet.next()) {
            orders.add(mapOrder(resultSet));
        }
        return orders;
    }

    private void loadItems(Connection connection, List<Order> orders) throws SQLException {
        String sql = "SELECT order_item_id, order_id, food_id, food_name, unit_price, quantity, addons, addon_price, subtotal "
                + "FROM order_items WHERE order_id = ? ORDER BY order_item_id";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            for (Order order : orders) {
                statement.setInt(1, order.getOrderId());
                try (ResultSet resultSet = statement.executeQuery()) {
                    List<OrderItem> items = new ArrayList<>();
                    while (resultSet.next()) {
                        items.add(new OrderItem(
                                resultSet.getInt("order_item_id"),
                                resultSet.getInt("food_id"),
                                resultSet.getString("food_name"),
                                resultSet.getBigDecimal("unit_price"),
                                resultSet.getInt("quantity"),
                                resultSet.getString("addons"),
                                resultSet.getBigDecimal("addon_price"),
                                resultSet.getBigDecimal("subtotal")));
                    }
                    order.setItems(items);
                }
            }
        }
    }

    private Order mapOrder(ResultSet resultSet) throws SQLException {
        Timestamp completed = resultSet.getTimestamp("completed_time");
        BigDecimal total = resultSet.getBigDecimal("total_amount");
        return new Order(
                resultSet.getInt("order_id"),
                resultSet.getInt("user_id"),
                resultSet.getString("customer_name"),
                resultSet.getString("delivery_address"),
                resultSet.getString("contact_phone"),
                resultSet.getString("payment_method"),
                Order.OrderStatus.valueOf(resultSet.getString("order_status")),
                Order.PaymentStatus.valueOf(resultSet.getString("payment_status")),
                total == null ? BigDecimal.ZERO : total,
                resultSet.getTimestamp("order_time").toLocalDateTime(),
                completed == null ? null : completed.toLocalDateTime(),
                new ArrayList<>());
    }
}
