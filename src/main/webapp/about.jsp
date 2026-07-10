<%
request.setAttribute("pageTitle", "About - MellowBite");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="about-hero reveal">
  <div class="about-hero-copy">
    <p class="eyebrow">About MellowBite</p>
    <h1>Warm fast-food favorites with a calmer ordering flow.</h1>
    <p>MellowBite brings together clear menu browsing, generous food photography, fresh ingredients, and a simple checkout experience for busy customers.</p>
    <div class="actions">
      <a class="btn" href="<%= ctx %>/MenuServlet">Order Now</a>
      <a class="btn secondary" href="<%= ctx %>/home#contact">Contact Us</a>
    </div>
  </div>
  <div class="about-hero-media">
    <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80" alt="Restaurant team preparing fresh food">
  </div>
</section>

<section class="stats-grid reveal" aria-label="MellowBite achievements">
  <article class="stat-card">
    <span class="card-icon">MB</span>
    <strong>500+</strong>
    <span>Menu Items</span>
  </article>
  <article class="stat-card">
    <span class="card-icon">CU</span>
    <strong>20K+</strong>
    <span>Happy Customers</span>
  </article>
  <article class="stat-card">
    <span class="card-icon">RT</span>
    <strong>4.9</strong>
    <span>Average Rating</span>
  </article>
  <article class="stat-card">
    <span class="card-icon">DL</span>
    <strong>15 min</strong>
    <span>Average Prep</span>
  </article>
</section>

<section class="story-grid reveal">
  <article class="story-card">
    <p class="eyebrow">Our Story</p>
    <h2>Food that feels quick, fresh, and considered.</h2>
    <p class="muted">We built MellowBite around the way people actually order: scan the food, understand the price, customize quickly, and checkout without confusion.</p>
  </article>
  <article class="mission-card">
    <div>
      <span class="card-icon">MS</span>
      <h3>Mission</h3>
      <p class="muted">Serve feel-good meals through a clean, friendly ordering system.</p>
    </div>
    <div>
      <span class="card-icon">VS</span>
      <h3>Vision</h3>
      <p class="muted">Make online restaurant ordering more transparent, warm, and reliable.</p>
    </div>
  </article>
</section>

<section class="about-section reveal">
  <div class="section-title">
    <h2>Why Choose Us</h2>
  </div>
  <div class="value-grid">
    <article class="value-card">
      <span class="card-icon">FR</span>
      <h3>Fresh Ingredients</h3>
      <p class="muted">Menu details highlight ingredients, nutrition notes, and food images clearly.</p>
    </article>
    <article class="value-card">
      <span class="card-icon">FD</span>
      <h3>Fast Ordering</h3>
      <p class="muted">Category filters, item pages, cart editing, and checkout stay easy to follow.</p>
    </article>
    <article class="value-card">
      <span class="card-icon">QS</span>
      <h3>Quality Service</h3>
      <p class="muted">Customers can review orders, track history, and keep control before payment.</p>
    </article>
    <article class="value-card">
      <span class="card-icon">AW</span>
      <h3>Premium Taste</h3>
      <p class="muted">Warm visuals, soft cards, and clear ratings make each choice feel confident.</p>
    </article>
  </div>
</section>

<section class="timeline-section reveal">
  <div class="section-title">
    <h2>How We Serve</h2>
  </div>
  <div class="timeline">
    <article>
      <span>01</span>
      <h3>Browse</h3>
      <p class="muted">Explore large photos, categories, ratings, prices, and dish details.</p>
    </article>
    <article>
      <span>02</span>
      <h3>Customize</h3>
      <p class="muted">Choose quantities and confirm the dishes that fit your meal.</p>
    </article>
    <article>
      <span>03</span>
      <h3>Checkout</h3>
      <p class="muted">Review your cart and complete the simulated payment flow.</p>
    </article>
    <article>
      <span>04</span>
      <h3>Enjoy</h3>
      <p class="muted">Order records stay available in history for easy follow-up.</p>
    </article>
  </div>
</section>

<section class="restaurant-cta reveal">
  <div>
    <p class="eyebrow">Ready when you are</p>
    <h2>Find your next favorite meal.</h2>
  </div>
  <div class="actions">
    <a class="btn" href="<%= ctx %>/MenuServlet">View Menu</a>
    <a class="btn secondary" href="<%= ctx %>/home#faq">Read FAQ</a>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
