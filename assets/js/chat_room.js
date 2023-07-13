import socket from './socket';

const chatRoomTitle = document.getElementById('chat-room-title');

if (chatRoomTitle) {
  const chatRoomName = chatRoomTitle.dataset.chatRoomName;
  const channel = socket.channel(`chat_room:${chatRoomName}`, {});

  const messageForm = document.querySelector('form');
  const messageInput = messageForm.querySelector('input[name="message"]');
  const messagesContainer = document.getElementById('messages');

  messageForm.addEventListener('submit', (e) => {
    e.preventDefault();
    channel.push('new_message', {body: messageInput.value});
    messageForm.reset();
  });

  channel.on('new_message', payload => {
    const li = document.createElement('li');
    li.dataset.role = 'message';
    li.innerText = payload.body;
    messagesContainer.appendChild(li);
  });

  channel.join();
}

