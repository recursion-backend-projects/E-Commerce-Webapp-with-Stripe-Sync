const stripe = Stripe(
	"pk_test_51PBXzv2KrybDMqMJtQuWpFeIaQ8rlZekNQCYFZs7gThbcuFXRjebfC4cQVpgv3npIPNDFTYz0zEoYz1vjg1Mxe3M00eK64iAhv"
);
// Retrieve the "payment_intent_client_secret" query parameter appended to
// your return_url by Stripe.js
const clientSecret = new URLSearchParams(window.location.search).get(
	"payment_intent_client_secret"
);

// Retrieve the PaymentIntent
stripe.retrievePaymentIntent(clientSecret).then(({ paymentIntent }) => {
	const message = document.querySelector("#message");

	// Inspect the PaymentIntent `status` to indicate the status of the payment
	// to your customer.
	//
	// Some payment methods will [immediately succeed or fail][0] upon
	// confirmation, while others will first enter a `processing` state.
	//
	// [0]: https://stripe.com/docs/payments/payment-methods#payment-notification
	switch (paymentIntent.status) {
		case "succeeded":
			message.innerText = "支払いが完了しました";
			break;

		case "processing":
			message.innerText =
				"支払い処理中です。支払いが確認でき次第、更新いたします";
			break;

		case "requires_payment_method":
			message.innerText = "支払いに失敗しました。別の支払い方法をお試しください";
			window.location.href = "http://localhost:3000/checkout";
			// Redirect your user back to your payment page to attempt collecting
			// payment again
			break;

		default:
			message.innerText = "問題が発生しました";
			break;
	}
});
