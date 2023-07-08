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
      {:error, changeset} = Chat.create_chat_room(%{})
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
end
