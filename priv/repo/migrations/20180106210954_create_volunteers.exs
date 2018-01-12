defmodule PmApi.Repo.Migrations.CreateVolunteers do
  use Ecto.Migration

  def change do
    create table(:volunteers) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end

    create index(:volunteers, [:user_id, :project_id], unique: true)
    create index(:volunteers, [:user_id])
    create index(:volunteers, [:project_id])
  end
end
