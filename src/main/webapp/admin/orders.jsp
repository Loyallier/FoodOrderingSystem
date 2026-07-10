<%@ page import="java.util.List, com.foodorder.model.Order, com.foodorder.model.OrderItem" %>
<%
request.setAttribute("pageTitle", "Admin Orders");
List<Order> globalOrderList = (List<Order>) request.getAttribute("globalOrderList");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="admin-nav">
  <a class="btn secondary" href="<%= ctx %>/admin/dashboard">Dashboard</a>
  <a class="btn secondary" href="<%= ctx %>/admin/foods">Foods</a>
  <a class="btn secondary" href="<%= ctx %>/admin/categories">Categories</a>
  <a class="btn" href="<%= ctx %>/admin/orders">Orders</a>
</div>

<div class="section-title"><h2>Customer Orders</h2></div>
<% if (globalOrderList == null || globalOrderList.isEmpty()) { %>
  <div class="alert error">No Order Available.</div>
<% } else { %>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Order</th>
          <th>Customer</th>
          <th>Items</th>
          <th>Total</th>
          <th>Time</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <% for (Order order : globalOrderList) { %>
          <tr>
            <td>#<%= order.getOrderId() %></td>
            <td><%= order.getCustomerName() %><br><span class="muted"><%= order.getContactPhone() %></span></td>
            <td>
              <% for (OrderItem item : order.getItems()) { %>
                <div><%= item.getFoodName() %> x <%= item.getQuantity() %> - RM <%= item.getSubtotal() %></div>
              <% } %>
            </td>
            <td>RM <%= order.getTotalAmount() %></td>
            <td><%= order.getOrderTime() %></td>
            <td><%= order.getOrderStatus() %> / <%= order.getPaymentStatus() %></td>
            <td>
              <form action="<%= ctx %>/AdminOrderServlet" method="post" style="margin-bottom:8px;">
                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                <input type="hidden" name="status" value="COMPLETED">
                <button class="btn" type="submit">Complete</button>
              </form>
              <form action="<%= ctx %>/AdminOrderServlet" method="post">
                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                <input type="hidden" name="status" value="CANCELLED">
                <button class="btn danger" type="submit">Cancel</button>
              </form>
            </td>
          </tr>
        <% } %>
      </tbody>
    </table>
  </div>
<% } %>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
