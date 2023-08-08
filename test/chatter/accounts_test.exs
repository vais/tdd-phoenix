defmodule Chatter.AccountsTest do
  use Chatter.DataCase, async: true
  alias Chatter.{Accounts, User}

  describe "create_user/1" do
    test "creates a user with email and password" do
      email = "someone@example.com"
      params = %{"email" => email, "password" => "some password"}

      {:ok, user} = Accounts.create_user(params)

      assert user.id
      assert user.email == email
      assert user.hashed_password
      assert user.session_secret
    end

    test "returns a changeset if it fails to create a user" do
      params = %{"email" => "", "password" => "some password"}

      {:error, changeset} = Accounts.create_user(params)

      assert "can't be blank" in errors_on(changeset).email
    end
  end

  describe "change_user/1" do
    test "returns a changeset for a user" do
      changeset = Accounts.change_user(%User{})

      assert %Ecto.Changeset{} = changeset
    end
  end
end
