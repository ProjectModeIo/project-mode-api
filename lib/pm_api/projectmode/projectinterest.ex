defmodule PmApi.Projectmode.Projectinterest do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Projectinterest


  schema "projectinterests" do
    # field :project_id, :id
    # field :interest_id, :id
    field :name, :string, virtual: true
    belongs_to :project, PmApi.Projectmode.Project
    belongs_to :interest, PmApi.Projectmode.Interest
    timestamps()
  end

  @doc false
  def changeset(%Projectinterest{} = projectinterest, attrs) do
    projectinterest
    |> cast(attrs, [:project_id, :interest_id, :name])
    |> validate_required([:project_id, :interest_id])
    |> unique_constraint(:project_id_interest_id)
  end
end
