defmodule PmApi.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :text, :string
      add :channel_id, references(:channels, on_delete: :delete_all)
      add :team_id, references(:teams, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:messages, [:channel_id])
    create index(:messages, [:team_id])
    create index(:messages, [:user_id])
  end
end
