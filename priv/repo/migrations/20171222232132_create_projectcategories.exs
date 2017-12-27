defmodule PmApi.Repo.Migrations.CreateProjectcategories do
  use Ecto.Migration

  def change do
    create table(:projectcategories) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :interest_id, references(:interests, on_delete: :delete_all)

      timestamps()
    end

    create index(:projectcategories, [:project_id])
    create index(:projectcategories, [:interest_id])
    create index(:projectcategories, [:project_id, :interest_id], unique: true)
  end
end
