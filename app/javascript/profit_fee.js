const priceCalc = () => {
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  if (!priceInput) return;

  priceInput.addEventListener('input', () => {
    const price = parseInt(priceInput.value, 10);

    if (isNaN(price) || price < 300 || price > 9999999) {
      addTaxPrice.textContent = '';
      profit.textContent = '';
      return;
    }

    const fee = Math.floor(price * 0.1);
    const gain = price - fee;

    addTaxPrice.textContent = fee.toLocaleString();
    profit.textContent = gain.toLocaleString();
  });
};

document.addEventListener('turbo:load', priceCalc);
document.addEventListener('turbo:render', priceCalc);

