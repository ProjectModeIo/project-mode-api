defmodule PmApi.Projectmode.Watchedproject do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Watchedproject


  schema "watchedprojects" do
    field :interestlevel, :integer
    # field :user_id, :id
    # field :project_id, :id
    belongs_to :project, PmApi.Projectmode.Project
    belongs_to :user, PmApi.Projectmode.User

    timestamps()
  end

  @doc false
  def changeset(%Watchedproject{} = watchedproject, attrs) do
    watchedproject
    |> cast(attrs, [:interestlevel, :user_id, :project_id])
    |> validate_required([:interestlevel, :user_id, :project_id])
    |> validate_inclusion(:interestlevel, -1..1)
  end
end
