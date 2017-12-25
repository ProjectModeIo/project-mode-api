defmodule PmApi.Projectmode.Watchedproject do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Watchedproject


  schema "watchedprojects" do
    field :interestlevel, :integer
    field :user_id, :id
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Watchedproject{} = watchedproject, attrs) do
    watchedproject
    |> cast(attrs, [:interestlevel])
    |> validate_required([:interestlevel])
  end
end
