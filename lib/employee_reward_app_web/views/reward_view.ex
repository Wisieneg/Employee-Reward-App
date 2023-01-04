defmodule EmployeeRewardAppWeb.RewardView do
  use EmployeeRewardAppWeb, :view

  alias EmployeeRewardApp.Users

  # The points are received from the view in case they were modified.
  def get_user_points(user) do
    %{points: points} = Users.get_user!(user.id)
    points
  end

  def format_date(date_time), do: "#{Date.to_string(date_time)}"

  def format_time(date_time), do: "#{Time.to_string(date_time)}"

  def format_datetime(date_time) do
    {:ok, formatted} = Timex.format(date_time, "%d/%m/%Y, %H:%M", :strftime)
    formatted
  end

end
