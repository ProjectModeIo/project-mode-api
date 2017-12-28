require IEx
defmodule PmApi.Projectmode.Projectrole do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Projectrole


  schema "projectroles" do
    # field :project_id, :id
    # field :role_id, :id
    field :name, :string, virtual: true
    belongs_to :project, PmApi.Projectmode.Project
    belongs_to :role, PmApi.Projectmode.Role
    timestamps()
  end

  @doc false

  def changeset(%Projectrole{} = projectrole, attrs) do
    projectrole
    |> cast(attrs, [:project_id, :role_id, :name])
    |> validate_required([:project_id, :role_id])
    |> unique_constraint(:project_id_role_id)
  end
end
