<%
request.setAttribute("pageTitle", "Login & Register");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="auth-page">
  <div class="auth-shell">
    <form class="auth-card" action="<%= ctx %>/RegisterServlet" method="post" onsubmit="return requireFields(this, ['username','email','phone_number','password'])">
      <h1>Register</h1>
      <p class="muted">Create an account before checkout.</p>
      <% if (request.getAttribute("registerError") != null) { %>
        <div class="alert error"><%= request.getAttribute("registerError") %></div>
      <% } %>
      <div class="field">
        <label for="username">Username</label>
        <input id="username" name="username" minlength="3" maxlength="20">
      </div>
      <div class="field">
        <label for="email">Email</label>
        <input id="email" name="email" type="email">
      </div>
      <div class="field">
        <label for="phone_number">Phone Number</label>
        <input id="phone_number" name="phone_number">
      </div>
      <div class="field">
        <label for="password">Password</label>
        <input id="password" name="password" type="password" minlength="6">
      </div>
      <button class="btn" type="submit">Create Account</button>
      <div class="auth-switch">
        <span>Already have an account?</span>
        <a class="small-link" href="<%= ctx %>/login">Login here</a>
        <div class="auth-links">
          <a class="small-link" href="<%= ctx %>/home#about">About Us</a>
          <a class="small-link" href="<%= ctx %>/home#faq">FAQ</a>
          <a class="small-link" href="<%= ctx %>/home#contact">Contact</a>
        </div>
      </div>
    </form>
    <aside class="auth-photo" aria-label="Fresh food photo"></aside>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
