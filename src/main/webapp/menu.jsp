<%@ page import="java.util.List, com.foodorder.model.Category, com.foodorder.model.Food" %>
<%
request.setAttribute("pageTitle", "Menu - MellowBite");
List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
List<Food> foodList = (List<Food>) request.getAttribute("foodList");
Integer selectedCategoryId = (Integer) request.getAttribute("selectedCategoryId");
if (selectedCategoryId == null) {
    selectedCategoryId = 0;
}
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="menu-header reveal">
  <div>
    <p class="eyebrow">Order faster</p>
    <h1>Pick your next favorite.</h1>
  </div>
  <span class="muted">Fresh photos, clear prices, quick add-to-cart.</span>
</section>

<div class="filters">
  <a class="<%= selectedCategoryId == 0 ? "active" : "" %>" href="<%= ctx %>/MenuServlet">All</a>
  <% for (Category category : categoryList) { %>
    <a class="<%= selectedCategoryId == category.getCategoryId() ? "active" : "" %>"
       href="<%= ctx %>/MenuServlet?categoryId=<%= category.getCategoryId() %>"><%= category.getCategoryName() %></a>
  <% } %>
</div>

<% if (foodList == null || foodList.isEmpty()) { %>
  <div class="alert error">No Item Available.</div>
<% } else { %>
  <div class="grid">
    <% for (Food food : foodList) { %>
      <article class="card food-card reveal">
        <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
        <div class="card-body">
          <h3><%= food.getFoodName() %></h3>
          <p class="muted"><%= food.getCategoryName() %></p>
          <p><%= food.getDescription() %></p>
          <p class="card-meta"><span class="price">RM <%= food.getPrice() %></span> <span class="rating"><%= food.getRating() %> stars</span></p>
          <div class="actions">
            <a class="btn secondary" href="<%= ctx %>/food-detail?foodId=<%= food.getFoodId() %>">Details</a>
            <form action="<%= ctx %>/CartServlet" method="post" onsubmit="return validateQuantity(this)">
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
