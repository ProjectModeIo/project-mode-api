defmodule PmApi.Repo.Migrations.AddUniqueIndexToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :slug, :string
      add :project_scope, :string
      add :repositories, :string
      add :active, :boolean, default: false
    end
    create index(:projects, [:user_id, :title], unique: true)
    create index(:projects, [:user_id, :slug], unique: true)
  end
end
