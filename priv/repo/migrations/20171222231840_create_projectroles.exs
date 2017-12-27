defmodule PmApi.Repo.Migrations.CreateProjectroles do
  use Ecto.Migration

  def change do
    create table(:projectroles) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :nothing)
      
      timestamps()
    end

    create index(:projectroles, [:project_id])
    create index(:projectroles, [:role_id])
  end
end
