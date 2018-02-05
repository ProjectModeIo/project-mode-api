defmodule PmApi.Repo.Migrations.AddAvatarUrlToProfileAccount do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :avatar_url, :string
    end
  end
end
