defmodule PmApi.Projectmode.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Project


  schema "projects" do
    field :description, :string
    field :title, :string
    field :slug, :string
    # field :user_id, :id

    belongs_to :user, PmApi.Projectmode.User, foreign_key: :user_id
    has_many :projectroles, PmApi.Projectmode.Projectrole
    has_many :projectstacks, PmApi.Projectmode.Projectstack
    has_many :projectcategories, PmApi.Projectmode.Projectcategory

    has_many :comments, PmApi.Projectmode.Comment
    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:title, :description, :user_id])
    |> validate_required([:title, :description, :user_id])
    |> validate_exclusion(:title, ~w(profile edit dashboard))
    |> create_slug_from_title()
    |> unique_constraint(:user_id_slug)
  end

  def create_slug_from_title(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{title: title}} ->
        #clean non-alpha-numeric
        slug = Regex.replace(~r/[^a-zA-Z0-9-_ ]/, title, "", global: true)
        |> String.replace(" ","-")
        |> String.downcase()
        put_change(changeset, :slug, slug)
      _ ->
        changeset
    end
  end
end
