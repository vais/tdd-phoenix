defmodule ChatterWeb.UserHTML do
  use ChatterWeb, :html

  def new(assigns) do
    ~H"""
    <.simple_form for={@form} action={~p"/users"}>
      <.input field={@form[:email]} label="Email" />
      <.input field={@form[:password]} label="Password" />
      <:actions>
        <.button>Sign up</.button>
      </:actions>
    </.simple_form>
    """
  end
end
