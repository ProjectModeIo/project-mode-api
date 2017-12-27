defmodule PmApi.Repo.Migrations.AddColumnToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
      add :contact_info, :string
    end
  end
end
