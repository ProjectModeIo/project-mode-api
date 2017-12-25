defmodule PmApi.Repo.Migrations.AddUniqueIndexToRoleTable do
  use Ecto.Migration

  def change do
    create index(:userroles, [:user_id, :role_id], unique: true)
  end
end
