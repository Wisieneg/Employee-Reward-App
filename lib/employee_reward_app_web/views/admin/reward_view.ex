defmodule EmployeeRewardAppWeb.Admin.RewardView do
  use EmployeeRewardAppWeb, :view

  alias EmployeeRewardApp.Users

  def get_user_points(user) do
    %{points: points} = Users.get_user!(user.id)
    points
  end

end
