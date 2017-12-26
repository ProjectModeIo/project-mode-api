defmodule PmApi.Repo.Migrations.AlterProjectstackTable do
  use Ecto.Migration

  def change do
    alter table(:projectstacks) do
      remove :project_id
      remove :skill_id
      add :project_id, references(:projects, on_delete: :delete_all)
      add :skill_id, references(:skills, on_delete: :delete_all)
    end
    create index(:projectstacks, [:project_id, :skill_id], unique: true)
  end
end
