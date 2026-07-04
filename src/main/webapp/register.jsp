<%
request.setAttribute("pageTitle", "Register");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<form class="form" action="<%= ctx %>/register" method="post" onsubmit="return requireFields(this, ['username','email','phone_number','password'])">
  <h1>Register Account</h1>
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
</form>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
