defmodule EmployeeRewardAppWeb.LayoutView do
  use EmployeeRewardAppWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def first_name(user) do
    user.name
    |> String.split()
    |> Enum.at(0)
  end
end
