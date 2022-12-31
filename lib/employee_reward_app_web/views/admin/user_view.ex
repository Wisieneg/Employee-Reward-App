defmodule EmployeeRewardAppWeb.Admin.UserView do
  use EmployeeRewardAppWeb, :view

  def first_name(user) do
    user.name
    |> String.split()
    |> Enum.at(0)
  end

  def is_admin?(user) do
    user.role == "admin"
  end
end
