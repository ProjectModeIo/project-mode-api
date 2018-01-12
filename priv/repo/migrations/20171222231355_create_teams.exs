defmodule PmApi.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string

      timestamps()
    end

    create index(:teams, [:name], unique: true)
  end
end
