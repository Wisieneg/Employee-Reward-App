defmodule EmployeeRewardAppWeb.Admin.RewardView do
  use EmployeeRewardAppWeb, :view

  alias EmployeeRewardApp.Users

  def get_user_points(user) do
    %{points: points} = Users.get_user!(user.id)
    points
  end

  def format_date(date_time), do: "#{Date.to_string(date_time)}"

  def format_time(date_time), do: "#{Time.to_string(date_time)}"

  def format_datetime(date_time) do
    {:ok, formatted} = Timex.format(date_time, "%H:%M %d/%m/%y", :strftime)
    formatted
  end

  def summary_date(month) do
    date = Timex.parse!(month, "{YYYY}-{0M}")

    Calendar.strftime(
      date,
      "%B %Y",
      month_names: fn month ->
        {
         "January",
         "February",
         "March",
         "April",
         "May",
         "June",
         "July",
         "August",
         "September",
         "October",
         "November",
         "December"
         } |> elem(month-1) end
    )
  end

end
