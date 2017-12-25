defmodule PmApi.Repo.Migrations.CreateTeamprojects do
  use Ecto.Migration

  def change do
    create table(:teamprojects) do
      add :team_id, references(:teams, on_delete: :nothing)
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:teamprojects, [:team_id])
    create index(:teamprojects, [:project_id])
  end
end
