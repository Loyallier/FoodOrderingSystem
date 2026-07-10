<%
request.setAttribute("pageTitle", "Contact - MellowBite");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<div class="split">
  <section class="form reveal">
    <h1>Contact Us</h1>
    <p><strong>Address:</strong> MellowBite Restaurant, Malaysia</p>
    <p><strong>Phone:</strong> +60 12-345 6789</p>
    <p><strong>Email:</strong> support@mellowbite.test</p>
  </section>

  <form class="form reveal" onsubmit="fakeContactSubmit(event)">
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
</div>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
