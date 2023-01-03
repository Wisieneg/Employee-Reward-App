defmodule EmployeeRewardAppWeb.UserController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Users

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end

end
