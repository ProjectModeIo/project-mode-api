defmodule PmApi.Repo.Migrations.AlterUserrolesTable do
  use Ecto.Migration

  def change do
    alter table(:userroles) do
      remove :user_id
      remove :role_id
      add :user_id, references(:users, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)
    end
  end
end
