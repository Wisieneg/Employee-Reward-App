defmodule EmployeeRewardAppWeb.Admin.AdminController do
  use EmployeeRewardAppWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: Routes.admin_user_path(conn, :index))
  end

end
