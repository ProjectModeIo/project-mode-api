defmodule PmApi.Projectmode.Projectstack do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Projectstack


  schema "projectstacks" do
    field :project_id, :id
    field :skill_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Projectstack{} = projectstack, attrs) do
    projectstack
    |> cast(attrs, [])
    |> validate_required([])
  end
end
