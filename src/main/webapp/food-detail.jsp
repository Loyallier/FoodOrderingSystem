<%@ page import="com.foodorder.model.Food" %>
<%
Food food = (Food) request.getAttribute("food");
request.setAttribute("pageTitle", food.getFoodName() + " - MellowBite");
%>
<%@ include file="/WEB-INF/jsp/header.jspf" %>

<section class="detail reveal">
  <img src="<%= food.getImageUrl() %>" alt="<%= food.getFoodName() %>">
  <div>
    <p class="eyebrow"><%= food.getCategoryName() %></p>
    <h1><%= food.getFoodName() %></h1>
    <p><%= food.getDescription() %></p>
    <p><strong>Ingredients:</strong> <%= food.getIngredients() %></p>
    <p><strong>Nutrition:</strong> <%= food.getNutrition() %></p>
    <p class="card-meta"><span class="price">RM <%= food.getPrice() %></span> <span class="rating"><%= food.getRating() %> stars / <%= food.getReviewCount() %> reviews</span></p>

    <form class="form" action="<%= ctx %>/CartServlet" method="post" onsubmit="return validateQuantity(this)">
      <input type="hidden" name="action" value="add">
      <input type="hidden" name="foodId" value="<%= food.getFoodId() %>">
      <div class="field">
        <label for="quantity">Quantity</label>
        <input id="quantity" type="number" name="quantity" value="1" min="1">
      </div>
      <div class="field">
        <label>Add-ons</label>
        <label><input type="checkbox" name="addons" value="Extra Cheese" style="width:auto;min-height:auto;"> Extra Cheese (+RM 1.50)</label><br>
        <label><input type="checkbox" name="addons" value="Drink" style="width:auto;min-height:auto;"> Drink (+RM 3.00)</label><br>
        <label><input type="checkbox" name="addons" value="Large Portion" style="width:auto;min-height:auto;"> Large Portion (+RM 4.00)</label>
      </div>
      <button class="btn" type="submit">Add to Cart</button>
    </form>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/footer.jspf" %>
