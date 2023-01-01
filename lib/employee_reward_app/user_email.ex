defmodule EmployeeRewardApp.UserMail do
  import Swoosh.Email

  def mailto() do
    new()
  end
end
