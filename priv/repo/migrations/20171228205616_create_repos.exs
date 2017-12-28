defmodule PmApi.Repo.Migrations.CreateRepos do
  use Ecto.Migration

  def change do
    create table(:repos) do
      add :commits_json, :string
      add :totalcommits, :integer
      add :repo_endpoint, :string
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end

    create index(:repos, [:project_id], unique: true)
  end
end
