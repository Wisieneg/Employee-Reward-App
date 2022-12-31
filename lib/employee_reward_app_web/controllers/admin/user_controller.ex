defmodule EmployeeRewardAppWeb.Admin.UserController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Users
  alias EmployeeRewardApp.Users.User

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    Users.delete_user(user)
    redirect(conn, to: Routes.admin_user_path(conn, :index))
  end

end
