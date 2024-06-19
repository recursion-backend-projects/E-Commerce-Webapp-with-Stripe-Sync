document.addEventListener("DOMContentLoaded", function () {
	console.log("js loading.");

	document.querySelectorAll(".add-to-cart-button").forEach(function (button) {
		button.addEventListener("click", function (event) {
			event.preventDefault();

			let productItem = button.closest(".product-item");
			let selectedQuantity = <HTMLInputElement>(
				productItem!.querySelector(".quantity")
			);
			let cartQuantity = <HTMLInputElement>(
				productItem!.querySelector(".cart-quantity")
			);
			let cartForm = <HTMLFormElement>(
				productItem!.querySelector(".cart-form")
			);

			cartQuantity.value = selectedQuantity.value;
			cartForm.submit();
		});
	});

	document.querySelectorAll(".checkout-button").forEach(function (button) {
		button.addEventListener("click", function (event) {
			event.preventDefault();

			let productItem = button.closest(".product-item");
			let selectedQuantity = <HTMLInputElement>(
				productItem!.querySelector(".quantity")
			);
			let checkoutQuantity = <HTMLInputElement>(
				productItem!.querySelector(".checkout-quantity")
			);
			let checkoutForm = <HTMLFormElement>(
				productItem!.querySelector(".checkout-form")
			);

			checkoutQuantity.value = selectedQuantity.value;
			checkoutForm.submit();
		});
	});
});
