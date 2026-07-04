<%@ page import="java.util.List, com.foodorder.model.Category, com.foodorder.model.Food" %>
<%
request.setAttribute("pageTitle", "Menu - Food Ordering");
List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
List<Food> foodList = (List<Food>) request.getAttribute("foodList");
Integer selectedCategoryId = (Integer) request.getAttribute("selectedCategoryId");
if (selectedCategoryId == null) {
    selectedCategoryId = 0;
}
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="section-title">
  <h2>Menu</h2>
  <span class="muted">Ingredients, nutrition, prices, ratings, and add-ons are included.</span>
</div>

<div class="filters">
  <a class="<%= selectedCategoryId == 0 ? "active" : "" %>" href="<%= ctx %>/menu">All</a>
  <% for (Category category : categoryList) { %>
    <a class="<%= selectedCategoryId == category.getCategoryId() ? "active" : "" %>"
       href="<%= ctx %>/menu?categoryId=<%= category.getCategoryId() %>"><%= category.getCategoryName() %></a>
  <% } %>
</div>

<% if (foodList == null || foodList.isEmpty()) { %>
  <div class="alert error">No Item Available.</div>
<% } else { %>
  <div class="grid">
    <% for (Food food : foodList) { %>
      <article class="card">
        <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
        <div class="card-body">
          <h3><%= food.getFoodName() %></h3>
          <p class="muted"><%= food.getCategoryName() %></p>
          <p><%= food.getDescription() %></p>
          <p><span class="price">RM <%= food.getPrice() %></span> <span class="rating">Rating <%= food.getRating() %></span></p>
          <div class="actions">
            <a class="btn secondary" href="<%= ctx %>/food-detail?foodId=<%= food.getFoodId() %>">Details</a>
            <form action="<%= ctx %>/cart" method="post" onsubmit="return validateQuantity(this)">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="foodId" value="<%= food.getFoodId() %>">
              <input type="hidden" name="quantity" value="1">
              <button class="btn" type="submit">Add to Cart</button>
            </form>
          </div>
        </div>
      </article>
    <% } %>
  </div>
<% } %>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
