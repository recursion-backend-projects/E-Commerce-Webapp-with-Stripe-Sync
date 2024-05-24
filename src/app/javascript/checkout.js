const stripe = Stripe(
	"pk_test_51PBXzv2KrybDMqMJtQuWpFeIaQ8rlZekNQCYFZs7gThbcuFXRjebfC4cQVpgv3npIPNDFTYz0zEoYz1vjg1Mxe3M00eK64iAhv"
);

const options = {
	// Fully customizable with appearance API.
	appearance: {
		/* ... */
	},
};

// Only need to create this if no elements group exist yet.
// Create a new Elements instance if needed, passing the
// optional appearance object.
const elements = stripe.elements(options);

// Create and mount the Address Element in shipping mode
const addressElement = elements.create("address", {
	mode: "shipping",
});
addressElement.mount("#address-element");

addressElement.on("change", (event) => {
	if (event.complete) {
		// Extract potentially complete address
		const address = event.value.address;
	}
});