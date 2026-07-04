<%@ page import="java.util.List, com.foodorder.model.Category" %>
<%
request.setAttribute("pageTitle", "Admin Categories");
List<Category> adminCategoryList = (List<Category>) request.getAttribute("adminCategoryList");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="admin-nav">
  <a class="btn secondary" href="<%= ctx %>/admin/dashboard">Dashboard</a>
  <a class="btn secondary" href="<%= ctx %>/admin/foods">Foods</a>
  <a class="btn" href="<%= ctx %>/admin/categories">Categories</a>
  <a class="btn secondary" href="<%= ctx %>/admin/orders">Orders</a>
</div>

<form class="form" action="<%= ctx %>/admin/categories" method="post">
  <h2>Add Category</h2>
  <div class="field">
    <label>Category Name</label>
    <input name="categoryName">
  </div>
  <div class="field">
    <label>Description</label>
    <textarea name="description"></textarea>
  </div>
  <button class="btn" type="submit">Add Category</button>
</form>

<div class="section-title"><h2>Category List</h2></div>
<div class="table-wrap">
  <table>
    <thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Status</th><th>Action</th></tr></thead>
    <tbody>
      <% for (Category category : adminCategoryList) { %>
        <tr>
          <td><%= category.getCategoryId() %></td>
          <td><%= category.getCategoryName() %></td>
          <td><%= category.getDescription() %></td>
          <td><%= category.isAvailable() ? "Available" : "Disabled" %></td>
          <td>
            <form action="<%= ctx %>/admin/categories" method="post">
              <input type="hidden" name="action" value="disable">
              <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>">
              <button class="btn danger" type="submit">Disable</button>
            </form>
          </td>
        </tr>
      <% } %>
    </tbody>
  </table>
</div>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
