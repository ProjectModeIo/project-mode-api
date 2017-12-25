defmodule PmApi.Repo.Migrations.CreateProjectcategories do
  use Ecto.Migration

  def change do
    create table(:projectcategories) do
      add :project_id, references(:projects, on_delete: :nothing)
      add :interest_id, references(:interests, on_delete: :nothing)

      timestamps()
    end

    create index(:projectcategories, [:project_id])
    create index(:projectcategories, [:interest_id])
  end
end
