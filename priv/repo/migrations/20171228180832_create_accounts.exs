defmodule PmApi.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :access_token, :string
      add :github_info_json, :text #maybe change to github_info_json
      add :projects_json, :text
      add :commits_json, :text
      add :organizations_json, :text
      add :totalprojects, :integer
      add :totalcommits, :integer
      add :totalorganizations, :integer
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:accounts, [:user_id], unique: true)
  end
end
