defmodule EmployeeRewardAppWeb.AdminController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Users
  alias EmployeeRewardApp.Users.User
  alias EmployeeRewardApp.Rewards

  def index(conn, _params) do
    rewards = Rewards.list_rewards()
    render(conn, "index.html", rewards: rewards)
  end

end
