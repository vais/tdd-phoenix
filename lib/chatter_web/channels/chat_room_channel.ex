defmodule ChatterWeb.ChatRoomChannel do
  use ChatterWeb, :channel

  def join("chat_room:" <> _name, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_message" = message, payload, socket) do
    payload = Map.put(payload, "author", socket.assigns.email)
    broadcast(socket, message, payload)
    {:noreply, socket}
  end
end
