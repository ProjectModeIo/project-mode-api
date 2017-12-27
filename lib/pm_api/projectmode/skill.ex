defmodule PmApi.Projectmode.Skill do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Skill


  schema "skills" do
    field :name, :string
    has_many :userskills, PmApi.Projectmode.Userskill
    has_many :projectstacks, PmApi.Projectmode.Projectstack

    timestamps()
  end

  @doc false
  def changeset(%Skill{} = skills, attrs) do
    skills
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
