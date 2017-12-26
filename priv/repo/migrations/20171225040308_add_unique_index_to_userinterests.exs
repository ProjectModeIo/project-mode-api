defmodule PmApi.Repo.Migrations.AddUniqueIndexToUserinterests do
  use Ecto.Migration

  def change do
    create index(:userinterests, [:user_id, :interest_id], unique: true)
  end
end
