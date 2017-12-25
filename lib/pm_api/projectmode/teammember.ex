defmodule PmApi.Projectmode.Teammember do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Teammember


  schema "teammembers" do
    field :team_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Teammember{} = teammember, attrs) do
    teammember
    |> cast(attrs, [])
    |> validate_required([])
  end
end
