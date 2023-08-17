defmodule Chatter.Chat.Room do
  use Ecto.Schema

  import Ecto.Changeset

  schema "chat_rooms" do
    field :name, :string
    has_many :messages, Chatter.Chat.Room.Message, foreign_key: :chat_room_id

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint([:name])
  end
end
