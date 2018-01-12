defmodule PmApi.Network.Volunteer do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Network.Volunteer


  schema "volunteers" do
    belongs_to :user, PmApi.Projectmode.User
    belongs_to :project, PmApi.Projectmode.Project
    timestamps()
  end

  @doc false
  def changeset(%Volunteer{} = volunteer, attrs) do
    volunteer
    |> cast(attrs, [:user_id, :project_id])
    |> validate_required([:user_id, :project_id])
    |> unique_constraint(:user_id_project_id)
  end
end
