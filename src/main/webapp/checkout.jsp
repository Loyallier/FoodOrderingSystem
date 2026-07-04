<%@ page import="com.foodorder.model.Cart, com.foodorder.model.CartItem" %>
<%
request.setAttribute("pageTitle", "Checkout - Food Ordering");
Cart checkoutCart = (Cart) session.getAttribute("cart");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="section-title">
  <h2>Checkout</h2>
  <span class="muted">Payment is simulated for this coursework system.</span>
</div>

<div class="split">
  <section class="form">
    <h3>Order Summary</h3>
    <% for (CartItem item : checkoutCart.getItems()) { %>
      <p><strong><%= item.getFoodName() %></strong> x <%= item.getQuantity() %><br><span class="muted"><%= item.getAddons().isBlank() ? "No add-ons" : item.getAddons() %></span></p>
    <% } %>
    <h3>Total: RM <%= checkoutCart.getTotalAmount() %></h3>
  </section>

  <form class="form" action="<%= ctx %>/checkout" method="post" onsubmit="return requireFields(this, ['delivery_address','contact_phone','payment_method'])">
    <div class="field">
      <label for="delivery_address">Delivery Address</label>
      <textarea id="delivery_address" name="delivery_address"></textarea>
    </div>
    <div class="field">
      <label for="contact_phone">Contact Phone</label>
      <input id="contact_phone" name="contact_phone">
    </div>
    <div class="field">
      <label for="payment_method">Payment Method</label>
      <select id="payment_method" name="payment_method">
        <option value="">Select</option>
        <option value="Simulated Card Payment">Simulated Card Payment</option>
        <option value="Cash on Delivery">Cash on Delivery</option>
      </select>
    </div>
    <button class="btn" type="submit">Confirm Order</button>
  </form>
</div>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
