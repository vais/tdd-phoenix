defmodule ChatterWeb.UsersCanChatTest do
  use ChatterWeb.FeatureCase, async: true

  test "users can chat to each other", %{metadata: metadata} do
    room = insert(:chat_room)

    user =
      new_user(metadata)
      |> visit(~p"/")
      |> join_room(room.name)

    another_user =
      new_user(metadata)
      |> visit(~p"/")
      |> join_room(room.name)

    user
    |> send_message("hello!")

    another_user
    |> assert_has(message("hello!"))
    |> send_message("oh hi! welcome to #{room.name}!")

    user
    |> assert_has(message("oh hi! welcome to #{room.name}!"))
  end

  defp message(text) do
    Query.data("role", "message", text: text)
  end

  defp new_user(metadata) do
    {:ok, user} = Wallaby.start_session(metadata: metadata)
    user
  end

  defp join_room(user, room_name) do
    user
    |> click(Query.link(room_name))
  end

  defp send_message(user, message_text) do
    user
    |> fill_in(Query.text_field("New Message"), with: message_text)
    |> click(Query.button("Send"))
  end
end
