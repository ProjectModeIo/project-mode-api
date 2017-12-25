defmodule PmApi.Repo.Migrations.CreateTeammembers do
  use Ecto.Migration

  def change do
    create table(:teammembers) do
      add :team_id, references(:teams, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:teammembers, [:team_id])
    create index(:teammembers, [:user_id])
  end
end
