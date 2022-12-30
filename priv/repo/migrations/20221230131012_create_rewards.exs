defmodule EmployeeRewardApp.Repo.Migrations.CreateRewards do
  use Ecto.Migration

  def change do
    create table(:rewards) do
      add :amount, :integer
      add :from, references(:users, on_delete: :delete_all)
      add :to, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:rewards, [:from])
    create index(:rewards, [:to])
  end
end
