defmodule PmApi.Repo.Migrations.AlterUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :password
      add :password_hash, :string
      add :username, :string
      add :contact_info, :string
    end
    create unique_index(:users, [:email])
    create index(:users, [:username], unique: true)
  end

end
