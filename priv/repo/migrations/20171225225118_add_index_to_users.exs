defmodule PmApi.Repo.Migrations.AddIndexToUsers do
  use Ecto.Migration

  def change do
    create index(:users, [:username], unique: true)
  end
end
