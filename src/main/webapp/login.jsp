<%
request.setAttribute("pageTitle", "Login");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<form class="form" action="<%= ctx %>/login" method="post" onsubmit="return requireFields(this, ['loginKey','password'])">
  <h1>Customer Login</h1>
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
</form>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
