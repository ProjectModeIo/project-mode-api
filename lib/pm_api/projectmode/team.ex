defmodule PmApi.Projectmode.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Team


  schema "teams" do
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Team{} = team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
