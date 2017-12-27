defmodule PmApi.Repo.Migrations.AddColumnToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :repositories, :string
    end
  end
end
