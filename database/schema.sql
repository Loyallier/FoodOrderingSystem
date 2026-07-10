CREATE DATABASE IF NOT EXISTS food_ordering_system
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE food_ordering_system;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS foods;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  user_id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(120) NOT NULL,
  phone_number VARCHAR(30) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('USER', 'ADMIN') NOT NULL DEFAULT 'USER',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id),
  UNIQUE KEY uk_users_username (username),
  UNIQUE KEY uk_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE categories (
  category_id INT NOT NULL AUTO_INCREMENT,
  category_name VARCHAR(80) NOT NULL,
  description VARCHAR(500),
  available TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (category_id),
  UNIQUE KEY uk_categories_name (category_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE foods (
  food_id INT NOT NULL AUTO_INCREMENT,
  food_name VARCHAR(120) NOT NULL,
  category_id INT NOT NULL,
  description VARCHAR(1000),
  ingredients VARCHAR(1000),
  nutrition VARCHAR(1000),
  price DECIMAL(10,2) NOT NULL,
  rating DECIMAL(3,1) NOT NULL DEFAULT 0.0,
  review_count INT NOT NULL DEFAULT 0,
  image_url VARCHAR(1000),
  available TINYINT NOT NULL DEFAULT 1,
  featured TINYINT NOT NULL DEFAULT 0,
  popular TINYINT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (food_id),
  KEY idx_foods_category (category_id),
  CONSTRAINT fk_foods_category FOREIGN KEY (category_id) REFERENCES categories (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE orders (
  order_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  customer_name VARCHAR(50) NOT NULL,
  delivery_address VARCHAR(1000) NOT NULL,
  contact_phone VARCHAR(30) NOT NULL,
  payment_method VARCHAR(80) NOT NULL,
  order_status ENUM('CONFIRMED', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'CONFIRMED',
  payment_status ENUM('PENDING', 'PAID', 'FAILED') NOT NULL DEFAULT 'PAID',
  total_amount DECIMAL(10,2) NOT NULL,
  order_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  completed_time TIMESTAMP NULL,
  PRIMARY KEY (order_id),
  KEY idx_orders_user (user_id),
  KEY idx_orders_time (order_time),
  CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE order_items (
  order_item_id INT NOT NULL AUTO_INCREMENT,
  order_id INT NOT NULL,
  food_id INT NOT NULL,
  food_name VARCHAR(120) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  quantity INT NOT NULL,
  addons VARCHAR(500) NOT NULL DEFAULT '',
  addon_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  subtotal DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (order_item_id),
  KEY idx_order_items_order (order_id),
  KEY idx_order_items_food (food_id),
  CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE,
  CONSTRAINT fk_order_items_food FOREIGN KEY (food_id) REFERENCES foods (food_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
