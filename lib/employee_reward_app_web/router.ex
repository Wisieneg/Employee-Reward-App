defmodule EmployeeRewardAppWeb.Router do
  use EmployeeRewardAppWeb, :router
  use Pow.Phoenix.Router

  #alias EmployeeRewardAppWeb.UserController
  #alias EmployeeRewardAppWeb.RewardController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {EmployeeRewardAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :admin do
    plug EmployeeRewardAppWeb.RoleGuardPlug, :admin
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", EmployeeRewardAppWeb do
    pipe_through [:browser, :protected]

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show]

    resources "/rewards", RewardController, only: [:create]
    get "/rewards/given", RewardController, :given
    get "/rewards/received", RewardController, :received
    get "/rewards/new/:id", RewardController, :new
  end

  scope "/admin", EmployeeRewardAppWeb.Admin, as: :admin do
    pipe_through [:browser, :protected, :admin]

    get "/", AdminController, :index
    get "/rewards/summary", RewardController, :summary
    resources "/rewards", RewardController, only: [:index, :show, :delete]
    resources "/users", UserController, only: [:index, :show, :delete, :edit, :update]
  end

  # Other scopes may use custom stacks.
  # scope "/api", EmployeeRewardAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EmployeeRewardAppWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
