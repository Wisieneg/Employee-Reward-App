defmodule EmployeeRewardAppWeb.Admin.RewardView do
  use EmployeeRewardAppWeb, :view

  alias EmployeeRewardApp.Users

  def get_user_points(user) do
    %{points: points} = Users.get_user!(user.id)
    points
  end

  def format_date(date_time), do: "#{Date.to_string(date_time)}"

  def format_time(date_time), do: "#{Time.to_string(date_time)}"

end
