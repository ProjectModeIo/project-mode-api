defmodule PmApi.Repo.Migrations.AddColumnToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :contact_info, :string
    end
  end
end
