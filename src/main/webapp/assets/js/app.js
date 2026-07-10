function showFieldError(input, message) {
  alert(message);
  if (input) input.focus();
  return false;
}

function requireFields(form, fields) {
  for (const field of fields) {
    const input = form.querySelector(`[name="${field}"]`);
    if (!input || !input.value.trim()) {
      return showFieldError(input, "Please complete all required fields.");
    }
  }
  return true;
}

function isValidEmail(value) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
}

function isValidPhone(value) {
  return /^(?=.*\d)[+]?[\d\s-]{7,20}$/.test(value);
}

function isValidUrl(value) {
  if (!value.trim()) {
    return true;
  }
  try {
    const url = new URL(value);
    return url.protocol === "http:" || url.protocol === "https:";
  } catch (error) {
    return false;
  }
}

function validateQuantity(form) {
  const quantity = form.querySelector('[name="quantity"]');
  if (!quantity || !Number.isInteger(Number(quantity.value)) || Number(quantity.value) < 1) {
    return showFieldError(quantity, "Quantity must be a whole number of at least 1.");
  }
  return true;
}

function validateLoginForm(form) {
  return requireFields(form, ["loginKey", "password"]);
}

function validateRegisterForm(form) {
  if (!requireFields(form, ["username", "email", "phone_number", "password"])) {
    return false;
  }

  const username = form.querySelector('[name="username"]');
  const email = form.querySelector('[name="email"]');
  const phone = form.querySelector('[name="phone_number"]');
  const password = form.querySelector('[name="password"]');

  if (username.value.trim().length < 3 || username.value.trim().length > 20) {
    return showFieldError(username, "Username must be 3-20 characters.");
  }
  if (!isValidEmail(email.value.trim())) {
    return showFieldError(email, "Please enter a valid email address.");
  }
  if (!isValidPhone(phone.value.trim())) {
    return showFieldError(phone, "Please enter a valid phone number.");
  }
  if (password.value.length < 6) {
    return showFieldError(password, "Password must be at least 6 characters.");
  }
  return true;
}

function validateCheckoutForm(form) {
  if (!requireFields(form, ["delivery_address", "contact_phone", "payment_method"])) {
    return false;
  }
  const phone = form.querySelector('[name="contact_phone"]');
  if (!isValidPhone(phone.value.trim())) {
    return showFieldError(phone, "Please enter a valid contact phone number.");
  }
  return true;
}

function validateContactForm(form) {
  const fields = ["name", "email", "message"];
  if (form.querySelector('[name="subject"]')) {
    fields.push("subject");
  }
  if (!requireFields(form, fields)) {
    return false;
  }
  const email = form.querySelector('[name="email"]');
  const phone = form.querySelector('[name="phone"]');
  if (!isValidEmail(email.value.trim())) {
    return showFieldError(email, "Please enter a valid email address.");
  }
  if (phone && phone.value.trim() && !isValidPhone(phone.value.trim())) {
    return showFieldError(phone, "Please enter a valid phone number.");
  }
  return true;
}

function validateCategoryForm(form) {
  return requireFields(form, ["categoryName", "description"]);
}

function validateFoodForm(form) {
  if (!requireFields(form, ["foodName", "categoryId", "price", "rating", "description", "ingredients", "nutrition"])) {
    return false;
  }

  const price = form.querySelector('[name="price"]');
  const rating = form.querySelector('[name="rating"]');
  const imageUrl = form.querySelector('[name="imageUrl"]');
  const foodImage = form.querySelector('[name="foodImage"]');

  if (Number(price.value) <= 0) {
    return showFieldError(price, "Price must be greater than 0.");
  }
  if (Number(rating.value) < 0 || Number(rating.value) > 5) {
    return showFieldError(rating, "Rating must be between 0 and 5.");
  }
  if (imageUrl && !isValidUrl(imageUrl.value.trim())) {
    return showFieldError(imageUrl, "Image URL must be a valid http or https URL.");
  }
  if (foodImage && foodImage.files.length > 0 && !foodImage.files[0].type.startsWith("image/")) {
    return showFieldError(foodImage, "Food image must be an image file.");
  }
  return true;
}

function fakeContactSubmit(event) {
  event.preventDefault();
  if (!validateContactForm(event.target)) {
    return false;
  }
  alert("Thank you for your message!");
  event.target.reset();
  return true;
}

document.addEventListener("DOMContentLoaded", () => {
  document.documentElement.classList.add("has-reveal");
  const revealItems = document.querySelectorAll(".reveal");
  if (!revealItems.length) {
    return;
  }

  if (!("IntersectionObserver" in window)) {
    revealItems.forEach((item) => item.classList.add("is-visible"));
    return;
  }

  const observer = new IntersectionObserver((entries) => {
    for (const entry of entries) {
      if (entry.isIntersecting) {
        entry.target.classList.add("is-visible");
        observer.unobserve(entry.target);
      }
    }
  }, { threshold: 0.12 });

  revealItems.forEach((item) => observer.observe(item));
});
