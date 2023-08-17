defmodule Chatter.Chat.Room.MessageTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat.Room.Message

  describe "changeset/2" do
    test "validates that message body is provided" do
      changeset = Message.changeset(%Message{}, %{})
      assert "can't be blank" in errors_on(changeset).body
    end

    test "validates that message author is provided" do
      changeset = Message.changeset(%Message{}, %{})
      assert "can't be blank" in errors_on(changeset).author
    end

    test "validates that message is associated with a chat room" do
      changeset = Message.changeset(%Message{}, %{})
      assert "can't be blank" in errors_on(changeset).chat_room_id
    end
  end
end
