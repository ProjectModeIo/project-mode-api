defmodule PmApi.Repo.Migrations.AlterUserinterestsTable do
  use Ecto.Migration

  def change do
    alter table(:userinterests) do
      remove :user_id
      remove :interest_id
      add :user_id, references(:users, on_delete: :delete_all)
      add :interest_id, references(:interests, on_delete: :delete_all)
    end
  end
end
