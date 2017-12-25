defmodule PmApi.Projectmode.Teamproject do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Teamproject


  schema "teamprojects" do
    field :team_id, :id
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Teamproject{} = teamproject, attrs) do
    teamproject
    |> cast(attrs, [])
    |> validate_required([])
  end
end
