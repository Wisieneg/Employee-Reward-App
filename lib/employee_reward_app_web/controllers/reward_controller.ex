defmodule EmployeeRewardAppWeb.RewardController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Rewards
  alias EmployeeRewardApp.Rewards.Reward
  alias EmployeeRewardApp.Users

  def index(conn, _params) do
    rewards = Rewards.list_rewards()
    render(conn, "index.html", rewards: rewards)
  end

  def new(conn, %{"id" => id}) do
    case conn.assigns.current_user.id == String.to_integer(id) do
      true ->
        conn
        |> put_flash(:info, "You cannot give reward to yourself!")
        |> redirect(to: Routes.user_path(conn, :index))
      false ->
        changeset = Rewards.change_reward(%Reward{to_id: id})
        render(conn, "new.html", changeset: changeset, to_id: id)
    end
  end

  def create(conn, %{"to_id" => to_id, "reward" => reward_params}) do
    from_user = conn.assigns.current_user
    to_user = Users.get_user!(to_id)

    case Rewards.create_reward(from_user, to_user, reward_params) do
      {:ok, reward} ->

        %{"amount" => points} = reward_params
        Users.update_user(from_user, %{points: from_user.points-String.to_integer(points)})

        conn
        |> put_flash(:info, "Reward created successfully.")
        |> redirect(to: Routes.reward_path(conn, :show, reward))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render("new.html", changeset: changeset, to_id: to_id)
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
