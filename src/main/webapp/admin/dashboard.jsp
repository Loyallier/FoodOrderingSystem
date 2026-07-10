<%@ page import="java.util.List, com.foodorder.model.Food, com.foodorder.model.Category, com.foodorder.model.Order" %>
<%
request.setAttribute("pageTitle", "Admin Dashboard");
List<Food> adminFoodList = (List<Food>) request.getAttribute("adminFoodList");
List<Category> adminCategoryList = (List<Category>) request.getAttribute("adminCategoryList");
List<Order> globalOrderList = (List<Order>) request.getAttribute("globalOrderList");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="admin-nav">
  <a class="btn" href="<%= ctx %>/admin/foods">Food Management</a>
  <a class="btn secondary" href="<%= ctx %>/admin/categories">Category Management</a>
  <a class="btn secondary" href="<%= ctx %>/admin/orders">Order Management</a>
</div>

<div class="grid">
  <section class="card"><div class="card-body"><h3>Food Items</h3><p class="price"><%= adminFoodList.size() %></p></div></section>
  <section class="card"><div class="card-body"><h3>Categories</h3><p class="price"><%= adminCategoryList.size() %></p></div></section>
  <section class="card"><div class="card-body"><h3>Orders</h3><p class="price"><%= globalOrderList.size() %></p></div></section>
</div>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
