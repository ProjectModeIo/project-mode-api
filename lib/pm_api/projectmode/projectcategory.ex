defmodule PmApi.Projectmode.Projectcategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Projectcategory


  schema "projectcategories" do
    # field :project_id, :id
    # field :interest_id, :id
    belongs_to :project, PmApi.Projectmode.Project
    belongs_to :interest, PmApi.Projectmode.Interest
    timestamps()
  end

  @doc false
  def changeset(%Projectcategory{} = projectcategory, attrs) do
    projectcategory
    |> cast(attrs, [:project_id, :interest_id])
    |> validate_required([:project_id, :interest_id])
    |> unique_constraint(:project_id_interest_id)
  end
end
