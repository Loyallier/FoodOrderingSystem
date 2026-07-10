<%@ page import="java.util.List, com.foodorder.model.Food" %>
<%
request.setAttribute("pageTitle", "MellowBite - Premium Dining");
List<Food> featuredFoodList = (List<Food>) request.getAttribute("featuredFoodList");
List<Food> popularFoodList = (List<Food>) request.getAttribute("popularFoodList");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="hero reveal">
  <div class="hero-copy">
    <p class="eyebrow">Premium dining, delivered warm</p>
    <h1>Elegant restaurant favorites, ordered with ease.</h1>
    <p>Refined dishes, warm golden ambience, and a smooth ordering flow shaped for a modern luxury restaurant experience.</p>
    <div class="actions">
      <a class="btn" href="<%= ctx %>/MenuServlet">Order Now</a>
      <a class="btn secondary" href="#specials">View Specials</a>
    </div>
    <div class="hero-stats" aria-label="Restaurant highlights">
      <span><strong>Chef</strong> selected</span>
      <span><strong>4.9</strong> guest rating</span>
      <span><strong>Fresh</strong> daily</span>
    </div>
  </div>
  <div class="hero-media">
    <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=1200&q=80" alt="Elegant fine dining table with plated food">
  </div>
</section>

<div class="section-title reveal">
  <h2>Featured Dishes</h2>
  <a class="muted" href="<%= ctx %>/MenuServlet">View full menu</a>
</div>
<div class="grid">
  <% for (Food food : featuredFoodList) { %>
    <article class="card food-card reveal">
      <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
      <div class="card-body">
        <h3><%= food.getFoodName() %></h3>
        <p class="muted"><%= food.getDescription() %></p>
        <p class="card-meta"><span class="price">RM <%= food.getPrice() %></span> <span class="rating"><%= food.getRating() %> stars</span></p>
        <div class="actions">
          <a class="btn secondary" href="<%= ctx %>/food-detail?foodId=<%= food.getFoodId() %>">Customize</a>
        </div>
      </div>
    </article>
  <% } %>
</div>

<div class="section-title reveal">
  <div>
    <p class="eyebrow">Popular Choices</p>
    <h2>Guest Favorites</h2>
  </div>
  <a class="muted" href="<%= ctx %>/MenuServlet">Explore menu</a>
</div>
<section class="promo-grid reveal" aria-label="Popular choices">
  <% for (Food food : popularFoodList) { %>
    <article class="promo-card">
      <div class="promo-image">
        <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
        <span class="promo-badge hot">Popular</span>
      </div>
      <div class="promo-body">
        <span class="date-badge"><%= food.getCategoryName() %></span>
        <h2><%= food.getFoodName() %></h2>
        <p><%= food.getDescription() %></p>
        <p class="card-meta"><span class="price">RM <%= food.getPrice() %></span> <span class="rating"><%= food.getRating() %> stars</span></p>
        <a class="promo-link" href="<%= ctx %>/food-detail?foodId=<%= food.getFoodId() %>" aria-label="View <%= food.getFoodName() %> details">View Details <span aria-hidden="true">-&gt;</span></a>
      </div>
    </article>
  <% } %>
</section>

<div id="specials" class="section-title reveal">
  <div>
    <p class="eyebrow">Featured Specials</p>
    <h2>Chef&apos;s Recommendations</h2>
  </div>
  <a class="muted" href="<%= ctx %>/MenuServlet">Explore menu</a>
