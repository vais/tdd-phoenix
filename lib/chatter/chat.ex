defmodule Chatter.Chat do
  alias Chatter.{Repo, Chat.Room}

  def all_rooms() do
    Repo.all(Room)
  end

  def new_chat_room() do
    Room.changeset(%Room{}, %{})
  end

  def create_chat_room(params) do
    %Room{}
    |> Room.changeset(params)
    |> Repo.insert()
  end

  def find_room(id) do
    Repo.get!(Room, id)
  end
end
