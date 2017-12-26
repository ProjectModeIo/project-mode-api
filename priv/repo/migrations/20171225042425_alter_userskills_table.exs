defmodule PmApi.Repo.Migrations.AlterUserskillsTable do
  use Ecto.Migration

  def change do
    alter table(:userskills) do
      remove :user_id
      remove :skill_id
      add :user_id, references(:users, on_delete: :delete_all)
      add :skill_id, references(:skills, on_delete: :delete_all)
    end
  end
end
