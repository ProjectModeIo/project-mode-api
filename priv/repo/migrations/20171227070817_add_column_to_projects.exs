defmodule PmApi.Repo.Migrations.AddColumnToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :project_scope, :string
      add :repositories, :string
      add :active, :boolean, default: false
    end
  end
end
