{
  // clipboard.ts
  const shareLink = document.getElementById("share-link") as HTMLAnchorElement;

  if (shareLink) {
    shareLink.addEventListener("click", (event: MouseEvent) => {
      event.preventDefault();
      const url = shareLink.getAttribute("data-url");

      if (url) {
        navigator.clipboard
          .writeText(url)
          .then(() => {
            showToast("リンクがクリップボードにコピーされました: " + url);
          })
          .catch((err) => {
            console.error("リンクのコピーに失敗しました: ", err);
          });
      }
    });
  }

  function showToast(message: string) {
    const toastContainer = document.getElementById("toast-container");
    if (toastContainer) {
      const toast = document.createElement("div");
      toast.className =
        "toast bg-green-500 text-white p-4 rounded-lg shadow-md transition-opacity duration-300 ease-in-out";
      toast.innerText = message;

      toastContainer.appendChild(toast);

      setTimeout(() => {
        toast.classList.add("opacity-100");
      }, 100);

      setTimeout(() => {
        toast.classList.remove("opacity-100");
        setTimeout(() => {
          toast.remove();
        }, 300);
      }, 3000);
    }
  }
}
