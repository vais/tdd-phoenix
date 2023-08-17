defmodule ChatterWeb.ChatRoomChannelTest do
  use ChatterWeb.ChannelCase, async: true

  @email "someone@example.com"

  setup do
    room = insert(:chat_room)

    {:ok, _, socket} =
      ChatterWeb.UserSocket
      |> socket("", %{email: @email})
      |> subscribe_and_join(ChatterWeb.ChatRoomChannel, "chat_room:#{room.name}")

    %{socket: socket}
  end

  describe "new_message event" do
    test "broadcasts message to all users", %{socket: socket} do
      push(socket, "new_message", %{"body" => "hello"})
      assert_broadcast("new_message", %{"body" => "hello", "author" => @email})
    end
  end

  describe "join/3" do
    test "replies with a list of existing messages", %{socket: socket} do
      room = insert(:chat_room)
      insert_pair(:chat_room_message, chat_room: room)

      {:ok, reply, _socket} = join(socket, "chat_room:#{room.name}")

      assert [message1, _message2] = reply.messages
      assert message1.author
      assert message1.body
    end
  end
end
