defmodule PmApi.Projectmode.Interest do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias PmApi.Projectmode.Interest


  schema "interests" do
    field :name, :string
    has_many :userinterests, PmApi.Projectmode.Userinterest
    has_many :projectinterests, PmApi.Projectmode.Projectinterest
    belongs_to :channel, PmApi.Projectmode.Channel
    timestamps()
  end

  @doc false
  def changeset(%Interest{} = interest, attrs) do
    interest
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> put_assoc(:channel, insert_channel(attrs[:name] || attrs["name"]))
  end

  defp insert_channel(name) do
    PmApi.Repo.insert!(%PmApi.Projectmode.Channel{name: name}, on_conflict: :nothing)
    PmApi.Repo.one!(from c in PmApi.Projectmode.Channel, where: c.name == ^name)
  end
end
