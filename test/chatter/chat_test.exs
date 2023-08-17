defmodule Chatter.ChatTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat

  describe "all_rooms/0" do
    test "returns all rooms" do
      [room1, room2] = insert_pair(:chat_room)

      rooms = Chat.all_rooms()

      assert room1 in rooms
      assert room2 in rooms
    end
  end

  describe "new_chat_room/0" do
    test "creates a changeset for a new chat room" do
      assert %Ecto.Changeset{} = Chat.new_chat_room()
    end
  end

  describe "create_chat_room/1" do
    test "creates a rooom with valid params" do
      params = string_params_for(:chat_room)

      {:ok, room} = Chat.create_chat_room(params)

      assert %Chat.Room{} = room
      assert room.name == params["name"]
    end

    test "returns an error tuple for invalid params" do
      params = %{}

      {:error, changeset} = Chat.create_chat_room(params)

      assert "can't be blank" in errors_on(changeset).name
    end
  end

  describe "find_room/1" do
    test "finds room by id" do
      room = insert(:chat_room)

      found_room = Chat.find_room(room.id)

      assert room == found_room
    end
  end

  describe "find_room_by_name/1" do
    test "finds room by name" do
      room = insert(:chat_room)

      found_room = Chat.find_room_by_name(room.name)

      assert room == found_room
    end
  end

  describe "new_message/2" do
    test "inserts a message for a chat room" do
      room = insert(:chat_room)
      params = %{"body" => "hi there", "author" => "someone@example.com"}

      {:ok, message} = Chat.new_message(room, params)

      assert message.id
      assert message.chat_room_id == room.id
      assert message.body == params["body"]
      assert message.author == params["author"]
    end

    test "returns a changeset if insert fails" do
      room = insert(:chat_room)
      params = %{}

      {:error, changeset} = Chat.new_message(room, params)

      refute changeset.valid?
    end
  end

  describe "room_messages/1" do
    test "returns a list of messages for a room" do
      room = insert(:chat_room)
      inserted_messages = insert_pair(:chat_room_message, chat_room: room)
      _extra_message = insert(:chat_room_message)

      found_messages = Chat.room_messages(room)

      assert format_messages(found_messages) == format_messages(inserted_messages)
    end

    defp format_messages(messages) do
      Enum.map(messages, &Map.take(&1, [:id, :body, :author]))
    end
  end
end
