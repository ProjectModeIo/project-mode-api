defmodule PmApi.Repo.Migrations.AddUniqueIndexToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :slug, :string
    end
    create index(:projects, [:user_id, :slug], unique: true)
  end
end
