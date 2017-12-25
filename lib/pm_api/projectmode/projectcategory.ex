defmodule PmApi.Projectmode.Projectcategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Projectcategory


  schema "projectcategories" do
    field :project_id, :id
    field :interest_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Projectcategory{} = projectcategory, attrs) do
    projectcategory
    |> cast(attrs, [])
    |> validate_required([])
  end
end
