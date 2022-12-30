defmodule EmployeeRewardApp.UsersTest do
  use EmployeeRewardApp.DataCase

  alias EmployeeRewardApp.Users

  describe "users" do
    alias EmployeeRewardApp.Users.User

    import EmployeeRewardApp.UsersFixtures

    @create_attrs %{name: "Wojciech Wiśniewski", email: "wwisniewski@example.com", username: "wisieneg", password: "testpassword", password_confirmation: "testpassword"}
    @update_attrs %{name: "Wojciech Piotr Wiśniewski", username: "wisieneg2",current_password: "testpassword"}
    @invalid_attrs %{name: "Wojciech Wiśniewski", email: "wwisniewski@example.com", username: "wi", password: "testsword", password_confirmation: "testpassword"}

    test "list_users/0 returns all users" do
      user = user_fixture(@create_attrs)

      # get_user is called because default values for role and points are inserted at database
      user = Users.get_user!(user.id)
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture(@create_attrs)
      changeset = User.update_changeset(user, %{points: 50, role: "user"})
      user = Ecto.Changeset.apply_changes(changeset)
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = @create_attrs

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture(@create_attrs)
      update_attrs = @update_attrs

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture(@create_attrs)
      changeset = User.update_changeset(user, %{points: 50, role: "user"})
      user = Ecto.Changeset.apply_changes(changeset)
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture(@create_attrs)
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture(@create_attrs)
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
