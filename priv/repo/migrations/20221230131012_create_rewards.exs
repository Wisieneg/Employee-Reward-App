defmodule EmployeeRewardApp.Repo.Migrations.CreateRewards do
  use Ecto.Migration

  def change do
    create table(:rewards) do
      add :amount, :integer
      add :from_id, references(:users, on_delete: :delete_all)
      add :to_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:rewards, [:from_id])
    create index(:rewards, [:to_id])
  end
end
