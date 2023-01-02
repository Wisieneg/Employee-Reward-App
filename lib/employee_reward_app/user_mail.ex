defmodule EmployeeRewardApp.UserMail do
  import Swoosh.Email

  @mailgun_domain System.get_env("MAILGUN_DOMAIN")

  def reward_notification(reward) do
    """
    <h1>Congratulations #{reward.to_user.username}!</h1>
    <p>You've just been granted #{reward.amount} #{if reward.amount>1 do "points" else "point" end} by #{reward.from_user.username}!</p>
    <p><a href="#{EmployeeRewardAppWeb.Endpoint.url() <> "/rewards/received"}">Check out your rewards.</a></p>
    """
  end

  def send_notification(user, message) do
    new()
    |> from({"Employee Reward App", "support@#{@mailgun_domain}"})
    |> to({user.name, user.email})
    |> subject("Reward notification")
    |> html_body(message)
    |> EmployeeRewardApp.Mailer.deliver()
  end
end
