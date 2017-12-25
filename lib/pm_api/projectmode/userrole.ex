defmodule PmApi.Projectmode.Userrole do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Userrole


  schema "userroles" do
    # field :user_id, :id
    # field :role_id, :id
    belongs_to :user, PmApi.Projectmode.User
    belongs_to :role, PmApi.Projectmode.Role

    timestamps()
  end

  @doc false
  def changeset(%Userrole{} = userrole, attrs) do
    userrole
    |> cast(attrs, [:user_id, :role_id])
    |> validate_required([:user_id, :role_id])
    |> unique_constraint(:user_id_role_id)
  end
end
