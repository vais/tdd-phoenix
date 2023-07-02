defmodule Chatter.Chat do
  alias Chatter.{Repo, Chat}

  def all_rooms do
    Chat.Room
    |> Repo.all()
  end
end
