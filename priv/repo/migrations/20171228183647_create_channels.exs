defmodule PmApi.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :name, :string
      timestamps()
    end
    create index(:channels, [:name], unique: true)

    alter table(:roles) do
      add :channel_id, references(:channels, on_delete: :nothing)
    end
    alter table(:skills) do
      add :channel_id, references(:channels, on_delete: :nothing)
    end
    alter table(:interests) do
      add :channel_id, references(:channels, on_delete: :nothing)
    end
  end
end
