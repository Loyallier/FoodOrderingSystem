<%@ page import="java.util.List, com.foodorder.model.Food" %>
<%
request.setAttribute("pageTitle", "MellowBite - Fresh Fast Food");
List<Food> featuredFoodList = (List<Food>) request.getAttribute("featuredFoodList");
List<Food> popularFoodList = (List<Food>) request.getAttribute("popularFoodList");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="hero reveal">
  <div class="hero-copy">
    <p class="eyebrow">Fast, warm, made fresh</p>
    <h1>Feel-good fast food, ordered in seconds.</h1>
    <p>Big flavor, clear choices, and a checkout flow built for hungry people. Pick a favorite, customize it, and get back to your day.</p>
    <div class="actions">
      <a class="btn" href="<%= ctx %>/MenuServlet">Order Now</a>
      <a class="btn secondary" href="#popular">View Favorites</a>
    </div>
    <div class="hero-stats" aria-label="Restaurant highlights">
      <span><strong>15 min</strong> avg prep</span>
      <span><strong>4.8</strong> guest rating</span>
      <span><strong>Fresh</strong> daily</span>
    </div>
  </div>
  <div class="hero-media">
    <img src="https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=1200&q=80" alt="Fresh burger and fries">
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

<div id="popular" class="section-title reveal">
  <h2>Popular Choices</h2>
</div>
<div class="grid">
  <% for (Food food : popularFoodList) { %>
    <article class="card food-card compact reveal">
      <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
      <div class="card-body">
        <h3><%= food.getFoodName() %></h3>
        <p class="muted"><%= food.getCategoryName() %> / <%= food.getReviewCount() %> reviews</p>
        <p class="price">RM <%= food.getPrice() %></p>
      </div>
    </article>
  <% } %>
</div>

<section id="about" class="section-band reveal">
  <div class="section-title">
    <h2>About MellowBite</h2>
    <a class="muted" href="<%= ctx %>/about">Read our story</a>
  </div>
  <div class="home-about-panel">
    <article class="story-card">
      <p class="eyebrow">Warm, fast, fresh</p>
      <h2>Built for easy meals and confident choices.</h2>
      <p class="muted">MellowBite pairs large food photos, clear item details, quick cart controls, and a calm checkout flow for restaurant customers.</p>
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
