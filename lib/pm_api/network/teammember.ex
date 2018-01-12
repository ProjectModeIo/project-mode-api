defmodule PmApi.Network.Teammember do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Network.Teammember


  schema "teammembers" do
    belongs_to :user, PmApi.Projectmode.User
    belongs_to :team, PmApi.Network.Team
    field :membership, :string
    timestamps()
  end

  @doc false
  def changeset(%Teammember{} = teammember, attrs) do
    teammember
    |> cast(attrs, [:membership])
    |> validate_required([:membership])
    |> validate_inclusion(:membership, ["admin","member","blocked"])

  end
end
