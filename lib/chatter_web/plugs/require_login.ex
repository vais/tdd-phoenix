defmodule ChatterWeb.Plugs.RequireLogin do
  use ChatterWeb, :verified_routes

  def init(opts), do: opts

  def call(conn, _opts) do
    if Doorman.logged_in?(conn) do
      conn
    else
      conn
      |> Phoenix.Controller.redirect(to: ~p"/sign_in")
      |> Plug.Conn.halt()
    end
  end
end
