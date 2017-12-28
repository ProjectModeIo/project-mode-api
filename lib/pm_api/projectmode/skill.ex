defmodule PmApi.Projectmode.Skill do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias PmApi.Projectmode.Skill


  schema "skills" do
    field :name, :string
    has_many :userskills, PmApi.Projectmode.Userskill
    has_many :projectskills, PmApi.Projectmode.Projectskill
    belongs_to :channel, PmApi.Projectmode.Channel

    timestamps()
  end

  @doc false
  def changeset(%Skill{} = skills, attrs) do
    skills
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> put_assoc(:channel, insert_channel(attrs[:name] || attrs["name"]))
  end

  defp insert_channel(name) do
    PmApi.Repo.insert!(%PmApi.Projectmode.Channel{name: name}, on_conflict: :nothing)
    PmApi.Repo.one!(from c in PmApi.Projectmode.Channel, where: c.name == ^name)
  end
end
