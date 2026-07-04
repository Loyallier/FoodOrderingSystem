<%@ page import="com.foodorder.model.Cart, com.foodorder.model.CartItem" %>
<%
request.setAttribute("pageTitle", "Cart - Food Ordering");
Cart cart = (Cart) session.getAttribute("cart");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="section-title">
  <h2>Cart</h2>
  <a class="btn secondary" href="<%= ctx %>/menu">Continue Ordering</a>
</div>

<% if (cart == null || cart.isEmpty()) { %>
  <div class="alert error">Cart is Empty.</div>
<% } else { %>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Item</th>
          <th>Add-ons</th>
          <th>Unit Price</th>
          <th>Quantity</th>
          <th>Subtotal</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <% for (CartItem item : cart.getItems()) { %>
          <tr>
            <td><img class="cart-img" src="<%= item.getImageUrl() %>" alt=""> <strong><%= item.getFoodName() %></strong></td>
            <td><%= item.getAddons().isBlank() ? "None" : item.getAddons() %></td>
            <td>RM <%= item.getUnitPrice() %> + RM <%= item.getAddonPrice() %></td>
            <td>
              <form action="<%= ctx %>/cart" method="post" onsubmit="return validateQuantity(this)">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="foodId" value="<%= item.getFoodId() %>">
                <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" style="width:90px;">
                <button class="btn secondary" type="submit">Update</button>
              </form>
            </td>
            <td>RM <%= item.getSubtotal() %></td>
            <td>
              <form action="<%= ctx %>/cart" method="post">
                <input type="hidden" name="action" value="remove">
                <input type="hidden" name="foodId" value="<%= item.getFoodId() %>">
                <button class="btn danger" type="submit">Remove</button>
              </form>
            </td>
          </tr>
        <% } %>
      </tbody>
    </table>
  </div>
  <h3>Total: RM <%= cart.getTotalAmount() %></h3>
  <div class="actions">
    <a class="btn" href="<%= ctx %>/checkout">Checkout</a>
  </div>
<% } %>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
