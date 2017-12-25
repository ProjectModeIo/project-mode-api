defmodule PmApi.Repo.Migrations.CreateUserskills do
  use Ecto.Migration

  def change do
    create table(:userskills) do
      add :user_id, references(:users, on_delete: :nothing)
      add :skill_id, references(:skills, on_delete: :nothing)

      timestamps()
    end

    create index(:userskills, [:user_id])
    create index(:userskills, [:skill_id])
  end
end