</div>
<section class="specials-layout reveal" aria-label="Featured restaurant specials">
  <aside class="special-side-panel">
    <p class="eyebrow">Chef&apos;s Pick</p>
    <h3>Angus Truffle Burger</h3>
    <p class="price">RM 29.90</p>
    <span>Premium Beef</span>
    <span>Limited Edition</span>
    <a class="btn secondary" href="<%= ctx %>/MenuServlet">Order</a>
  </aside>

  <div class="specials-main">
    <article class="promo-card special-feature">
      <div class="promo-image">
        <img src="https://images.unsplash.com/photo-1551218808-94e220e084d2?auto=format&fit=crop&w=1200&q=80" alt="Chef plating a fine dining dish">
        <span class="promo-badge hot">Signature</span>
      </div>
      <div class="promo-body">
        <span class="date-badge">Chef Curated</span>
        <h2>Golden Signature Tasting Set</h2>
        <p>A premium main dish, crisp side, and handcrafted drink with warm golden presentation for lunch or dinner.</p>
        <a class="promo-link" href="<%= ctx %>/MenuServlet" aria-label="Order Golden Signature Tasting Set">Order Set <span aria-hidden="true">-&gt;</span></a>
      </div>
    </article>

    <div class="special-mini-grid">
      <article class="luxury-mini-card">
        <span class="card-icon">CR</span>
        <h3>Chef Recipes</h3>
        <p>Michelin-inspired flavor pairings and refined plating.</p>
      </article>
      <article class="luxury-mini-card">
        <span class="card-icon">20</span>
        <h3>Weekday Offer</h3>
        <p>Enjoy 20% off selected premium sets before 5 PM.</p>
      </article>
      <article class="luxury-mini-card">
        <span class="card-icon">4.9</span>
        <h3>Guest Rated</h3>
        <p>High-rated menu choices with polished service flow.</p>
      </article>
    </div>
  </div>

  <aside class="special-side-panel">
    <p class="eyebrow">Special Offer</p>
    <h3>Seasonal Reserve</h3>
    <p class="price">20% OFF</p>
    <span>Free Drink</span>
    <span>Weekdays</span>
    <a class="btn secondary" href="<%= ctx %>/MenuServlet">Reserve Now</a>
  </aside>
</section>

<section id="about" class="section-band reveal">
  <div class="section-title">
    <h2>About MellowBite</h2>
    <a class="muted" href="<%= ctx %>/about">Read our story</a>
  </div>
  <div class="home-about-panel">
    <article class="story-card">
      <p class="eyebrow">Warm, refined, fresh</p>
      <h2>Built for polished meals and confident choices.</h2>
      <p class="muted">MellowBite pairs cinematic food photos, clear item details, quick cart controls, and a calm checkout flow for restaurant customers.</p>
    </article>
    <div class="mini-stats">
      <span><strong>500+</strong> Menu Items</span>
      <span><strong>20K+</strong> Happy Customers</span>
      <span><strong>4.9</strong> Average Rating</span>
    </div>
  </div>
</section>

<section id="faq" class="section-band reveal">
  <div class="section-title">
    <h2>FAQ</h2>
    <a class="muted" href="<%= ctx %>/faq">View all answers</a>
  </div>
  <div class="faq-accordion">
    <details class="faq-item" open>
      <summary><span class="card-icon">AC</span> Do I need an account?</summary>
      <p>Guests can browse the menu. Login is required before adding items to cart or checking out.</p>
    </details>
    <details class="faq-item">
      <summary><span class="card-icon">PY</span> Is payment real?</summary>
      <p>Payment is simulated for this coursework system. Successful checkout records the order as paid.</p>
    </details>
    <details class="faq-item">
      <summary><span class="card-icon">CT</span> Can I change my cart?</summary>
      <p>Yes. Users can update item quantities, remove dishes, and review the final amount before checkout.</p>
    </details>
  </div>
</section>

<section id="contact" class="section-band reveal">
  <div class="section-title">
    <h2>Contact</h2>
  </div>
  <form class="form contact-form" onsubmit="fakeContactSubmit(event)">
    <div class="field">
      <label>Name</label>
      <input name="name">
    </div>
    <div class="field">
      <label>Email</label>
      <input name="email" type="email">
    </div>
    <div class="field">
      <label>Message</label>
      <textarea name="message"></textarea>
    </div>
    <button class="btn" type="submit">Send Message</button>
  </form>
</section>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
