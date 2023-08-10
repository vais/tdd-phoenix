defmodule ChatterWeb.ChatRoomHTML do
  use ChatterWeb, :html

  def index(assigns) do
    ~H"""
    <h1 class="title">
      Welcome to Chatter!
    </h1>

    <.link href={~p"/chat_rooms/new"}>New chat room</.link>

    <ul>
      <li :for={room <- @chat_rooms} data-role="room">
        <.link href={~p"/chat_rooms/#{room}"}><%= room.name %></.link>
      </li>
    </ul>
    """
  end

  def new(assigns) do
    ~H"""
    <.simple_form for={@form} action={~p"/chat_rooms"}>
      <.input field={@form[:name]} label="Name" />
      <:actions>
        <.button>Save</.button>
      </:actions>
    </.simple_form>
    """
  end

  def show(assigns) do
    ~H"""
    <h1 id="chat-room-title" data-role="room-title" data-chat-room-name={@room.name}>
      <%= @room.name %>
    </h1>

    <ul id="messages"></ul>

    <form>
      <label>
        New Message <input type="text" id="message" name="message" autocomplete="off" autofocus />
      </label>
      <button type="submit">Send</button>
    </form>
    """
  end
end
