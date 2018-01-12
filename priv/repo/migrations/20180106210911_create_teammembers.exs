defmodule PmApi.Repo.Migrations.CreateTeammembers do
  use Ecto.Migration

  def change do
    create table(:teammembers) do
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :delete_all)
      add :membership, :string

      timestamps()
    end

    create index(:teammembers, [:user_id, :team_id], unique: true)
    create index(:teammembers, [:user_id])
    create index(:teammembers, [:team_id])
  end
end
