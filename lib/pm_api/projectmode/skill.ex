defmodule PmApi.Projectmode.Skill do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Skill


  schema "skills" do
    field :name, :string
    # many_to_many :users, PmApi.Projectmode.User, join_through: "userskills"

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
