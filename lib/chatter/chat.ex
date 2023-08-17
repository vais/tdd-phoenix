defmodule Chatter.Chat do
  alias Chatter.{Repo, Chat.Room}

  import Ecto.Query

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

  def find_room_by_name(name) do
    Repo.get_by!(Room, name: name)
  end

  def new_message(room, params) do
    room
    |> Ecto.build_assoc(:messages)
    |> Room.Message.changeset(params)
    |> Repo.insert()
  end

  def room_messages(room) do
    Room.Message
    |> where([m], m.chat_room_id == ^room.id)
    |> Repo.all()
  end
end
