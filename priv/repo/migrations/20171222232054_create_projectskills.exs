defmodule PmApi.Repo.Migrations.CreateProjectstacks do
  use Ecto.Migration

  def change do
    create table(:projectskills) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :skill_id, references(:skills, on_delete: :delete_all)

      timestamps()
    end

    create index(:projectskills, [:project_id])
    create index(:projectskills, [:skill_id])

  end
end
