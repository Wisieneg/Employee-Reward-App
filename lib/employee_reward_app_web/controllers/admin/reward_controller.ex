defmodule EmployeeRewardAppWeb.Admin.RewardController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Rewards
  alias EmployeeRewardApp.Rewards.Reward
  alias EmployeeRewardApp.Users

  def index(conn, _params) do
    rewards = Rewards.list_rewards()
    |> Enum.sort(& NaiveDateTime.compare(&1.inserted_at, &2.inserted_at) != :lt)
    render(conn, "index.html", rewards: rewards)
  end


  def show(conn, %{"id" => id}) do
    reward = Rewards.get_reward!(id)
    render(conn, "show.html", reward: reward)
  end


  def delete(conn, %{"id" => id}) do
    reward = Rewards.get_reward(id)

    case Rewards.delete_reward(reward) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Reward deleted successfully.")
        |> redirect(to: Routes.admin_reward_path(conn, :index))
      {:error, er} ->
        conn
        |> put_flash(:error, "Reward coulnd't be deleted. #{er}")
        |> redirect(to: Routes.admin_reward_path(conn, :index))
    end
  end


  def summary(conn, params) do
    case params do
      %{"month" => month} ->
        summaries = Users.rewards_summary(month)
        render(conn, "summary.html", summaries: summaries, month: month)
      %{} ->
        summaries = []
        render(conn, "summary.html", summaries: summaries)
    end

  end


end
