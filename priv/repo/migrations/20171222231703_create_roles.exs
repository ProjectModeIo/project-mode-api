defmodule PmApi.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string

      timestamps()
    end
    create index(:roles, [:name], unique: true)
  end
end
