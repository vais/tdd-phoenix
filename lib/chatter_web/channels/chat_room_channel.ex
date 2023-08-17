defmodule ChatterWeb.ChatRoomChannel do
  use ChatterWeb, :channel

  alias Chatter.Chat

  def join("chat_room:" <> name, _payload, socket) do
    room = Chat.find_room_by_name(name)
    socket = assign(socket, room: room)
    messages = Chat.room_messages(room)
    {:ok, %{messages: messages}, socket}
  end

  def handle_in("new_message" = message, payload, socket) do
    outbound_payload = Map.put(payload, "author", socket.assigns.email)
    send(self(), {:store_message, outbound_payload})
    broadcast(socket, message, outbound_payload)
    {:noreply, socket}
  end

  def handle_info({:store_message, payload}, socket) do
    Chat.new_message(socket.assigns.room, payload)
    {:noreply, socket}
  end
end
