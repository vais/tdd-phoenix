import socket from './socket';

const chatRoomTitle = document.getElementById('chat-room-title');

const addMessage = (message, container) => {
  const li = document.createElement('li');
  li.dataset.role = 'message';
  li.innerText = `${message.author}: ${message.body}`;
  container.appendChild(li);
};

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

  channel.on('new_message', message => {
    addMessage(message, messagesContainer);
  });

  channel
    .join()
    .receive("ok", res => {
      res.messages.forEach(message => {
        addMessage(message, messagesContainer);
      });
    });
}

