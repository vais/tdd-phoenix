defmodule ChatterWeb.UsersCanChatTest do
  use ChatterWeb.FeatureCase, async: true

  test "users can chat to each other", %{metadata: metadata} do
    user = insert(:user)
    another_user = insert(:user)
    room = insert(:chat_room)

    session =
      new_session(metadata)
      |> visit(~p"/")
      |> sign_in(as: user)
      |> join_room(room.name)

    another_session =
      new_session(metadata)
      |> visit(~p"/")
      |> sign_in(as: another_user)
      |> join_room(room.name)

    session
    |> send_message("hello!")

    another_session
    |> assert_has(message("hello!"))
    |> send_message("oh hi! welcome to #{room.name}!")

    session
    |> assert_has(message("oh hi! welcome to #{room.name}!"))
  end

  defp message(text) do
    Query.data("role", "message", text: text)
  end

  defp new_session(metadata) do
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    session
  end

  defp join_room(session, room_name) do
    session
    |> click(Query.link(room_name))
  end

  defp send_message(session, message_text) do
    session
    |> fill_in(Query.text_field("New Message"), with: message_text)
    |> click(Query.button("Send"))
  end
end
