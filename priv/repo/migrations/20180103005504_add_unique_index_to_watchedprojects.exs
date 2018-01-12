defmodule PmApi.Repo.Migrations.AddUniqueIndexToWatchedprojects do
  use Ecto.Migration

  def change do
    create index(:watchedprojects, [:user_id, :project_id], unique: true)
  end
end
