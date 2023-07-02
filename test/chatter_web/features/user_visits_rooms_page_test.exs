defmodule ChatterWeb.UserVisitsRoomsPageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user visits rooms page to see the list of rooms", %{session: session} do
    room = insert(:chat_room)

    session
    |> visit(~p"/")
    |> assert_has(Query.css(".room", text: room.name))
  end
end
