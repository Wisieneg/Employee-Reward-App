defmodule EmployeeRewardAppWeb.RewardView do
  use EmployeeRewardAppWeb, :view

  alias EmployeeRewardApp.Users

  def get_user_points(user) do
    %{points: points} = Users.get_user!(user.id)
    points
  end

  def get_username(user_id) do
    user = Users.get_user!(user_id)
    user.username
  end

  def format_date(date_time), do: "#{Date.to_string(date_time)}"

  def format_time(date_time), do: "#{Time.to_string(date_time)}"

  def format_datetime(date_time), do: "#{format_date(date_time)} #{format_time(date_time)}"
end
