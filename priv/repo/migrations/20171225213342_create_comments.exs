defmodule PmApi.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :parent_id, references(:comments, on_delete: :delete_all)
      add :commenter_id, references(:users, on_delete: :delete_all)
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:parent_id])
    create index(:comments, [:commenter_id])
    create index(:comments, [:project_id])
  end
end
