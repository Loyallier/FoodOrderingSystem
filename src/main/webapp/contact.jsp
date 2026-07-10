<%
request.setAttribute("pageTitle", "Contact - MellowBite");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="contact-hero reveal">
  <p class="eyebrow">Contact Us</p>
  <h1>We&apos;d Love to Hear From You</h1>
  <p>We are always happy to answer your questions, receive your feedback, or help with your order.</p>
</section>

<section class="contact-shell reveal">
  <div class="contact-info-stack" aria-label="Restaurant contact information">
    <article class="contact-info-card">
      <span class="contact-icon">LOC</span>
      <div>
        <h2>Restaurant Address</h2>
        <p>MellowBite Restaurant<br>Jalan Bukit Bintang, Kuala Lumpur</p>
      </div>
    </article>
    <article class="contact-info-card">
      <span class="contact-icon">TEL</span>
      <div>
        <h2>Phone</h2>
        <p>+60 12-345 6789</p>
      </div>
    </article>
    <article class="contact-info-card">
      <span class="contact-icon">MAIL</span>
      <div>
        <h2>Email</h2>
        <p>support@mellowbite.test</p>
      </div>
    </article>
    <article class="contact-info-card">
      <span class="contact-icon">TIME</span>
      <div>
        <h2>Opening Hours</h2>
        <p>10:00 AM - 10:00 PM</p>
      </div>
    </article>
  </div>

  <form class="contact-premium-form" onsubmit="fakeContactSubmit(event)">
    <div class="form-heading">
      <p class="eyebrow">Send a Message</p>
      <h2>Tell us how we can help.</h2>
    </div>
    <div class="field">
      <label>Name</label>
      <input name="name" placeholder="Your name">
    </div>
    <div class="field two-fields">
      <div>
        <label>Email</label>
        <input name="email" type="email" placeholder="you@example.com">
      </div>
      <div>
        <label>Phone</label>
        <input name="phone" placeholder="+60">
      </div>
    </div>
    <div class="field">
      <label>Subject</label>
      <input name="subject" placeholder="Order support, feedback, booking">
    </div>
    <div class="field">
      <label>Message</label>
      <textarea name="message" placeholder="Write your message"></textarea>
    </div>
    <button class="btn contact-submit" type="submit">Send Message</button>
  </form>
</section>

<section class="hours-section reveal">
  <div class="section-title">
    <h2>Business Hours</h2>
  </div>
  <div class="hours-grid">
    <article class="hour-card">
      <span class="contact-icon">WK</span>
      <h3>Monday - Friday</h3>
      <p>10:00 - 22:00</p>
    </article>
    <article class="hour-card">
      <span class="contact-icon">WE</span>
      <h3>Weekend</h3>
      <p>09:00 - 23:00</p>
    </article>
    <article class="hour-card">
      <span class="contact-icon">PH</span>
      <h3>Public Holiday</h3>
      <p>10:00 - 20:00</p>
    </article>
  </div>
</section>

<section class="location-section reveal">
  <div class="location-copy">
    <p class="eyebrow">Find Us</p>
    <h2>Visit our warm black-and-gold dining space.</h2>
    <p>Located in Kuala Lumpur with dine-in, takeaway, and delivery support for every kind of meal plan.</p>
    <div class="location-badges">
      <span>Parking Available</span>
      <span>Delivery Supported</span>
      <span>Dine-in Available</span>
    </div>
  </div>
  <div class="map-card" role="img" aria-label="Map preview for MellowBite restaurant">
    <div class="map-grid"></div>
    <div class="map-pin"><span>M</span></div>
  </div>
</section>

<section class="social-section reveal">
  <div class="section-title">
    <h2>Follow Our Kitchen</h2>
  </div>
  <div class="social-grid">
    <a class="social-card" href="#">
      <span class="contact-icon">IG</span>
      <strong>Instagram</strong>
      <span>Follow Us</span>
    </a>
    <a class="social-card" href="#">
      <span class="contact-icon">FB</span>
      <strong>Facebook</strong>
      <span>Like Us</span>
    </a>
    <a class="social-card" href="#">
      <span class="contact-icon">TT</span>
      <strong>TikTok</strong>
      <span>Watch Us</span>
    </a>
  </div>
</section>

<section class="contact-faq-cta reveal">
  <div>
    <p class="eyebrow">Still Have Questions?</p>
    <h2>Great Food, Great Service, Always Here for You.</h2>
  </div>
  <a class="btn" href="<%= ctx %>/faq">Go to FAQ</a>
</section>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
