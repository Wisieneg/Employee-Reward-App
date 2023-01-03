defmodule EmployeeRewardAppWeb.RewardController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Rewards
  alias EmployeeRewardApp.Rewards.Reward
  alias EmployeeRewardApp.Users
  alias EmployeeRewardApp.UserMail


  def new(conn, %{"id" => id}) do
    case {Users.get_user(id), conn.assigns.current_user.id == String.to_integer(id)} do
      {nil, _} ->
        conn
        |> put_flash(:error, "The user with given id doesn't exist")
        |> redirect(to: Routes.user_path(conn, :index))
      {_, true} ->
        conn
        |> put_flash(:error, "You cannot give reward to yourself!")
        |> redirect(to: Routes.user_path(conn, :index))
      {_, false} ->
        changeset = Rewards.change_reward(%Reward{})
        render(conn, "new.html", changeset: changeset, to_id: id)
    end
  end

  def create(conn, %{"to_id" => to_id, "reward" => reward_params}) do
    from_user = Users.get_user!(conn.assigns.current_user.id)
    to_user = Users.get_user!(to_id)

    case Rewards.create_reward(from_user, to_user, reward_params) do
      {:ok, reward} ->
        %{"amount" => points} = reward_params
        Users.update_fields(from_user, %{points: from_user.points-String.to_integer(points)})

        message = UserMail.reward_notification(reward)
        UserMail.send_notification(to_user, message)

        conn
        |> put_flash(:info, "Reward created successfully.")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render("new.html", changeset: changeset, to_id: to_id)
    end
  end

  def given(conn, _params) do
    rewards = Rewards.get_given_rewards(conn.assigns.current_user.id)
    |> Enum.sort(& NaiveDateTime.compare(&1.inserted_at, &2.inserted_at) != :lt)

    conn
    |> render("given.html", rewards: rewards)
  end

  def received(conn, _params) do
    rewards = Rewards.get_received_rewards(conn.assigns.current_user.id)
    |> Enum.sort(& NaiveDateTime.compare(&1.inserted_at, &2.inserted_at) != :lt)

    conn
    |> render("received.html", rewards: rewards)
  end

end
