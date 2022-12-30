defmodule EmployeeRewardAppWeb.PageController do
  use EmployeeRewardAppWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: Routes.user_path(conn, :index))
  end
end
