defmodule PmApi.Repo.Migrations.CreateProjectinterests do
  use Ecto.Migration

  def change do
    create table(:projectinterests) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :interest_id, references(:interests, on_delete: :delete_all)

      timestamps()
    end

    create index(:projectinterests, [:project_id])
    create index(:projectinterests, [:interest_id])
    create index(:projectinterests, [:project_id, :interest_id], unique: true)
  end
end
