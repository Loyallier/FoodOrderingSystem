<%@ page import="java.util.List, com.foodorder.model.Food, com.foodorder.model.Category" %>
<%
request.setAttribute("pageTitle", "Admin Foods");
List<Food> adminFoodList = (List<Food>) request.getAttribute("adminFoodList");
List<Category> adminCategoryList = (List<Category>) request.getAttribute("adminCategoryList");
Food editFood = (Food) request.getAttribute("editFood");
boolean editingFood = editFood != null;
%>
<%!
private String h(Object value) {
    if (value == null) {
        return "";
    }
    return value.toString()
            .replace("&", "&amp;")
            .replace("\"", "&quot;")
            .replace("<", "&lt;")
            .replace(">", "&gt;");
}
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="admin-nav">
  <a class="btn secondary" href="<%= ctx %>/admin/dashboard">Dashboard</a>
  <a class="btn" href="<%= ctx %>/admin/foods">Foods</a>
  <a class="btn secondary" href="<%= ctx %>/admin/categories">Categories</a>
  <a class="btn secondary" href="<%= ctx %>/admin/orders">Orders</a>
</div>

<form class="form wide" action="<%= ctx %>/AdminSaveFoodServlet" method="post" enctype="multipart/form-data">
  <div class="section-title compact-title">
    <h2><%= editingFood ? "Edit Food" : "Add Food" %></h2>
    <% if (editingFood) { %>
      <a class="btn secondary" href="<%= ctx %>/admin/foods">Cancel Edit</a>
    <% } %>
  </div>
  <input type="hidden" name="action" value="save">
  <div class="split">
    <div>
      <div class="field">
        <label>Food ID</label>
        <input name="foodId" value="<%= editingFood ? editFood.getFoodId() : "" %>" readonly placeholder="Auto for new food">
      </div>
      <div class="field">
        <label>Food Name</label>
        <input name="foodName" value="<%= editingFood ? h(editFood.getFoodName()) : "" %>">
      </div>
      <div class="field">
        <label>Category</label>
        <select name="categoryId">
          <% for (Category category : adminCategoryList) { %>
            <option value="<%= category.getCategoryId() %>"
              <%= editingFood && editFood.getCategoryId() == category.getCategoryId() ? "selected" : "" %>><%= h(category.getCategoryName()) %></option>
          <% } %>
        </select>
      </div>
      <div class="field">
        <label>Price</label>
        <input name="price" type="number" step="0.01" min="0.01" value="<%= editingFood ? editFood.getPrice() : "" %>">
      </div>
      <div class="field">
        <label>Rating</label>
        <input name="rating" type="number" step="0.1" min="0" max="5" value="<%= editingFood ? editFood.getRating() : "4.0" %>">
      </div>
    </div>
    <div>
      <div class="field">
        <label>Description</label>
        <textarea name="description"><%= editingFood ? h(editFood.getDescription()) : "" %></textarea>
      </div>
      <div class="field">
        <label>Ingredients</label>
        <textarea name="ingredients"><%= editingFood ? h(editFood.getIngredients()) : "" %></textarea>
      </div>
      <div class="field">
        <label>Nutrition</label>
        <textarea name="nutrition"><%= editingFood ? h(editFood.getNutrition()) : "" %></textarea>
      </div>
      <div class="field">
        <label>Image URL</label>
        <input name="imageUrl" value="<%= editingFood ? h(editFood.getImageUrl()) : "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=80" %>">
      </div>
      <div class="field">
        <label>Food Image</label>
        <input name="foodImage" type="file" accept="image/*">
      </div>
      <label><input type="checkbox" name="isAvailable" <%= !editingFood || editFood.isAvailable() ? "checked" : "" %> style="width:auto;min-height:auto;"> Available</label>
      <label><input type="checkbox" name="isFeatured" <%= editingFood && editFood.isFeatured() ? "checked" : "" %> style="width:auto;min-height:auto;"> Featured</label>
      <label><input type="checkbox" name="isPopular" <%= editingFood && editFood.isPopular() ? "checked" : "" %> style="width:auto;min-height:auto;"> Popular</label>
    </div>
  </div>
  <button class="btn" type="submit"><%= editingFood ? "Save Changes" : "Add Food" %></button>
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
          <td><strong><%= h(food.getFoodName()) %></strong><br><span class="muted"><%= h(food.getDescription()) %></span></td>
          <td><%= h(food.getCategoryName()) %></td>
          <td>RM <%= food.getPrice() %></td>
          <td><%= food.getRating() %></td>
          <td><%= food.isAvailable() ? "Available" : "Disabled" %></td>
          <td>
            <div class="inline-actions">
              <a class="btn secondary" href="<%= ctx %>/admin/foods?editFoodId=<%= food.getFoodId() %>">Edit</a>
              <form action="<%= ctx %>/AdminDeleteFoodServlet" method="post">
                <input type="hidden" name="action" value="disable">
                <input type="hidden" name="foodId" value="<%= food.getFoodId() %>">
                <button class="btn danger" type="submit">Disable</button>
              </form>
              <form action="<%= ctx %>/AdminRemoveFoodServlet" method="post" onsubmit="return confirm('Delete this food item permanently? Use Disable if it has order history.')">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="foodId" value="<%= food.getFoodId() %>">
                <button class="btn danger ghost-danger" type="submit">Delete</button>
              </form>
            </div>
          </td>
        </tr>
      <% } %>
    </tbody>
  </table>
</div>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
