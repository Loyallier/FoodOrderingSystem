<%@ page import="java.util.List, com.foodorder.model.Food" %>
<%
request.setAttribute("pageTitle", "Home - Food Ordering");
List<Food> featuredFoodList = (List<Food>) request.getAttribute("featuredFoodList");
List<Food> popularFoodList = (List<Food>) request.getAttribute("popularFoodList");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="hero">
  <div class="hero-copy">
    <h1>Fresh meals ready for campus delivery.</h1>
    <p>Browse categorized dishes, review ingredients and nutrition, customize add-ons, and place your order in one clean flow.</p>
    <div class="actions">
      <a class="btn" href="<%= ctx %>/MenuServlet">Start Ordering</a>
      <a class="btn secondary" href="#about">About Us</a>
    </div>
    <div class="inline-links">
      <a class="small-link" href="#about">About</a>
      <a class="small-link" href="#faq">FAQ</a>
      <a class="small-link" href="#contact">Contact</a>
    </div>
  </div>
  <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80" alt="Restaurant dishes">
</section>

<div class="section-title">
  <h2>Featured Dishes</h2>
  <a class="muted" href="<%= ctx %>/MenuServlet">View full menu</a>
</div>
<div class="grid">
  <% for (Food food : featuredFoodList) { %>
    <article class="card">
      <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
      <div class="card-body">
        <h3><%= food.getFoodName() %></h3>
        <p class="muted"><%= food.getDescription() %></p>
        <p><span class="price">RM <%= food.getPrice() %></span> <span class="rating">Rating <%= food.getRating() %></span></p>
        <div class="actions">
          <a class="btn secondary" href="<%= ctx %>/food-detail?foodId=<%= food.getFoodId() %>">Details</a>
        </div>
      </div>
    </article>
  <% } %>
</div>

<div class="section-title">
  <h2>Popular Choices</h2>
</div>
<div class="grid">
  <% for (Food food : popularFoodList) { %>
    <article class="card">
      <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
      <div class="card-body">
        <h3><%= food.getFoodName() %></h3>
        <p class="muted"><%= food.getCategoryName() %> / <%= food.getReviewCount() %> reviews</p>
        <p class="price">RM <%= food.getPrice() %></p>
      </div>
    </article>
  <% } %>
</div>

<section id="about" class="section-band">
  <div class="section-title">
    <h2>About Us</h2>
  </div>
  <div class="info-columns">
    <article class="info-card">
      <h3>Campus Ordering</h3>
      <p class="muted">Food Ordering is a campus restaurant ordering system designed for quick browsing, transparent dish information, and a clean checkout flow.</p>
    </article>
    <article class="info-card">
      <h3>Clear Food Details</h3>
      <p class="muted">Each dish can show category, image, ingredients, nutrition, rating, review count, price, and optional add-ons.</p>
    </article>
    <article class="info-card">
      <h3>Admin Control</h3>
      <p class="muted">Administrators can manage food items, categories, and order status from the backend dashboard.</p>
    </article>
  </div>
</section>

<section id="faq" class="section-band">
  <div class="section-title">
    <h2>FAQ</h2>
  </div>
  <div class="info-columns">
    <article class="info-card">
      <h3>Do I need an account?</h3>
      <p class="muted">Guests can browse the menu. Login is required before adding items to cart or checking out.</p>
    </article>
    <article class="info-card">
      <h3>Is payment real?</h3>
      <p class="muted">No. Payment is simulated for this coursework system. Successful checkout records the order as paid.</p>
    </article>
    <article class="info-card">
      <h3>Can I change my cart?</h3>
      <p class="muted">Yes. Users can update item quantities, remove dishes, and review the final amount before checkout.</p>
    </article>
  </div>
</section>

<section id="contact" class="section-band">
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
