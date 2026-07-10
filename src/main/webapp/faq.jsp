<%
request.setAttribute("pageTitle", "FAQ - MellowBite");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="faq-hero reveal">
  <div>
    <p class="eyebrow">FAQ</p>
    <h1>Answers before you order.</h1>
    <p class="muted">Browse common questions about ordering, checkout, delivery flow, and account access.</p>
  </div>
  <div class="faq-search" aria-label="FAQ search visual">
    <span class="card-icon">?</span>
    <input type="search" placeholder="Search FAQs" aria-label="Search FAQs">
  </div>
</section>

<div class="faq-tabs reveal" aria-label="FAQ categories">
  <span>Ordering</span>
  <span>Payment</span>
  <span>Delivery</span>
  <span>Account</span>
</div>

<section class="faq-layout reveal">
  <div class="faq-accordion">
    <details class="faq-item" open>
      <summary><span class="card-icon">AC</span> Do I need an account to order?</summary>
      <p>Yes. Guests can browse the menu, but checkout requires login so the order can be saved to history.</p>
    </details>
    <details class="faq-item">
      <summary><span class="card-icon">PY</span> Is payment real?</summary>
      <p>No. This coursework version uses simulated payment. A successful checkout records the payment as PAID.</p>
    </details>
    <details class="faq-item">
      <summary><span class="card-icon">CT</span> Can I change my cart?</summary>
      <p>Yes. You can update quantities, remove dishes, and review the final amount before checkout.</p>
    </details>
    <details class="faq-item">
      <summary><span class="card-icon">TR</span> How do I track an order?</summary>
      <p>Use the order history page after logging in. It lists your previous orders and their status.</p>
    </details>
    <details class="faq-item">
      <summary><span class="card-icon">SP</span> Who can manage food items?</summary>
      <p>Administrators can manage categories, food items, and customer orders from the admin dashboard.</p>
    </details>
  </div>

  <aside class="help-card">
    <span class="card-icon">HP</span>
    <h2>Still Need Help?</h2>
    <p class="muted">Contact the restaurant team if your question is not listed here.</p>
    <div class="actions">
      <a class="btn" href="<%= ctx %>/home#contact">Contact Us</a>
      <a class="btn secondary" href="<%= ctx %>/MenuServlet">View Menu</a>
    </div>
  </aside>
</section>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
