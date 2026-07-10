function requireFields(form, fields) {
  for (const field of fields) {
    const input = form.querySelector(`[name="${field}"]`);
    if (!input || !input.value.trim()) {
      alert("Please complete all required fields.");
      if (input) input.focus();
      return false;
    }
  }
  return true;
}

function validateQuantity(form) {
  const quantity = form.querySelector('[name="quantity"]');
  if (!quantity || Number(quantity.value) < 1) {
    alert("Quantity must be at least 1.");
    if (quantity) quantity.focus();
    return false;
  }
  return true;
}

function fakeContactSubmit(event) {
  event.preventDefault();
  alert("Thank you for your message!");
  event.target.reset();
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
