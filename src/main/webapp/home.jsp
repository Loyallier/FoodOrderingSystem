<%@ page import="java.util.List, com.foodorder.model.Food" %>
<%
request.setAttribute("pageTitle", "Home - Food Ordering");
List<Food> featuredFoodList = (List<Food>) request.getAttribute("featuredFoodList");
List<Food> popularFoodList = (List<Food>) request.getAttribute("popularFoodList");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="hero">
  <div class="hero-copy">
    <h1>Fresh meals ready for campus delivery.</h1>
    <p>Browse categorized dishes, review ingredients and nutrition, customize add-ons, and place your order in one clean flow.</p>
    <div class="actions">
      <a class="btn" href="<%= ctx %>/menu">Start Ordering</a>
      <a class="btn secondary" href="<%= ctx %>/about">About Us</a>
    </div>
  </div>
  <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80" alt="Restaurant dishes">
</section>

<div class="section-title">
  <h2>Featured Dishes</h2>
  <a class="muted" href="<%= ctx %>/menu">View full menu</a>
</div>
<div class="grid">
  <% for (Food food : featuredFoodList) { %>
    <article class="card">
      <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
      <div class="card-body">
        <h3><%= food.getFoodName() %></h3>
        <p class="muted"><%= food.getDescription() %></p>
        <p><span class="price">RM <%= food.getPrice() %></span> <span class="rating">Rating <%= food.getRating() %></span></p>
        <div class="actions">
          <a class="btn secondary" href="<%= ctx %>/food-detail?foodId=<%= food.getFoodId() %>">Details</a>
        </div>
      </div>
    </article>
  <% } %>
</div>

<div class="section-title">
  <h2>Popular Choices</h2>
</div>
<div class="grid">
  <% for (Food food : popularFoodList) { %>
    <article class="card">
      <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
      <div class="card-body">
        <h3><%= food.getFoodName() %></h3>
        <p class="muted"><%= food.getCategoryName() %> / <%= food.getReviewCount() %> reviews</p>
        <p class="price">RM <%= food.getPrice() %></p>
      </div>
    </article>
  <% } %>
</div>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
