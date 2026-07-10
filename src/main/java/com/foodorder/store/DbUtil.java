package com.foodorder.store;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public final class DbUtil {
    private static final Properties PROPERTIES = loadProperties();

    private DbUtil() {
    }

    public static Connection getConnection() throws SQLException {
        String driver = property("db.driver", "com.mysql.cj.jdbc.Driver");
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            throw new SQLException("MySQL Connector/J not found. Add mysql-connector-j to WEB-INF/lib or Eclipse Build Path.", ex);
        }
        return DriverManager.getConnection(
                property("db.url", "jdbc:mysql://localhost:3306/food_ordering_system?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true"),
                property("db.username", "root"),
                property("db.password", ""));
    }

    private static Properties loadProperties() {
        Properties properties = new Properties();
        try (InputStream input = Thread.currentThread().getContextClassLoader().getResourceAsStream("db.properties")) {
            if (input != null) {
                properties.load(input);
            }
        } catch (IOException ex) {
            throw new DataAccessException("Failed to read db.properties.", ex);
        }
        return properties;
    }

    private static String property(String key, String defaultValue) {
        String value = PROPERTIES.getProperty(key);
        return value == null || value.isBlank() ? defaultValue : value.trim();
    }
}
