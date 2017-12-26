defmodule PmApi.Repo.Migrations.AlterProjectcategoryTable do
  use Ecto.Migration

  def change do
    alter table(:projectcategories) do
      remove :project_id
      remove :interest_id
      add :project_id, references(:projects, on_delete: :delete_all)
      add :interest_id, references(:interests, on_delete: :delete_all)
    end
    create index(:projectcategories, [:project_id, :interest_id], unique: true)
  end
end
