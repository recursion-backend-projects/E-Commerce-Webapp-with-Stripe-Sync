document.addEventListener("DOMContentLoaded", function () {
  const productTypeSelect = document.getElementById(
    "product_product_type"
  ) as HTMLSelectElement;
  const digitalFileField = document.getElementById(
    "digital_file_field"
  ) as HTMLElement;

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
