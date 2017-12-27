defmodule PmApi.Repo.Migrations.CreateUserskills do
  use Ecto.Migration

  def change do
    create table(:userskills) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :skill_id, references(:skills, on_delete: :delete_all)

      timestamps()
    end

    create index(:userskills, [:user_id])
    create index(:userskills, [:skill_id])
  end
end
