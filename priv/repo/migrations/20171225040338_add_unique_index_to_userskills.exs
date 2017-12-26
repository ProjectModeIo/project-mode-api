defmodule PmApi.Repo.Migrations.AddUniqueIndexToUserskills do
  use Ecto.Migration

  def change do
    create index(:userskills, [:user_id, :skill_id], unique: true)
  end
end
