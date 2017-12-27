defmodule PmApi.Repo.Migrations.CreateProjectstacks do
  use Ecto.Migration

  def change do
    create table(:projectstacks) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :skill_id, references(:skills, on_delete: :delete_all)

      timestamps()
    end

    create index(:projectstacks, [:project_id])
    create index(:projectstacks, [:skill_id])
  end
end
