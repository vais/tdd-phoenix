# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Chatter.Repo.insert!(%Chatter.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

%Chatter.User{}
|> Ecto.Changeset.change(%{email: "test@example.com", password: "password"})
|> Doorman.Auth.Bcrypt.hash_password()
|> Doorman.Auth.Secret.put_session_secret()
|> Ecto.Changeset.apply_changes()
|> Chatter.Repo.insert!()
