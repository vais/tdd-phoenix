defmodule ChatterWeb.ChatRoomController do
  use ChatterWeb, :controller

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end
end
