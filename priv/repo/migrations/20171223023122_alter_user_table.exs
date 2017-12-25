defmodule PmApi.Repo.Migrations.AlterUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :password
      add :password_hash, :string
    end
    create unique_index(:users, [:email])
  end

end
