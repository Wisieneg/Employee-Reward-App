defmodule EmployeeRewardAppWeb.UserView do
  use EmployeeRewardAppWeb, :view

  def first_name(user) do
    user.name
    |> String.split()
    |> Enum.at(0)
  end
end
