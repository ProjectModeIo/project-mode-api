defmodule PmApi.Repo.Migrations.AddNameToRoles do
  use Ecto.Migration

  def change do
    alter table(:roles) do
      add :name, :string
    end
    create index(:roles, [:name], unique: true)
  end
end
