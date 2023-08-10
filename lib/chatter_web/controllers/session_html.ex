defmodule ChatterWeb.SessionHTML do
  use ChatterWeb, :html

  def new(assigns) do
    ~H"""
    <.link href={~p"/users/new"}>Create an account</.link>

    <.simple_form for={@form} action={~p"/sessions"}>
      <.input field={@form[:email]} label="Email" />
      <.input field={@form[:password]} label="Password" />
      <:actions>
        <.button>Sign in</.button>
      </:actions>
    </.simple_form>
    """
  end
end
