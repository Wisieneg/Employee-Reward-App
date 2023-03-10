# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :employee_reward_app,
  ecto_repos: [EmployeeRewardApp.Repo]

# Configures the endpoint
config :employee_reward_app, EmployeeRewardAppWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: EmployeeRewardAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EmployeeRewardApp.PubSub,
  live_view: [signing_salt: "D047uE5f"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :employee_reward_app, EmployeeRewardApp.Mailer,
  adapter: Swoosh.Adapters.Mailgun,
  base_url: "https://api.mailgun.net/v3",
  api_key: System.get_env("MAILGUN_API_KEY"),
  domain: System.get_env("MAILGUN_DOMAIN")

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, Swoosh.ApiClient.Hackney

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase


config :employee_reward_app, :pow,
  user: EmployeeRewardApp.Users.User,
  repo: EmployeeRewardApp.Repo,
  web_module: EmployeeRewardAppWeb

config :employee_reward_app, EmployeeRewardApp.Scheduler,
  timezone: "Europe/Warsaw",
  jobs: [
    # Triggered every day at midnight
    {"@daily",   fn -> EmployeeRewardApp.Users.grant_monthly_points() end},
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :logger, level: :debug

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
