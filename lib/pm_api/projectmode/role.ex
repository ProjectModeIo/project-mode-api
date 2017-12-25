defmodule PmApi.Projectmode.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Role


  schema "roles" do
    field :type, :string
    # many_to_many :users, PmApi.Projectmode.User, join_through: "userroles"

    timestamps()
  end

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:type])
    |> validate_required([:type])
    |> unique_constraint(:type)
  end
end
