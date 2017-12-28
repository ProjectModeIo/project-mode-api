defmodule PmApi.Projectmode.Projectskill do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Projectskill


  schema "projectskills" do
    # field :project_id, :id
    # field :skill_id, :id
    belongs_to :project, PmApi.Projectmode.Project
    belongs_to :skill, PmApi.Projectmode.Skill
    timestamps()
  end

  @doc false
  def changeset(%Projectskill{} = projectskill, attrs) do
    projectskill
    |> cast(attrs, [:project_id, :skill_id])
    |> validate_required([:project_id, :skill_id])
    |> unique_constraint(:project_id_skill_id)
  end
end
