defmodule ChatterWeb.ChatRoomController do
  use ChatterWeb, :controller

  def index(conn, _params) do
    rooms = Chatter.Chat.all_rooms()

    assign(conn, :chat_rooms, rooms)
    |> render(:index, layout: false)
  end
end
