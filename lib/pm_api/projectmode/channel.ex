defmodule PmApi.Projectmode.Channel do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Channel


  schema "channels" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Channel{} = channel, attrs) do
    channel
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
