# Food Ordering System

Java EE / JSP / Servlet coursework project for a Food Ordering and Restaurant Management Website.

The system supports customer registration and login, menu browsing, food detail viewing, cart management, checkout, order history, and an admin dashboard for managing foods, categories, and customer orders.

## Runtime

\- Java 21, based on the Eclipse project settings

\- Apache Tomcat 10.1

\- Jakarta Servlet API, using `jakarta.servlet.*`

\- MySQL

\- JDBC with MySQL Connector/J

## Run in Eclipse

1. Import this folder as an existing Eclipse Dynamic Web Project.
2. Configure Apache Tomcat 10.1 as the target runtime.
3. Add MySQL Connector/J to:

```text
src/main/webapp/WEB-INF/lib
```

or add it through the Eclipse Build Path.

4. Set up the MySQL database by following the instructions in the MySQL Setup section.
5. Run the project on the server.
6. Open: http://localhost:8080/FoodOrderingSystem/

## Demo Accounts

Admin:

```
username: admin
password: admin123
```

Customer:

```
username: customer
password: password
```

## MySQL Setup

The project uses MySQL as the persistent data layer. JDBC DAO classes are used behind `AppStore`, so the existing Servlet flow stays stable while data is stored in the database.

The database files are located in:

```
database/
├── setup_user.sql
├── schema.sql
└── seed.sql
```

### 1. Create the MySQL project user

First, log in to MySQL as `root` or another MySQL account with user creation permission.

Then run:

```
SOURCE database/setup_user.sql;
```

This script creates the project database and a dedicated MySQL user for the application:

```
database: food_ordering_system
username: foodapp
password: foodapp123
```

The application should use this `foodapp` MySQL user instead of the MySQL `root` account.

### 2. Create database tables

After creating the project user, run:

```
SOURCE database/schema.sql;
```

This script creates the required tables, including users, categories, foods, orders, and order items.

### 3. Insert demo data

Then run:

```
SOURCE database/seed.sql;
```

This script inserts the demo admin account, demo customer account, categories, and sample food items.

## Database Configuration

The database connection is configured in:

```
src/main/resources/db.properties
```

Default configuration:

```
db.url=jdbc:mysql://localhost:3306/food_ordering_system?useSSL=false&serverTimezone=Asia/Kuala_Lumpur&allowPublicKeyRetrieval=true
db.username=foodapp
db.password=foodapp123
db.driver=com.mysql.cj.jdbc.Driver
```

This file is included in the project so that the coursework can run directly after importing and setting up MySQL.

If your local MySQL setup uses a different database user, password, port, or database name, update this file accordingly.

## Main URLs

Customer pages:

```
/home
/menu
/food-detail?foodId=1
/cart
/checkout
/orders/history
/login
/register
```

Admin pages:

```
/admin/dashboard
/admin/foods
/admin/categories
/admin/orders
```

Coursework-compatible Servlet aliases are also registered:

```
/RegisterServlet
/LoginServlet
/MenuServlet
/CartServlet
/CheckoutServlet
/AdminMenuServlet
/AdminSaveFoodServlet
/AdminDeleteFoodServlet
/AdminOrderServlet
```

## Project Structure

```
FoodOrderingSystem/
├── database/                 MySQL setup, schema, and seed scripts
├── src/main/java/            Java source code
│   └── com/foodorder/
│       ├── model/            JavaBeans used by JSP, Servlet, DAO, and session data
│       ├── store/            JDBC data access and AppStore facade
│       └── web/              Servlet controllers and shared web helpers
├── src/main/resources/       Runtime configuration files
├── src/main/webapp/          JSP pages and web resources
│   ├── admin/                Admin JSP pages
│   ├── assets/               Static frontend resources
│   ├── WEB-INF/              Protected fragments, web.xml, and libraries
│   └── *.jsp                 Customer-facing JSP pages
├── build/                    Eclipse compiled output
└── .settings/                Eclipse project settings
```

### Java Model Files

- `User.java`: represents a registered user, including username, email, phone number, password hash, and role.
- `Category.java`: represents a food category such as Main Course, Snack, Drink, or Dessert.
- `Food.java`: represents a menu item, including price, image URL, ingredients, nutrition, rating, and category.
- `Cart.java`: session-level shopping cart object; stores cart lines, total quantity, and total amount.
- `CartItem.java`: one line in the cart; supports the same food with different add-ons as separate lines.
- `Order.java`: represents a submitted order, including customer, delivery, payment, status, total, and item list.
- `OrderItem.java`: one saved order line; stores a snapshot of food name, price, quantity, add-ons, and subtotal.

### Store / Database Files

