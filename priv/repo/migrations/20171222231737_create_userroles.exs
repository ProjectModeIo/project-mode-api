defmodule PmApi.Repo.Migrations.CreateUserroles do
  use Ecto.Migration

  def change do
    create table(:userroles) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)

      timestamps()
    end

    create index(:userroles, [:user_id])
    create index(:userroles, [:role_id])
  end
end
