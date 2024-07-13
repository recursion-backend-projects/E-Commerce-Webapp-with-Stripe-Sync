document.addEventListener("DOMContentLoaded", async function () {
  async function getToken(): Promise<string> {
    let res = await fetch("/chat/token");
    let data = await res.json();
    return data.token;
  }

  async function updateChatStatus(status: string): Promise<void> {
    let response = await fetch(`/chat/update_status`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      },
      body: JSON.stringify({ status: status })
    });

    let data = await response.json();
    if (data.status === 'ok') {
      console.log('Chat status updated successfully');
    } else {
      alert('予期せぬエラーが発生しました。再接続をしてください。');
      return;
    }
  }

  let token = await getToken();

  const websocketUrl = document
    .getElementById("websocket-url")
    ?.getAttribute("data-websocket-url");

  if (!websocketUrl) {
    throw new Error("WebSocket URL is not defined");
  }

  const socket = new WebSocket(`${websocketUrl}?token=${token}`);

  socket.onopen = function (event) {
    console.log("Connected to WebSocket server.");
    initNotification();
  };

  socket.onclose = function (event) {
    console.log("Disconnected from WebSocket server.");
    alert("通信が切断されました。");

    // 接続解除後に送信ボタンとエンターキー送信を無効にする
    const submitButton = document.getElementById("submit") as HTMLButtonElement;
    if (submitButton) {
      submitButton.disabled = true;
    }
    const chatInput = document.getElementById("chat") as HTMLInputElement;
    if (chatInput) {
      chatInput.removeEventListener("keydown", handleEnterKey);
    }
  };

  socket.onmessage = function (event) {
    console.log(`server: ${event.data}`);
    displayMessage(event.data, "received");
  };

  window.addEventListener("beforeunload", async function (event) {
    await updateChatStatus('offline');
    socket.close();
  });

  const submitButton = document.getElementById("submit") as HTMLButtonElement;
  submitButton.addEventListener("click", function (e) {
    e.preventDefault();
    sendMessage();
  });

  const disconnectButton = document.getElementById("disconnect") as HTMLButtonElement;
  disconnectButton.addEventListener("click", async function (e) {
    e.preventDefault();
    const confirmDisconnect = confirm("本当に接続を解除しますか？");
    if (!confirmDisconnect) {
      return;
    }

    await updateChatStatus('offline');
    socket.close();
  });

  const chatInput = document.getElementById("chat") as HTMLTextAreaElement;
  chatInput?.focus();

  function handleEnterKey(e: KeyboardEvent) {
    if (e.key === "Enter" && e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  }

  function initNotification() {
    const notificationMessage = `カスタマーサポートの担当者が対応します。しばらくお待ちください。<br>
      ※カスタマーサポートから次のメッセージが表示されるまでは、メッセージを送信してもカスタマーサポートには、表示されませんのでご注意ください。
    `;
    displayMessage(notificationMessage, "received");
  }

  chatInput?.addEventListener("keydown", handleEnterKey);

  function sendMessage() {
    const message = chatInput?.value.trim();
    if (!message) {
      return;
    }
    socket.send(message);
    console.log(`me: ${message}`);
    displayMessage(message, "sent");
    chatInput.value = "";
  }

  function displayMessage(message: string, type: string) {
    const chatContainer = document.querySelector(".min-h-screen.space-y-4.p-4");

    const messageElement = document.createElement("div");
    messageElement.className =
      type === "sent"
        ? "flex flex-row-reverse items-start gap-2.5"
        : "flex items-start gap-2.5";
    messageElement.innerHTML = `
      <div class="flex w-full max-w-[320px] flex-col gap-1">
        <div class="${
          type === "sent"
            ? "leading-1.5 flex flex-col rounded-s-xl rounded-se-xl bg-sky-400 p-4"
            : "leading-1.5 flex flex-col rounded-e-xl rounded-ss-xl border-gray-200 bg-gray-200 p-4"
        }">
          <p class="text-sm font-normal ${
            type === "sent" ? "text-white" : "text-gray-900"
          }">
            ${message.replace(/\n/g, "<br>")}
          </p>
        </div>
        <span class="text-sm font-normal text-gray-400">${new Date().toLocaleTimeString()}</span>
      </div>
    `;
    chatContainer?.appendChild(messageElement);
    chatContainer?.scrollTo(0, chatContainer.scrollHeight);
  }
});
