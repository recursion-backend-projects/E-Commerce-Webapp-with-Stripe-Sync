import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // ブロードキャストされたデータをキャッチ
    console.log(data.chat)
    if (data.action === 'create') {
      addChat(data.chat, data.customer_account);
    } else if (data.action === 'update_status') {
      updateChatStatus(data.chat);
    }
  }
});

function addChat(chat, customerAccount) {
  const chatList = document.querySelector('tbody');
  const chatRow = document.createElement('tr');
  chatRow.className = 'bg-gre border-b bg-white hover:bg-gray-100 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:border-gray-700 dark:bg-gray-800';
  chatRow.id = `chat-${chat.id}`;
  chatRow.innerHTML = `
    <td class="px-6 py-4 font-semibold dark:text-white">${customerAccount.email}</td>
    <td class="px-6 py-4 dark:text-white">${new Date(chat.created_at).toLocaleString()}</td>
    <td id="status-cell" class="px-6 py-4 dark:text-white">
      <div class="flex items-center">
        ${chat.status === 'waiting_for_admin' ? `
          <div class="flex items-center dark:text-white">
            <div class="me-2 h-2.5 w-2.5 rounded-full bg-yellow-500"></div>
            未対応
          </div>
        ` : `
          <div class="flex items-center dark:text-white">
            <div class="me-2 h-2.5 w-2.5 rounded-full bg-green-500"></div>
            対応中
          </div>
        `}
      </div>
    </td>
    <td id="action-cell" class="space-x-2 px-2 py-4 md:space-x-10 md:px-6">
      ${chat.status !== 'chatting' ? `
        <a href="/admin/chats/${chat.id}" data-turbo="false" class="font-medium text-sky-600 hover:underline">接続する</a>
      ` : ''}
    </td>
  `;
  chatList.appendChild(chatRow);
}

function updateChatStatus(chat) {
  const chatRow = document.querySelector(`#chat-${chat.id}`);
  if (chatRow) {
    if (chat.status === 'offline') {
      chatRow.remove();
    } else {
      const statusCell = chatRow.querySelector('#status-cell');
      if (statusCell) {
        statusCell.innerHTML = `
          <div class="flex items-center">
            ${chat.status === 'waiting_for_admin' ? `
              <div class="flex items-center dark:text-white">
                <div class="me-2 h-2.5 w-2.5 rounded-full bg-yellow-500"></div>
                未対応
              </div>
            ` : `
              <div class="flex items-center dark:text-white">
                <div class="me-2 h-2.5 w-2.5 rounded-full bg-green-500"></div>
                対応中
              </div>
            `}
          </div>
        `;
      }

      const actionCell = chatRow.querySelector('#action-cell');
      if (actionCell) {
        actionCell.innerHTML = chat.status !== 'chatting' ? `
          <a href="/admin/chats/${chat.id}" data-turbo="false" class="font-medium text-sky-600 hover:underline">接続する</a>
        ` : '';
      }
    }
  }
}
