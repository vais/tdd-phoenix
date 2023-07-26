defmodule ChatterWeb.SessionControllerTest do
  use ChatterWeb.ConnCase, async: true

  describe "create/2" do
    test "shows an error when credentials are invalid", %{conn: conn} do
      response =
        conn
        |> post(~p"/sessions", %{"user" => string_params_for(:user, email: "", password: "")})
        |> html_response(200)

      assert response =~ "Invalid email or password"
    end
  end
end
