<%@ page import="java.util.List, com.foodorder.model.Order, com.foodorder.model.OrderItem" %>
<%
request.setAttribute("pageTitle", "Order History");
List<Order> userOrderList = (List<Order>) request.getAttribute("userOrderList");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="section-title">
  <h2>Order History</h2>
</div>

<% if (userOrderList == null || userOrderList.isEmpty()) { %>
  <div class="alert error">No Order Found.</div>
<% } else { %>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Items</th>
          <th>Total</th>
          <th>Time</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <% for (Order order : userOrderList) { %>
          <tr>
            <td>#<%= order.getOrderId() %></td>
            <td>
              <% for (OrderItem item : order.getItems()) { %>
                <div><%= item.getFoodName() %> x <%= item.getQuantity() %> - RM <%= item.getSubtotal() %></div>
              <% } %>
            </td>
            <td>RM <%= order.getTotalAmount() %></td>
            <td><%= order.getOrderTime() %></td>
            <td><%= order.getOrderStatus() %> / <%= order.getPaymentStatus() %></td>
          </tr>
        <% } %>
      </tbody>
    </table>
  </div>
<% } %>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
