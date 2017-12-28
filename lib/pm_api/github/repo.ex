defmodule PmApi.Github.Repo do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Github.Repo


  schema "repos" do
    field :commits_json, :string
    field :totalcommits, :integer
    field :repo_url, :string
    belongs_to :user, PmApi.Projectmode.Project

    timestamps()
  end

  @doc false
  def changeset(%Repo{} = repo, attrs) do
    repo
    |> cast(attrs, [:commits_json, :totalcommits, :project_id])
    |> validate_required([:commits_json, :totalcommits, :project_id])
    |> unique_constraint(:user_id)
  end
end
