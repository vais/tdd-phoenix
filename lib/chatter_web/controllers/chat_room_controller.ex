defmodule ChatterWeb.ChatRoomController do
  use ChatterWeb, :controller

  import Phoenix.Component, only: [to_form: 1]

  alias Chatter.Chat

  def index(conn, _params) do
    rooms = Chat.all_rooms()
    render(conn, :index, chat_rooms: rooms)
  end

  def new(conn, _params) do
    changeset = Chat.new_chat_room()
    render(conn, :new, form: to_form(changeset))
  end

  def create(conn, %{"room" => room_params} = _params) do
    case Chat.create_chat_room(room_params) do
      {:ok, room} ->
        redirect(conn, to: ~p"/chat_rooms/#{room}")

      {:error, changeset} ->
        render(conn, :new, form: to_form(changeset))
    end
  end

  def show(conn, %{"id" => id} = _params) do
    room = Chat.find_room(id)
    render(conn, :show, room: room)
  end
end
