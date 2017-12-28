defmodule PmApi.Repo.Migrations.CreateInterests do
  use Ecto.Migration

  def change do
    create table(:interests) do
      add :name, :string

      timestamps()
    end
    create index(:interests, [:name], unique: true)
  end
end
