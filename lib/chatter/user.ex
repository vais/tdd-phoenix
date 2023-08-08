defmodule Chatter.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :session_secret, :string

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint([:email])
    |> Doorman.Auth.Bcrypt.hash_password()
  end
end
