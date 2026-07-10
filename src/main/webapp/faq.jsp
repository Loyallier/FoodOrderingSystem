<%
request.setAttribute("pageTitle", "FAQ - MellowBite");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="form wide reveal">
  <h1>FAQ</h1>
  <h3>Do I need an account to order?</h3>
  <p>Yes. Guests can browse the menu, but checkout requires login.</p>
  <h3>Is payment real?</h3>
  <p>No. This coursework version uses simulated payment. A successful checkout records the payment as PAID.</p>
  <h3>Can I change my cart?</h3>
  <p>Yes. You can update quantities or remove items before checkout.</p>
  <h3>How do I track an order?</h3>
  <p>Use the order history page after logging in.</p>
</section>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
