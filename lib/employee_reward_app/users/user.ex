defmodule EmployeeRewardApp.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :role, :string
    field :points, :integer

    pow_user_fields()

    timestamps()

  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> cast(attrs, [:username])
    |> validate_required(:username)
    |> validate_length(:username, min: 3, max: 40)
  end

end
