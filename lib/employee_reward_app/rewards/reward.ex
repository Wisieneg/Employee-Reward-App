defmodule EmployeeRewardApp.Rewards.Reward do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rewards" do
    field :amount, :integer
    belongs_to :from_user, EmployeeRewardApp.Users.User, foreign_key: :from_id
    belongs_to :to_user, EmployeeRewardApp.Users.User, foreign_key: :to_id

    timestamps()
  end

  @doc false
  def changeset(reward, attrs) do
    reward
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
