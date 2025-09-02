const pay = () => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');

  form.addEventListener('submit', (e) => {
    e.preventDefault(); // 通常送信を防ぐ

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        // token は作らず、そのまま送信 → Rails 側でバリデーション
        console.log('カード情報にエラーがあります:', response.error.message);
      } else {
        // トークン生成成功時のみ hidden input を追加
        const token = response.id;
        form.insertAdjacentHTML(
          'beforeend',
          `<input type="hidden" name="token" value="${token}">`
        );
      }

      // token があってもなくても送信 → Rails 側でエラー表示可能
      form.submit();
    });
  });
};

// Turbo 対応：ページ読み込み時および再描画時に呼び出す
window.addEventListener('turbo:load', pay);
window.addEventListener('turbo:render', pay);