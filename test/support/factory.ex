defmodule Chatter.Factory do
  use ExMachina.Ecto, repo: Chatter.Repo

  def chat_room_factory do
    %Chatter.Chat.Room{
      name: sequence(:name, &"chat room #{&1}")
    }
  end

  def user_factory do
    %Chatter.User{email: sequence(:email, &"user#{&1}@example.com")}
    |> Ecto.Changeset.change(password: "superpass")
    |> Doorman.Auth.Bcrypt.hash_password()
    |> Doorman.Auth.Secret.put_session_secret()
    |> Ecto.Changeset.apply_changes()
  end
end
