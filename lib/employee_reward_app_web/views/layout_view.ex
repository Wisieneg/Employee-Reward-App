defmodule EmployeeRewardAppWeb.LayoutView do
  use EmployeeRewardAppWeb, :view

  alias EmployeeRewardApp.Users
  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  @spec first_name(atom | %{:name => binary, optional(any) => any}) :: any
  def first_name(user) do
    user.name
    |> String.split()
    |> Enum.at(0)
  end

  def get_user_points(user) do
    %{points: points} = Users.get_user!(user.id)
    points
  end

  def is_admin?(user) do
    user.role == "admin"
  end

end
