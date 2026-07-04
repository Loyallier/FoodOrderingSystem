# Food Ordering System

Java EE / JSP / Servlet coursework project for a Food Ordering and Restaurant Management Website.

## Runtime

- Java 21, based on the Eclipse project settings.
- Apache Tomcat 10.1.
- Jakarta Servlet API, using `jakarta.servlet.*`.

## Run in Eclipse

1. Import this folder as an existing Eclipse Dynamic Web Project.
2. Configure Apache Tomcat 10.1 as the target runtime.
3. Run the project on the server.
4. Open:

```text
http://localhost:8080/FoodOrderingSystem/
```

## Demo Accounts

Admin:

```text
username: admin
password: admin123
```

Customer:

```text
username: customer
password: password
```

## Current Data Layer

The current implementation uses `AppStore`, an in-memory data store, so the app can be demonstrated before the MySQL DAO is ready.

The Servlet and JSP attribute names follow `ass/java/requirements-final.md`, so the in-memory store can later be replaced with MySQL DAO classes without changing the page flow.

## Main URLs

- `/home`
- `/menu`
- `/food-detail?foodId=1`
- `/cart`
- `/checkout`
- `/orders/history`
- `/login`
- `/register`
- `/admin/dashboard`
- `/admin/foods`
- `/admin/categories`
- `/admin/orders`

