<%@ page import="java.util.List, com.foodorder.model.Food, com.foodorder.model.Category" %>
<%
request.setAttribute("pageTitle", "Admin Foods");
List<Food> adminFoodList = (List<Food>) request.getAttribute("adminFoodList");
List<Category> adminCategoryList = (List<Category>) request.getAttribute("adminCategoryList");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="admin-nav">
  <a class="btn secondary" href="<%= ctx %>/admin/dashboard">Dashboard</a>
  <a class="btn" href="<%= ctx %>/admin/foods">Foods</a>
  <a class="btn secondary" href="<%= ctx %>/admin/categories">Categories</a>
  <a class="btn secondary" href="<%= ctx %>/admin/orders">Orders</a>
</div>

<form class="form wide" action="<%= ctx %>/AdminSaveFoodServlet" method="post" enctype="multipart/form-data">
  <h2>Add / Update Food</h2>
  <input type="hidden" name="action" value="save">
  <div class="split">
    <div>
      <div class="field">
        <label>Food ID for update</label>
        <input name="foodId" placeholder="Leave empty for new food">
      </div>
      <div class="field">
        <label>Food Name</label>
        <input name="foodName">
      </div>
      <div class="field">
        <label>Category</label>
        <select name="categoryId">
          <% for (Category category : adminCategoryList) { %>
            <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
          <% } %>
        </select>
      </div>
      <div class="field">
        <label>Price</label>
        <input name="price" type="number" step="0.01" min="0.01">
      </div>
      <div class="field">
        <label>Rating</label>
        <input name="rating" type="number" step="0.1" min="0" max="5" value="4.0">
      </div>
    </div>
    <div>
      <div class="field">
        <label>Description</label>
        <textarea name="description"></textarea>
      </div>
      <div class="field">
        <label>Ingredients</label>
        <textarea name="ingredients"></textarea>
      </div>
      <div class="field">
        <label>Nutrition</label>
        <textarea name="nutrition"></textarea>
      </div>
      <div class="field">
        <label>Image URL</label>
        <input name="imageUrl" value="https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=80">
      </div>
      <div class="field">
        <label>Food Image</label>
        <input name="foodImage" type="file" accept="image/*">
      </div>
      <label><input type="checkbox" name="isAvailable" checked style="width:auto;min-height:auto;"> Available</label>
      <label><input type="checkbox" name="isFeatured" style="width:auto;min-height:auto;"> Featured</label>
      <label><input type="checkbox" name="isPopular" style="width:auto;min-height:auto;"> Popular</label>
    </div>
  </div>
  <button class="btn" type="submit">Save Food</button>
</form>

<div class="section-title"><h2>Food List</h2></div>
<div class="table-wrap">
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Food</th>
        <th>Category</th>
        <th>Price</th>
        <th>Rating</th>
        <th>Status</th>
        <th>Action</th>
      </tr>
    </thead>
    <tbody>
      <% for (Food food : adminFoodList) { %>
        <tr>
          <td><%= food.getFoodId() %></td>
          <td><strong><%= food.getFoodName() %></strong><br><span class="muted"><%= food.getDescription() %></span></td>
          <td><%= food.getCategoryName() %></td>
          <td>RM <%= food.getPrice() %></td>
          <td><%= food.getRating() %></td>
          <td><%= food.isAvailable() ? "Available" : "Disabled" %></td>
          <td>
            <a class="btn danger" href="<%= ctx %>/AdminDeleteFoodServlet?foodId=<%= food.getFoodId() %>">Disable</a>
          </td>
        </tr>
      <% } %>
    </tbody>
  </table>
</div>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
