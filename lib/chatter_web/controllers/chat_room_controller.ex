defmodule ChatterWeb.ChatRoomController do
  use ChatterWeb, :controller

  def index(conn, _params) do
    render(
      conn,
      :index,
      layout: false,
      chat_rooms: Chatter.Chat.all_rooms()
    )
  end
end
