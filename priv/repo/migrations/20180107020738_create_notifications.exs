defmodule PmApi.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :message, :string
      add :seen, :boolean, default: false, null: false
      add :read_at, :naive_datetime
      add :link, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:notifications, [:user_id])
  end
end
