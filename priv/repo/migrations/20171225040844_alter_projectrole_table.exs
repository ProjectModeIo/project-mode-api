defmodule PmApi.Repo.Migrations.AlterProjectroleTable do
  use Ecto.Migration

  def change do
    alter table(:projectroles) do
      remove :project_id
      remove :role_id
      add :project_id, references(:projects, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end
