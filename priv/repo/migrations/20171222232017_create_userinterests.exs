defmodule PmApi.Repo.Migrations.CreateUserinterests do
  use Ecto.Migration

  def change do
    create table(:userinterests) do
      add :user_id, references(:users, on_delete: :nothing)
      add :interest_id, references(:interests, on_delete: :nothing)

      timestamps()
    end

    create index(:userinterests, [:user_id])
    create index(:userinterests, [:interest_id])
  end
end
