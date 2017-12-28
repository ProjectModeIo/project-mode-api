defmodule PmApi.Projectmode.Project do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias PmApi.Projectmode.Project


  schema "projects" do
    field :description, :string
    field :title, :string
    field :slug, :string
    field :project_scope, :string
    field :repositories, :string
    field :active, :boolean
    # field :user_id, :id

    belongs_to :user, PmApi.Projectmode.User
    has_many :projectroles, PmApi.Projectmode.Projectrole
    has_many :projectskills, PmApi.Projectmode.Projectskill
    has_many :projectinterests, PmApi.Projectmode.Projectinterest
    many_to_many :roles, PmApi.Projectmode.Role, join_through: PmApi.Projectmode.Projectrole
    many_to_many :skills, PmApi.Projectmode.Skill, join_through: PmApi.Projectmode.Projectskill
    many_to_many :interests, PmApi.Projectmode.Interest, join_through: PmApi.Projectmode.Projectinterest

    has_many :comments, PmApi.Projectmode.Comment
    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:title, :description, :user_id, :project_scope, :repositories, :active])
    |> validate_required([:title, :description, :user_id])
    |> validate_inclusion(:project_scope, ["passion project","experiment","business opportunity","just for fun","learning opportunity"])
    |> validate_exclusion(:title, ["profile","edit","new","delete","dashboard"])
    |> create_slug_from_title()
    |> unique_constraint(:user_id_slug)
    |> unique_constraint(:user_id_title)
    |> put_assoc(:roles, parse_list(attrs[:roles] || attrs["roles"], PmApi.Projectmode.Role))
    |> put_assoc(:skills, parse_list(attrs[:skills] || attrs["skills"], PmApi.Projectmode.Skill))
    |> put_assoc(:interests, parse_list(attrs[:interests] || attrs["interests"], PmApi.Projectmode.Interest))
  end

  defp parse_list(attrs, schema) do
    (attrs || [])
    |> Enum.map(&(%{name: (&1[:name] || &1["name"])}))
    |> insert_and_get_all(schema)
  end

  defp insert_and_get_all([], _), do: []

  defp insert_and_get_all(objs, schema) do
    roles = Enum.map(objs, &(&1[:name]))
    objs = objs |> Enum.map(fn(row) -> row |> Map.put(:inserted_at, DateTime.utc_now) |> Map.put(:updated_at, DateTime.utc_now) end)
    PmApi.Repo.insert_all(schema, objs, on_conflict: :nothing)
    PmApi.Repo.all(from r in schema, where: r.name in ^roles)
  end

  def create_slug_from_title(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{title: title}} ->
        #clean non-alpha-numeric
        slug = Regex.replace(~r/[^A-z0-9-_ ]/, title, "", global: true)
        |> String.replace(" ","-")
        |> String.downcase()
        put_change(changeset, :slug, slug)
      _ ->
        changeset
    end
  end

  def filter_by(query, {:role_match, %PmApi.Projectmode.User{}=user}) do
    # query = Project schema
    from p in query,
      inner_join: pr in assoc(p, :projectroles),
      inner_join: r in assoc(pr, :role),
      inner_join: ur in assoc(r, :userroles),
      inner_join: u in assoc(ur, :user),
      where: u.id == ^user.id
  end

  def filter_by(query, {:skill_match, %PmApi.Projectmode.User{}=user}) do
    # query = Project schema
    from p in query,
      inner_join: pr in assoc(p, :projectskills),
      inner_join: r in assoc(pr, :skill),
      inner_join: ur in assoc(r, :userskills),
      inner_join: u in assoc(ur, :user),
      where: u.id == ^user.id
  end

  def filter_by(query, {:interest_match, %PmApi.Projectmode.User{}=user}) do
    # query = Project schema
    from p in query,
      inner_join: pr in assoc(p, :projectinterests),
      inner_join: r in assoc(pr, :interest),
      inner_join: ur in assoc(r, :userinterests),
      inner_join: u in assoc(ur, :user),
      where: u.id == ^user.id
  end
end
