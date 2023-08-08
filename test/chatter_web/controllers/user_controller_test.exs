defmodule ChatterWeb.UserControllerTest do
  use ChatterWeb.ConnCase, async: true

  describe "create/2" do
    test "renders form with errors when data is invalid", %{conn: conn} do
      same_email = "someone@example.com"

      insert(:user, email: same_email)
      params = string_params_for(:user, email: same_email)

      response =
        conn
        |> post(~p"/users", %{"user" => params})
        |> html_response(200)

      assert response =~ "has already been taken"
    end
  end
end
