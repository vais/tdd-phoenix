defmodule ChatterWeb.ChatRoomControllerTest do
  use ChatterWeb.ConnCase, async: true

  import Plug.HTML, only: [html_escape: 1]

  describe "create/2" do
    test "renders new page with errors when data is invalid", %{conn: conn} do
      params = string_params_for(:chat_room, name: "")

      response =
        conn
        |> sign_in
        |> post(~p"/chat_rooms", %{"room" => params})
        |> html_response(200)

      assert response =~ html_escape("can't be blank")
    end
  end
end
