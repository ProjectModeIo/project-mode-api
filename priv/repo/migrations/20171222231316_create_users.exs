defmodule PmApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password, :string
      add :firstname, :string
      add :lastname, :string
      add :tagline, :string

      timestamps()
    end

  end
end
