defmodule PmApi.Projectmode.Projectrole do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Projectrole


  schema "projectroles" do
    field :project_id, :id
    field :role_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Projectrole{} = projectrole, attrs) do
    projectrole
    |> cast(attrs, [])
    |> validate_required([])
  end
end
