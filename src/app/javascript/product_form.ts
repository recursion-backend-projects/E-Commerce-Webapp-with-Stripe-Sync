import Tagify from "@yaireo/tagify";

document.addEventListener("DOMContentLoaded", function () {
	const productTypeSelect = document.getElementById(
		"product_product_type"
	) as HTMLSelectElement;
	const digitalFileField = document.getElementById(
		"digital_file_field"
	) as HTMLElement;

	const tagInput = document.getElementById(
		"product_tag_list"
	) as HTMLInputElement;

	const tagify = new Tagify(tagInput, {
		originalInputValueFormat: (valuesArr: { value: string }[]) =>
			valuesArr.map((item: { value: string }) => item.value).join(","),
		whitelist: [],
	});

	let controller: AbortController | undefined;

	tagify.on("input", onTagInput);

	function onTagInput(e: CustomEvent): void {
		let value = e.detail.value;
		tagify.whitelist = null;

		// 以前のリクエストを中止
		if (controller) {
			controller.abort();
		}

		// 新しいAbortControllerを作成
		controller = new AbortController();

		tagify.loading(true);

		fetch(`/admin/products/tags/whitelist?name=${value}`, {
			signal: controller.signal,
		})
			.then((response) => response.json())
			.then((newWhitelist: string[]) => {
				// ホワイトリストを更新
				tagify.whitelist = newWhitelist;

				// ローディングアニメーションを非表示にしてドロップダウンを表示
				tagify.loading(false).dropdown.show(value);
			})
			.catch((error) => {
				console.error("エラーが発生しました", error);
			});
	}

	function toggleDigitalFileField() {
		if (productTypeSelect.value === "digital") {
			// 'digital'を正しい値に置き換える必要があります
			digitalFileField.style.display = "block";
		} else {
			digitalFileField.style.display = "none";
		}
	}

	productTypeSelect.addEventListener("change", toggleDigitalFileField);

	// 初期状態の設定
	toggleDigitalFileField();
});
