defmodule PmApi.Projectmode.Role do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias PmApi.Projectmode.Role


  schema "roles" do
    field :name, :string
    has_many :userroles, PmApi.Projectmode.Userrole
    has_many :projectroles, PmApi.Projectmode.Projectrole
    belongs_to :channel, PmApi.Projectmode.Channel

    many_to_many :projects, PmApi.Projectmode.Project, join_through: PmApi.Projectmode.Projectrole
    many_to_many :users, PmApi.Projectmode.User, join_through: PmApi.Projectmode.Userrole

    timestamps()
  end

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_format(:name, ~r/^[a-zA-Z0-9 ]+$/)
    |> unique_constraint(:name)
    |> put_assoc(:channel, insert_channel(attrs[:name] || attrs["name"]))
  end

  defp insert_channel(name) do
    PmApi.Repo.insert!(%PmApi.Projectmode.Channel{name: name}, on_conflict: :nothing)
    PmApi.Repo.one!(from c in PmApi.Projectmode.Channel, where: c.name == ^name)
  end
end
