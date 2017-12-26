defmodule PmApi.Repo.Migrations.AddUniqueIndexToProject do
  use Ecto.Migration

  def change do
    create index(:projects, [:user_id, :title], unique: true)
  end
end
