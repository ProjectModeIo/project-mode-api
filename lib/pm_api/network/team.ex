defmodule PmApi.Network.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Network.Team


  schema "teams" do
    field :name, :string
    has_many :projects, PmApi.Projectmode.Project
    many_to_many :users, PmApi.Projectmode.User, join_through: PmApi.Network.Teammember

    timestamps()
  end

  @doc false
  def changeset(%Team{} = team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
