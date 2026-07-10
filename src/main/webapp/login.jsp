<%
request.setAttribute("pageTitle", "Login & Register");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="auth-page">
  <div class="auth-shell">
    <form class="auth-card" action="<%= ctx %>/LoginServlet" method="post" onsubmit="return requireFields(this, ['loginKey','password'])">
      <h1>Login</h1>
      <p class="muted">Welcome back. Sign in to continue ordering.</p>
      <% if (request.getAttribute("loginError") != null) { %>
        <div class="alert error"><%= request.getAttribute("loginError") %></div>
      <% } %>
      <div class="field">
        <label for="loginKey">Username or Email</label>
        <input id="loginKey" name="loginKey">
      </div>
      <div class="field">
        <label for="password">Password</label>
        <input id="password" name="password" type="password">
      </div>
      <button class="btn" type="submit">Login</button>
      <p class="muted">Demo admin: admin / admin123. Demo user: customer / password.</p>
      <div class="auth-switch">
        <span>Don't have an account?</span>
        <a class="small-link" href="<%= ctx %>/register">Register here</a>
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
