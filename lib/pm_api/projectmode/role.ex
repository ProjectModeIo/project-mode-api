defmodule PmApi.Projectmode.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Role


  schema "roles" do
    field :name, :string
    has_many :userroles, PmApi.Projectmode.Userrole
    has_many :projectroles, PmApi.Projectmode.Projectrole
    # many_to_many :users, PmApi.Projectmode.User, join_through: "userroles"

    timestamps()
  end

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
