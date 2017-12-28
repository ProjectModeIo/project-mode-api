defmodule PmApi.Repo.Migrations.CreateSkills do
  use Ecto.Migration

  def change do
    create table(:skills) do
      add :name, :string

      timestamps()
    end
    create index(:skills, [:name], unique: true)
  end
end
