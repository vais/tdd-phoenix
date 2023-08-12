defmodule ChatterWeb.Plugs.PutUserEmail do
  def init(opts), do: opts

  def call(%{assigns: %{current_user: current_user}} = conn, _opts) do
    Plug.Conn.assign(conn, :email, current_user.email)
  end

  def call(conn, _opts), do: conn
end
