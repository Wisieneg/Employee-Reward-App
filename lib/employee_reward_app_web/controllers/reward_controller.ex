defmodule EmployeeRewardAppWeb.RewardController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Rewards
  alias EmployeeRewardApp.Rewards.Reward

  def index(conn, _params) do
    rewards = Rewards.list_rewards()
    render(conn, "index.html", rewards: rewards)
  end

  def new(conn, _params) do
    changeset = Rewards.change_reward(%Reward{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reward" => reward_params}) do
    case Rewards.create_reward(reward_params) do
      {:ok, reward} ->
        conn
        |> put_flash(:info, "Reward created successfully.")
        |> redirect(to: Routes.reward_path(conn, :show, reward))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reward = Rewards.get_reward!(id)
    render(conn, "show.html", reward: reward)
  end


  def delete(conn, %{"id" => id}) do
    reward = Rewards.get_reward!(id)
    {:ok, _reward} = Rewards.delete_reward(reward)

    conn
    |> put_flash(:info, "Reward deleted successfully.")
    |> redirect(to: Routes.reward_path(conn, :index))
  end
end
