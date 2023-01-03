defmodule EmployeeRewardAppWeb.UserView do
  use EmployeeRewardAppWeb, :view


  def is_admin?(user) do
    user.role == "admin"
  end

  def get_user_points(user) do
    %{points: points} = Users.get_user!(user.id)
    points
  end
end
