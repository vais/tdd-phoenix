defmodule Chatter.Accounts do
  alias Chatter.{User, Repo}

  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Doorman.Auth.Secret.put_session_secret()
    |> Repo.insert()
  end

  def change_user(user) do
    user
    |> User.changeset(%{})
  end
end
