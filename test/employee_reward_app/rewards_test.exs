defmodule EmployeeRewardApp.RewardsTest do
  use EmployeeRewardApp.DataCase

  alias EmployeeRewardApp.Rewards

  describe "rewards" do
    alias EmployeeRewardApp.Rewards.Reward

    import EmployeeRewardApp.RewardsFixtures
    import EmployeeRewardApp.UsersFixtures

    @invalid_attrs %{amount: -1}
    @valid_attrs %{"amount" => 2}

    @user1_attrs %{name: "Wojciech Wiśniewski", email: "wwisniewski@example.com", username: "wisieneg", password: "testpassword", password_confirmation: "testpassword"}
    @user2_attrs %{name: "Wojciech Wiśniewski", email: "wwisniewski2@example.com", username: "wisieneg2", password: "testpassword", password_confirmation: "testpassword"}

    test "list_rewards/0 returns all rewards" do
      reward = reward_fixture()
      assert Rewards.list_rewards() == [reward]
    end

    test "get_reward!/1 returns the reward with given id" do
      reward = reward_fixture()
      assert Rewards.get_reward!(reward.id) == reward
    end

    test "create_reward/1 with valid data creates a reward" do
      user1 =user_fixture(@user1_attrs)
      user2 =user_fixture(@user2_attrs)
      assert {:ok,  reward} = Rewards.create_reward(user1,user2,@valid_attrs)
      assert reward.amount == 2
    end

    test "create_reward/1 with invalid data returns error changeset" do
      user1 =user_fixture(@user1_attrs)
      user2 =user_fixture(@user2_attrs)
      assert {:error, %Ecto.Changeset{}} = Rewards.create_reward(user1, user2, @invalid_attrs)
    end

    test "delete_reward/1 deletes the reward" do
      reward = reward_fixture()
      assert {:ok, %Reward{}} = Rewards.delete_reward(reward)
      assert_raise Ecto.NoResultsError, fn -> Rewards.get_reward!(reward.id) end
    end

    test "change_reward/1 returns a reward changeset" do
      reward = reward_fixture()
      assert %Ecto.Changeset{} = Rewards.change_reward(reward)
    end
  end
end
