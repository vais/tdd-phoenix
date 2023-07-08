defmodule ChatterWeb.UserCreatesNewChatRoomTest do
  use ChatterWeb.FeatureCase, async: true

  test "user creates new chat room", %{session: session} do
    session
    |> visit(~p"/")
    |> click(new_room_link())
    |> create_chat_room(name: "hello")
    |> assert_has(room_title("hello"))
  end

  defp room_title(text), do: Query.data("role", "room-title", text: text)

  defp create_chat_room(session, name: name) do
    session
    |> fill_in(Query.text_field("Name"), with: name)
    |> click(Query.button("Save"))
  end

  defp new_room_link(), do: Query.link("New chat room")
end
