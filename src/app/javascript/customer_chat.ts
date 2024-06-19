document.addEventListener("DOMContentLoaded", async function () {
  async function getToken() {
    let res = await fetch("/chat/token");
    let data = await res.json();
    return data.token;
  }

  let token = await getToken();
  console.log(`token: ${token}`);

  const websocketUrl = document
    .getElementById("websocket-url")
    ?.getAttribute("data-websocket-url");

  const socket = new WebSocket(`${websocketUrl}?token=${token}`);

  socket.onopen = function (event) {
    console.log("Connected to WebSocket server.");
  };

  socket.onclose = function (event) {
    console.log("Disconnected from WebSocket server.");
  };

  socket.onmessage = function (event) {
    console.log(`server: ${event.data}`);
    displayMessage(event.data, "received");
  };

  document.getElementById("submit")!.addEventListener("click", function (e) {
    e.preventDefault();
    sendMessage();
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
