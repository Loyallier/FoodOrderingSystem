<%
request.setAttribute("pageTitle", "Order Confirmation");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="form">
  <h1>Order success</h1>
  <p>Your order has been placed successfully.</p>
  <p><strong>Order ID:</strong> <%= request.getAttribute("orderId") %></p>
  <p><strong>Final Amount:</strong> RM <%= request.getAttribute("finalAmount") %></p>
  <p><strong>Estimated Delivery Time:</strong> <%= request.getAttribute("estimatedTime") %></p>
  <div class="actions">
    <a class="btn" href="<%= ctx %>/MenuServlet">Order More</a>
    <a class="btn secondary" href="<%= ctx %>/orders/history">View History</a>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
