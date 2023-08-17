defmodule Chatter.Chat.Room.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:author, :body, :chat_room_id]}

  schema "chat_room_messages" do
    field :body, :string
    field :author, :string
    belongs_to :chat_room, Chatter.Chat.Room

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :author, :chat_room_id])
    |> validate_required([:body, :author, :chat_room_id])
  end
end
