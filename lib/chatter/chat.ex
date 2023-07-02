defmodule Chatter.Chat do
  alias Chatter.{Repo, Chat}

  def all_rooms do
    Repo.all(Chat.Room)
  end
end
