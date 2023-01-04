defmodule EmployeeRewardApp.RewardsFixtures do
  alias EmployeeRewardApp.Users
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EmployeeRewardApp.Rewards` context.
  """

  @doc """
  Generate a reward.
  """

  @valid_params1  %{name: "user1 user1", email: "user1@example.com", username: "user1", password: "password1111", password_confirmation: "password1111"}
  @valid_params2  %{name: "user2 user2", email: "user2@example.com", username: "user2", password: "password1111", password_confirmation: "password1111"}

  def reward_fixture(attrs \\ %{}) do
    {:ok, from_user} = Users.create_user(@valid_params1)
    {:ok, to_user} = Users.create_user(@valid_params2)

    from_user = Users.get_user!(from_user.id)
    to_user = Users.get_user!(to_user.id)

    attrs=Enum.into(attrs, %{amount: 42})

    {:ok, reward} = EmployeeRewardApp.Rewards.create_reward(from_user, to_user, attrs)

    reward
  end
end
