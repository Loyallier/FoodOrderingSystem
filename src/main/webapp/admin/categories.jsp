<%@ page import="java.util.List, com.foodorder.model.Category" %>
<%
request.setAttribute("pageTitle", "Admin Categories");
List<Category> adminCategoryList = (List<Category>) request.getAttribute("adminCategoryList");
Category editCategory = (Category) request.getAttribute("editCategory");
boolean editingCategory = editCategory != null;
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
  <a class="btn secondary" href="<%= ctx %>/admin/foods">Foods</a>
  <a class="btn" href="<%= ctx %>/admin/categories">Categories</a>
  <a class="btn secondary" href="<%= ctx %>/admin/orders">Orders</a>
</div>

<form class="form" action="<%= ctx %>/admin/categories" method="post">
  <div class="section-title compact-title">
    <h2><%= editingCategory ? "Edit Category" : "Add Category" %></h2>
    <% if (editingCategory) { %>
      <a class="btn secondary" href="<%= ctx %>/admin/categories">Cancel Edit</a>
    <% } %>
  </div>
  <input type="hidden" name="categoryId" value="<%= editingCategory ? editCategory.getCategoryId() : "" %>">
  <div class="field">
    <label>Category Name</label>
    <input name="categoryName" value="<%= editingCategory ? h(editCategory.getCategoryName()) : "" %>">
  </div>
  <div class="field">
    <label>Description</label>
    <textarea name="description"><%= editingCategory ? h(editCategory.getDescription()) : "" %></textarea>
  </div>
  <button class="btn" type="submit"><%= editingCategory ? "Save Changes" : "Add Category" %></button>
</form>

<div class="section-title"><h2>Category List</h2></div>
<div class="table-wrap">
  <table>
    <thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Action</th></tr></thead>
    <tbody>
      <% for (Category category : adminCategoryList) { %>
        <tr>
          <td><%= category.getCategoryId() %></td>
          <td><%= h(category.getCategoryName()) %></td>
          <td><%= h(category.getDescription()) %></td>
          <td>
            <div class="inline-actions">
              <a class="btn secondary" href="<%= ctx %>/admin/categories?editCategoryId=<%= category.getCategoryId() %>">Edit</a>
              <form action="<%= ctx %>/admin/categories" method="post" onsubmit="return confirm('Delete this category permanently?')">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>">
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
