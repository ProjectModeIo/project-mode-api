defmodule PmApi.Github.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Github.Account


  schema "accounts" do
    field :commits_json, :string
    field :organizations_json, :string
    field :projects_json, :string
    field :totalcommits, :integer
    field :totalorganizations, :integer
    field :totalprojects, :integer
    belongs_to :user, PmApi.Projectmode.User

    timestamps()
  end

  @doc false
  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:projects_json, :commits_json, :organizations_json, :totalprojects, :totalcommits, :totalorganizations, :user_id])
    |> validate_required([:projects_json, :commits_json, :organizations_json, :totalprojects, :totalcommits, :totalorganizations, :user_id])
    |> unique_constraint(:user_id)
  end
end
