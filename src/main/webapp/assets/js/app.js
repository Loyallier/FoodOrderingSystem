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
