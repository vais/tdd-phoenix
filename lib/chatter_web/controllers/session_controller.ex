defmodule ChatterWeb.SessionController do
  use ChatterWeb, :controller

  def new(conn, _params) do
    changeset = Chatter.User.changeset(%Chatter.User{}, %{})
    form = Phoenix.Component.to_form(changeset)
    render(conn, :new, form: form)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}} = params) do
    case Doorman.authenticate(email, password) do
      nil ->
        changeset = Chatter.User.changeset(%Chatter.User{}, params["user"])
        form = Phoenix.Component.to_form(changeset)

        conn
        |> put_flash(:error, "Invalid email or password")
        |> render(:new, form: form)

      user ->
        conn
        |> Doorman.Login.Session.login(user)
        |> redirect(to: ~p"/")
    end
  end
end
