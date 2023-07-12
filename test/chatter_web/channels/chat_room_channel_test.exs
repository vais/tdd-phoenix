defmodule ChatterWeb.ChatRoomChannelTest do
  use ChatterWeb.ChannelCase, async: true

  setup do
    {:ok, _, socket} =
      ChatterWeb.UserSocket
      |> socket("", %{})
      |> subscribe_and_join(ChatterWeb.ChatRoomChannel, "chat_room:twitz")

    %{socket: socket}
  end

  describe "new_message event" do
    test "broadcasts message to all users", %{socket: socket} do
      push(socket, "new_message", "hi")
      assert_broadcast("new_message", "hi")
    end
  end
end
