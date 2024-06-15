document.addEventListener("DOMContentLoaded", async function () {
	async function getToken() {
		let res = await fetch("/admin/token/chats");
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
		chatInput.value = "";
	}
});
