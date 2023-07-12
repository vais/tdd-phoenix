defmodule ChatterWeb.ChatRoomChannel do
  use ChatterWeb, :channel

  def join("chat_room:" <> _name, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_message" = message, payload, socket) do
    broadcast(socket, message, payload)
    {:noreply, socket}
  end
end
