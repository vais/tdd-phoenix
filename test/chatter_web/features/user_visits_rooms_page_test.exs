defmodule ChatterWeb.UserVisitsRoomsPageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user visits rooms page to see the list of rooms", %{session: session} do
    [room1, room2] = insert_pair(:chat_room)

    session
    |> visit(~p"/")
    |> assert_has(room_name(room1))
    |> assert_has(room_name(room2))
  end

  defp room_name(room) do
    Query.data("role", "room", text: room.name)
  end
end
