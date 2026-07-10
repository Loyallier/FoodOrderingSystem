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
  (6, 'Chocolate Cake', 4, 'Rich chocolate cake with smooth ganache.', 'Chocolate, flour, egg, cream', '430 kcal', 8.80, 4.8, 109, 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=900&q=80', 1, 1, 0),
  (7, 'Double Beef Cheeseburger', 1, 'Two juicy beef patties with melted cheese and pickles.', 'Beef, cheddar, pickles, onion, bun', '760 kcal, 42g protein', 18.90, 4.8, 142, 'https://images.unsplash.com/photo-1553979459-d2229ba7433b?auto=format&fit=crop&w=900&q=80', 1, 1, 1),
  (8, 'Crispy Fish Burger', 1, 'Golden fish fillet with tartar sauce and fresh lettuce.', 'Fish fillet, lettuce, tartar sauce, bun', '540 kcal, 27g protein', 14.90, 4.5, 67, 'https://images.unsplash.com/photo-1550317138-10000687a72b?auto=format&fit=crop&w=900&q=80', 1, 0, 0),
  (9, 'Korean Chicken Bowl', 1, 'Spicy glazed chicken over rice with cucumber and sesame.', 'Chicken, rice, gochujang sauce, cucumber, sesame', '690 kcal, 39g protein', 16.90, 4.7, 118, 'https://images.unsplash.com/photo-1590301157890-4810ed352733?auto=format&fit=crop&w=900&q=80', 1, 1, 1),
  (10, 'Creamy Mushroom Pasta', 1, 'Pasta in a creamy mushroom sauce with parmesan.', 'Pasta, mushroom, cream, parmesan, herbs', '620 kcal, vegetarian', 14.80, 4.4, 53, 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=900&q=80', 1, 0, 0),
  (11, 'Chicken Nuggets', 2, 'Crispy bite-sized chicken nuggets with dipping sauce.', 'Chicken, breadcrumbs, egg, seasoning', '390 kcal, 22g protein', 8.90, 4.6, 91, 'https://images.unsplash.com/photo-1562967916-eb82221dfb92?auto=format&fit=crop&w=900&q=80', 1, 0, 1),
  (12, 'Loaded Cheese Fries', 2, 'Fries topped with cheese sauce and herbs.', 'Potato, cheese sauce, herbs, seasoning', '480 kcal', 9.90, 4.7, 104, 'https://images.unsplash.com/photo-1630384060421-cb20d0e0649d?auto=format&fit=crop&w=900&q=80', 1, 1, 1),
  (13, 'Mozzarella Sticks', 2, 'Stretchy mozzarella sticks with marinara dip.', 'Mozzarella, breadcrumbs, marinara sauce', '360 kcal, 18g protein', 10.50, 4.5, 76, 'https://images.unsplash.com/photo-1548340748-6d2b7d7da280?auto=format&fit=crop&w=900&q=80', 1, 0, 0),
  (14, 'Strawberry Milkshake', 3, 'Creamy strawberry shake finished with whipped cream.', 'Milk, strawberry, ice cream, whipped cream', '340 kcal', 7.90, 4.8, 127, 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?auto=format&fit=crop&w=900&q=80', 1, 1, 1),
  (15, 'Cold Brew Coffee', 3, 'Smooth cold brew coffee served over ice.', 'Coffee, water, ice', '35 kcal', 6.50, 4.6, 82, 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?auto=format&fit=crop&w=900&q=80', 1, 0, 0),
  (16, 'Mango Sparkler', 3, 'Sparkling mango drink with citrus and mint.', 'Mango, soda water, lime, mint', '160 kcal', 6.90, 4.4, 58, 'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?auto=format&fit=crop&w=900&q=80', 1, 0, 1),
  (17, 'Classic Cheesecake', 4, 'Smooth cheesecake with a buttery biscuit base.', 'Cream cheese, biscuit, butter, sugar', '410 kcal', 9.50, 4.7, 99, 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?auto=format&fit=crop&w=900&q=80', 1, 1, 0),
  (18, 'Caramel Sundae', 4, 'Vanilla ice cream with warm caramel sauce.', 'Vanilla ice cream, caramel sauce, nuts', '330 kcal', 7.50, 4.6, 86, 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?auto=format&fit=crop&w=900&q=80', 1, 0, 1);

ALTER TABLE users AUTO_INCREMENT = 3;
ALTER TABLE categories AUTO_INCREMENT = 5;
ALTER TABLE foods AUTO_INCREMENT = 19;
ALTER TABLE orders AUTO_INCREMENT = 1001;
