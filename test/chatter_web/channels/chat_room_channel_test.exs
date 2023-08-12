defmodule ChatterWeb.ChatRoomChannelTest do
  use ChatterWeb.ChannelCase, async: true

  @email "someone@example.com"

  setup do
    {:ok, _, socket} =
      ChatterWeb.UserSocket
      |> socket("", %{email: @email})
      |> subscribe_and_join(ChatterWeb.ChatRoomChannel, "chat_room:twitz")

    %{socket: socket}
  end

  describe "new_message event" do
    test "broadcasts message to all users", %{socket: socket} do
      push(socket, "new_message", %{"body" => "hello"})
      assert_broadcast("new_message", %{"body" => "hello", "author" => @email})
    end
  end
end
