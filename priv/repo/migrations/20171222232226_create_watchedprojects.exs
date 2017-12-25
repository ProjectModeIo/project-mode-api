defmodule PmApi.Repo.Migrations.CreateWatchedprojects do
  use Ecto.Migration

  def change do
    create table(:watchedprojects) do
      add :interestlevel, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:watchedprojects, [:user_id])
    create index(:watchedprojects, [:project_id])
  end
end
