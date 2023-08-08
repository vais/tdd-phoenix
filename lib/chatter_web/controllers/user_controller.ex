defmodule ChatterWeb.UserController do
  use ChatterWeb, :controller
  import Phoenix.Component, only: [to_form: 1]
  alias Chatter.{Accounts, User}

  def new(conn, _params) do
    form =
      %User{}
      |> Accounts.change_user()
      |> to_form()

    render(conn, :new, form: form)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> Doorman.Login.Session.login(user)
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        conn
        |> render(:new, form: to_form(changeset))
    end
  end
end
