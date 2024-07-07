document.addEventListener("DOMContentLoaded", async function () {
  async function getToken() {
    let res = await fetch("/admin/token/chats");
    let data = await res.json();
    return data.token;
  }

  async function updateChatStatus(chatId: string, status: string) {
    let response = await fetch(`/admin/chats/${chatId}/update_status`, {
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

  const socket = new WebSocket(`${websocketUrl}?token=${token}`);

  socket.onopen =  async function (event) {
    console.log("Connected to WebSocket server.");

    const chatIdElement = document.getElementById("chat-id");
    const chatId = chatIdElement?.getAttribute("data-chat-id");
    if (chatId) {
      await updateChatStatus(chatId, 'chatting');
    }

    // 初回メッセージを送信
    const initialMessage = `お客様への対応をスムーズに進めるために、以下の情報をお教えいただけますか？<br /><br />
    1. ご注文番号<br />
    2. ご注文日時<br />
    3. 商品名<br />
    4. その他お問い合わせ内容`;
    socket.send(initialMessage);
    displayMessage(initialMessage, "sent");
  };

  socket.onclose = function (event) {
    console.log("Disconnected from WebSocket server.");
    alert("通信が切断されました。")
  };

  socket.onmessage = function (event) {
    console.log(`server: ${event.data}`);
    displayMessage(event.data, "received");
  };

  window.addEventListener("beforeunload", async function (event) {
    const chatIdElement = document.getElementById("chat-id");
    const chatId = chatIdElement?.getAttribute("data-chat-id");
    if (chatId) {
      await updateChatStatus(chatId, 'offline');
    }
    socket.close();
  });

  document.getElementById("submit")!.addEventListener("click", function (e) {
    e.preventDefault();
    sendMessage();
  });

  document.getElementById("disconnect")!.addEventListener("click", async function (e) {
    e.preventDefault();
    const chatIdElement = document.getElementById("chat-id");
    const chatId = chatIdElement?.getAttribute("data-chat-id");
    if (chatId) {
      await updateChatStatus(chatId, 'offline');
    }
    socket.close();
  });

  const chatInput = document.getElementById("chat") as HTMLInputElement;
  chatInput?.focus();

  chatInput?.addEventListener("keydown", function (e) {
    if (e.key === "Enter" && e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  });

  function sendMessage() {
    const message = chatInput?.value;
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
