defmodule Chatter.UserTest do
  use Chatter.DataCase, async: true
  alias Chatter.User

  describe "changeset/2" do
    test "validates that user email can't be blank" do
      params = %{}
      changeset = User.changeset(%User{}, params)
      assert "can't be blank" in errors_on(changeset).email
    end

    test "validates that user password can't be blank" do
      params = %{}
      changeset = User.changeset(%User{}, params)
      assert "can't be blank" in errors_on(changeset).password
    end

    test "validates that email is unique" do
      same_email = "someone@example.com"

      params = %{
        email: same_email,
        password: "pass123"
      }

      insert(:user, email: same_email)

      {:error, changeset} =
        %User{}
        |> User.changeset(params)
        |> Repo.insert()

      assert "has already been taken" in errors_on(changeset).email
    end

    test "adds hashed_password" do
      changeset =
        User.changeset(%User{}, %{
          email: "someone@example.com",
          password: "pass123"
        })

      assert changeset.changes.hashed_password
    end
  end
end
