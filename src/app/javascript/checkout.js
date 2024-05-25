const stripe = Stripe(
	"pk_test_51PBXzv2KrybDMqMJtQuWpFeIaQ8rlZekNQCYFZs7gThbcuFXRjebfC4cQVpgv3npIPNDFTYz0zEoYz1vjg1Mxe3M00eK64iAhv"
);

const paymentForm = document.getElementById("payment-form");

const options = {
	clientSecret: paymentForm.dataset.secret,
	// Fully customizable with appearance API.
	appearance: {
		/* ... */
	},
};

const elements = stripe.elements(options);

// Create an instance of the Link Authentication Element.
const linkAuthenticationElement = elements.create("linkAuthentication");

// Mount the Elements to their corresponding DOM node
linkAuthenticationElement.mount("#link-authentication-element");

let email;

linkAuthenticationElement.on("change", (event) => {
	email = event.value.email;
});


// Create and mount the Payment Element
const paymentElement = elements.create("payment", {
	fields: {
		billingDetails: {
			email: 'never',
			address: "never"
		}
	},
});
paymentElement.mount("#payment-element");

// Create and mount the Address Element in shipping mode
const addressElement = elements.create("address", {
	mode: "shipping",
	allowedCountries: ["JP"],
});
addressElement.mount("#address-element");

let address;
addressElement.on("change", (event) => {
	if (event.complete) {
		// Extract potentially complete address
		address = event.value.address;
	}
});

paymentForm.addEventListener("submit", async (event) => {
	event.preventDefault();
	setLoading(true);

	const { error } = await stripe.confirmPayment({
		//`Elements` instance that was used to create the Payment Element
		elements,
		confirmParams: {
			return_url: "http://localhost:3000/checkout/success",
			payment_method_data: {
				billing_details: {
					address: address,
					email: email,
				},
			},
		},
	});

	if (error) {
		// This point will only be reached if there is an immediate error when
		// confirming the payment. Show error to your customer (for example, payment
		// details incomplete)
		const messageContainer = document.querySelector("#error-message");
		messageContainer.textContent = error.message;
	}

	setLoading(false);
});

const submitBtn = document.getElementById("submit");
const spinner = document.getElementById("spinner");

// Show a spinner on payment submission
function setLoading(isLoading) {
	if (isLoading) {
		// Disable the button and show a spinner
		submitBtn.disabled = true;
		spinner.classList.remove("hidden");
		spinner.classList.add("flex");
	} else {
		submitBtn.disabled = false;
		spinner.classList.add("hidden");
		spinner.classList.remove("flex");
	}
}
