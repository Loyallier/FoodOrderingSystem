<%
request.setAttribute("pageTitle", "Promotions - MellowBite");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="promo-hero reveal">
  <div>
    <p class="eyebrow">Promotions</p>
    <h1>Fresh deals, warm meals, limited-time campaigns.</h1>
    <p class="muted">Explore MellowBite offers, seasonal bundles, and restaurant events designed for quick ordering and better value.</p>
  </div>
  <div class="promo-tabs" aria-label="Promotion categories">
    <a class="active" href="<%= ctx %>/promotions">Promotions</a>
    <a href="<%= ctx %>/promotions#events">Events</a>
  </div>
</section>

<section class="promo-grid reveal" aria-label="Current promotions">
  <article class="promo-card">
    <div class="promo-image">
      <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=80" alt="Burger combo promotion">
      <span class="promo-badge hot">Hot Deal</span>
    </div>
    <div class="promo-body">
      <span class="date-badge">10 Jul 2026</span>
      <h2>Golden Burger Combo</h2>
      <p>Enjoy a signature burger, crispy fries, and iced tea in one warm value set for lunch and dinner.</p>
      <a class="promo-link" href="<%= ctx %>/MenuServlet" aria-label="Order Golden Burger Combo">View Details <span aria-hidden="true">-&gt;</span></a>
    </div>
  </article>

  <article class="promo-card">
    <div class="promo-image">
      <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=900&q=80" alt="Pizza limited time promotion">
      <span class="promo-badge limited">Limited Time</span>
    </div>
    <div class="promo-body">
      <span class="date-badge">08 Jul 2026</span>
      <h2>Pizza Night Special</h2>
      <p>Share a cheesy pizza set with sides and drinks, crafted for evening cravings and group orders.</p>
      <a class="promo-link" href="<%= ctx %>/MenuServlet" aria-label="Order Pizza Night Special">View Details <span aria-hidden="true">-&gt;</span></a>
    </div>
  </article>

  <article class="promo-card">
    <div class="promo-image">
      <img src="https://images.unsplash.com/photo-1543352634-a1c51d9f1fa7?auto=format&fit=crop&w=900&q=80" alt="Fresh salad and bowl promotion">
      <span class="promo-badge new">New</span>
    </div>
    <div class="promo-body">
      <span class="date-badge">05 Jul 2026</span>
      <h2>Fresh Bowl Rewards</h2>
      <p>Pick a colorful bowl with premium toppings and collect rewards on your next healthy order.</p>
      <a class="promo-link" href="<%= ctx %>/MenuServlet" aria-label="Order Fresh Bowl Rewards">View Details <span aria-hidden="true">-&gt;</span></a>
    </div>
  </article>

  <article class="promo-card">
    <div class="promo-image">
      <img src="https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=900&q=80" alt="Dessert promotion">
      <span class="promo-badge limited">Weekend</span>
    </div>
    <div class="promo-body">
      <span class="date-badge">03 Jul 2026</span>
      <h2>Sweet Weekend Treat</h2>
      <p>Add a dessert to selected meals and enjoy a soft, sweet finish to your weekend order.</p>
      <a class="promo-link" href="<%= ctx %>/MenuServlet" aria-label="Order Sweet Weekend Treat">View Details <span aria-hidden="true">-&gt;</span></a>
    </div>
  </article>

  <article class="promo-card" id="events">
    <div class="promo-image">
      <img src="https://images.unsplash.com/photo-1551782450-a2132b4ba21d?auto=format&fit=crop&w=900&q=80" alt="Family meal event">
      <span class="promo-badge new">Event</span>
    </div>
    <div class="promo-body">
      <span class="date-badge">01 Jul 2026</span>
      <h2>Family Feast Day</h2>
      <p>Bring everyone together with family-sized favorites, shareable sides, and friendly bundle pricing.</p>
      <a class="promo-link" href="<%= ctx %>/MenuServlet" aria-label="Order Family Feast Day">View Details <span aria-hidden="true">-&gt;</span></a>
    </div>
  </article>

  <article class="promo-card">
    <div class="promo-image">
      <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=900&q=80" alt="Delivery bundle promotion">
      <span class="promo-badge hot">Delivery</span>
    </div>
    <div class="promo-body">
      <span class="date-badge">28 Jun 2026</span>
      <h2>Fast Delivery Bundle</h2>
      <p>Choose quick-prep favorites with drinks and sides for a smooth checkout and a satisfying meal.</p>
      <a class="promo-link" href="<%= ctx %>/MenuServlet" aria-label="Order Fast Delivery Bundle">View Details <span aria-hidden="true">-&gt;</span></a>
    </div>
  </article>
</section>

<section class="promo-cta reveal">
  <div>
    <p class="eyebrow">Ready to order?</p>
    <h2>Turn today&apos;s offer into your next meal.</h2>
  </div>
  <a class="btn" href="<%= ctx %>/MenuServlet">Order Now</a>
</section>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
