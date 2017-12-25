defmodule PmApi.Projectmode.Userskill do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Userskill


  schema "userskills" do
    # field :user_id, :id
    # field :skill_id, :id
    belongs_to :user, PmApi.Projectmode.User
    belongs_to :skill, PmApi.Projectmode.Skill

    timestamps()
  end

  @doc false
  def changeset(%Userskill{} = userskill, attrs) do
    userskill
    |> cast(attrs, [:user_id, :skill_id])
    |> validate_required([:user_id, :skill_id])
    |> unique_constraint(:user_id_skill_id)
  end
end
