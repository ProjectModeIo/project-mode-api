defmodule PmApi.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :title, :string
      add :description, :string
      add :status, :string, default: "proposal"
      add :user_id, references(:users, on_delete: :delete_all)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:projects, [:user_id])
  end
end
