defmodule ChatterWeb.GuestSignsUpTest do
  use ChatterWeb.FeatureCase, async: true

  test "guest signs up with email and password", %{session: session} do
    room = insert(:chat_room)
    user = params_for(:user)

    session
    |> visit(~p"/")
    |> click(Query.link("Create an account"))
    |> fill_in(Query.text_field("Email"), with: user.email)
    |> fill_in(Query.text_field("Password"), with: user.password)
    |> click(Query.button("Sign up"))
    |> assert_has(room_name(room))
  end

  defp room_name(room) do
    Query.data("role", "room", text: room.name)
  end
end
