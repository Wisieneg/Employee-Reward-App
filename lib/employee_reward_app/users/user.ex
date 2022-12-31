defmodule EmployeeRewardApp.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :name, :string
    field :role, :string
    field :points, :integer

    has_many :given_to, EmployeeRewardApp.Rewards.Reward, foreign_key: :to_id
    has_many :given_by, EmployeeRewardApp.Rewards.Reward, foreign_key: :from_id

    pow_user_fields()

    timestamps()

  end


  def update_changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:points, :role])
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> cast(attrs, [:username, :name])
    |> validate_required([:username, :name])
    |> validate_length(:username, min: 3, max: 40)
    |> unique_constraint(:username)
  end

end
