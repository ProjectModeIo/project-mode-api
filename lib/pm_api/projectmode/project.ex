defmodule PmApi.Projectmode.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Project


  schema "projects" do
    field :description, :string
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
