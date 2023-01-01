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

  def edit(conn, %{"id" => id}) do
    IO.inspect id
    user = Users.get_user!(id)
    changeset = User.update_changeset(user, %{})
    render(conn, "edit.html", changeset: changeset, user: user)
  end

  def update(conn,%{"id" => id, "user" => params}) do
    user = Users.get_user!(id)
    case Users.update_fields(user, params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User updated succesfully!")
        |> redirect(to: Routes.admin_user_path(conn, :index))

      {:error, changeset} ->
        render(conn, "assign.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    Users.delete_user(user)
    redirect(conn, to: Routes.admin_user_path(conn, :index))
  end

end
