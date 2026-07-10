USE food_ordering_system;

INSERT INTO users (user_id, username, email, phone_number, password, role) VALUES
  (1, 'admin', 'admin@food.test', '0123456789', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN'),
  (2, 'customer', 'customer@food.test', '0111111111', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'USER');

INSERT INTO categories (category_id, category_name, description, available) VALUES
  (1, 'Main Course', 'Rice, noodles, burgers, and full meals.', 1),
  (2, 'Snack', 'Small bites and side dishes.', 1),
  (3, 'Drink', 'Cold drinks, tea, and coffee.', 1),
  (4, 'Dessert', 'Sweet dishes and cakes.', 1);

INSERT INTO foods (food_id, food_name, category_id, description, ingredients, nutrition, price, rating, review_count, image_url, available, featured, popular) VALUES
  (1, 'Chicken Burger', 1, 'Crispy chicken burger with lettuce and cheese.', 'Chicken, lettuce, cheese, bun', '520 kcal, 31g protein', 12.90, 4.6, 128, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=80', 1, 1, 1),
  (2, 'Teriyaki Rice Bowl', 1, 'Grilled chicken served over steamed rice with teriyaki sauce.', 'Chicken, rice, broccoli, sesame, teriyaki sauce', '640 kcal, 38g protein', 15.50, 4.7, 96, 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=900&q=80', 1, 1, 1),
  (3, 'Spicy Pasta', 1, 'Pasta tossed with tomato chili sauce and parmesan.', 'Pasta, tomato, chili, parmesan', '590 kcal, vegetarian', 13.80, 4.4, 74, 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=900&q=80', 1, 0, 1),
  (4, 'French Fries', 2, 'Golden fries served with house sauce.', 'Potato, salt, house sauce', '310 kcal', 6.90, 4.3, 88, 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=900&q=80', 1, 0, 1),
  (5, 'Iced Lemon Tea', 3, 'Fresh brewed black tea with lemon and ice.', 'Black tea, lemon, sugar', '120 kcal', 4.50, 4.5, 63, 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=900&q=80', 1, 0, 0),
  (6, 'Chocolate Cake', 4, 'Rich chocolate cake with smooth ganache.', 'Chocolate, flour, egg, cream', '430 kcal', 8.80, 4.8, 109, 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=900&q=80', 1, 1, 0);

ALTER TABLE users AUTO_INCREMENT = 3;
ALTER TABLE categories AUTO_INCREMENT = 5;
ALTER TABLE foods AUTO_INCREMENT = 7;
ALTER TABLE orders AUTO_INCREMENT = 1001;
