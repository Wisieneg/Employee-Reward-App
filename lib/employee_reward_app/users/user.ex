defmodule EmployeeRewardApp.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    field :username, :string
    field :role, :string
    field :points, :integer

    pow_user_fields()

    timestamps()

  end
end
