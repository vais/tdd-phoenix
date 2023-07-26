defmodule ChatterWeb.ConnHelpers do
  def sign_in(conn) do
    user = Chatter.Factory.insert(:user)

    conn
    |> Plug.Test.init_test_session(%{})
    |> Doorman.Login.Session.login(user)
  end
end
