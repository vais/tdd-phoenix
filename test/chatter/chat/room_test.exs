defmodule Chatter.Chat.RoomTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat.Room

  describe "changeset/2" do
    test "returns an ecto changeset" do
      changeset = Room.changeset(%Room{}, %{})
      assert %Ecto.Changeset{} = changeset
    end

    test "validates presence of name" do
      changeset = Room.changeset(%Room{}, %{})
      assert "can't be blank" in errors_on(changeset).name
    end

    test "validates uniqueness of name" do
      name = "dupe"
      insert(:chat_room, name: name)

      {:error, changeset} =
        %Room{}
        |> Room.changeset(params_for(:chat_room, name: name))
        |> Repo.insert()

      assert "has already been taken" in errors_on(changeset).name
    end
  end
end