- `AppStore.java`: facade used by Servlets; hides DAO details so controllers call simple methods such as `listFoods`, `createOrder`, and `authenticate`.
- `DbUtil.java`: creates JDBC connections from `db.properties`.
- `UserDao.java`: handles user registration, login lookup, uniqueness checks, and user listing.
- `CategoryDao.java`: handles category creation, lookup, listing, and disabling.
- `FoodDao.java`: handles menu item CRUD, filtering, featured foods, popular foods, and food lookup.
- `OrderDao.java`: writes orders and order items in one transaction, loads order history, and updates order status.
- `PasswordUtil.java`: hashes passwords with SHA-256 and supports legacy plain-text matching.
- `DataAccessException.java`: wraps SQL errors as runtime exceptions so Servlet code stays cleaner.

### Servlet / Web Controller Files

- `HomeServlet.java`: loads featured and popular foods, then forwards to `home.jsp`.
- `MenuServlet.java`: loads categories and filtered foods, then forwards to `menu.jsp`.
- `FoodDetailServlet.java`: loads one available food item, then forwards to `food-detail.jsp`.
- `RegisterServlet.java`: validates registration form data and creates a normal user.
- `LoginServlet.java`: authenticates username/email plus password and stores `currentUser` in session.
- `LogoutServlet.java`: clears the login session and redirects to login.
- `CartServlet.java`: adds items, updates quantities, and removes cart lines from the session cart.
- `CheckoutServlet.java`: validates checkout data, persists the order, clears the cart, and forwards to `orderSuccess.jsp`.
- `OrderHistoryServlet.java`: loads the current user's past orders.
- `AdminDashboardServlet.java`: loads admin overview data for foods, categories, and orders.
- `AdminFoodServlet.java`: handles admin food listing, save/update, image upload, and disabling.
- `AdminCategoryServlet.java`: handles admin category listing, creation, and disabling.
- `AdminOrderServlet.java`: loads all customer orders and updates order status.
- `StaticPageServlet.java`: routes static pages such as About, FAQ, and Contact.
- `WebUtil.java`: shared helper for forwarding, redirects, session user/cart access, parameter parsing, and add-on pricing.

### JSP Page Files

- `index.jsp`: entry page that redirects users into the main site flow.
- `home.jsp`: home page showing highlighted menu items.
- `menu.jsp`: menu listing page; displays categories and food cards from `MenuServlet`.
- `food-detail.jsp`: detail page for ingredients, nutrition, ratings, quantity, and add-ons.
- `cart.jsp`: cart page; displays session cart lines and submits update/remove forms.
- `checkout.jsp`: checkout form for delivery address, phone, and payment method.
- `orderSuccess.jsp`: order receipt page used after successful checkout.
- `order-confirmation.jsp`: older confirmation page kept for compatibility.
- `order-history.jsp`: customer order history page.
- `login.jsp`: login form posting to `LoginServlet`.
- `register.jsp`: registration form posting to `RegisterServlet`.
- `about.jsp`: static restaurant background page.
- `faq.jsp`: static Q&A page.
- `contact.jsp`: static contact page with frontend-only thank-you alert.
- `admin/dashboard.jsp`: admin overview page.
- `admin/foods.jsp`: admin food CRUD page.
- `admin/categories.jsp`: admin category management page.
- `admin/orders.jsp`: admin customer order management page.
- `WEB-INF/jsp/header.jspf`: shared page header and navigation.
- `WEB-INF/jsp/footer.jspf`: shared footer.
- `WEB-INF/web.xml`: web application descriptor.
- `WEB-INF/lib/mysql-connector-j-9.7.0.jar`: MySQL JDBC driver used at runtime.

### Interaction Flow

1. Browser requests a Servlet URL, such as `/MenuServlet`, `/LoginServlet`, or `/CheckoutServlet`.
2. The Servlet reads form/query parameters and uses `WebUtil` for common session and redirect work.
3. For database data, the Servlet calls `AppStore`.
4. `AppStore` delegates to the matching DAO, and the DAO uses `DbUtil` to connect to MySQL.
5. The Servlet places objects into request scope or session scope.
6. The Servlet forwards to a JSP page.
7. The JSP reads request/session data and renders HTML back to the browser.

Important session/request names:

- `sessionScope.currentUser`: logged-in user.
- `sessionScope.cart`: current shopping cart.
- `requestScope.categoryList`: menu categories.
- `requestScope.foodList`: menu foods.
- `requestScope.adminFoodList`: admin food table data.
- `requestScope.globalOrderList`: admin order table data.
- `requestScope.orderId`, `estimatedTime`, `finalAmount`: checkout receipt data.

## Notes

- `setup_user.sql` should be executed by a MySQL account with permission to create users and grant privileges.
- The Java application connects to MySQL using the `foodapp` account.
- `schema.sql` rebuilds the database tables.
- `seed.sql` inserts the demo data used for testing and presentation.
- The shopping cart is handled in the session during browsing and checkout.
- Confirmed orders are stored permanently in the MySQL database.
