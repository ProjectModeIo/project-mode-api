defmodule PmApi.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :projects_json, :string
      add :commits_json, :string
      add :organizations_json, :string
      add :totalprojects, :integer
      add :totalcommits, :integer
      add :totalorganizations, :integer
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:accounts, [:user_id], unique: true)
  end
end
