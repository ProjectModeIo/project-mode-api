defmodule PmApi.Projectmode.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias PmApi.Projectmode.Comment


  schema "comments" do
    field :body, :string
    # field :parent_id, :id
    # field :commenter_id, :id
    # field :project_id, :id
    belongs_to :user, PmApi.Projectmode.User, foreign_key: :commenter_id
    belongs_to :project, PmApi.Projectmode.Project
    belongs_to :parent, PmApi.Projectmode.Comment, foreign_key: :parent_id
    has_many :replies, PmApi.Projectmode.Comment, foreign_key: :parent_id

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:body, :parent_id, :commenter_id, :project_id])
    |> validate_required([:body, :commenter_id, :project_id])
  end

  def project_top_comments(query, post) do
    # query = Comment model
    from c in query,
      left_join: p in assoc(c, :project),
      where: p.id == ^post.id,
      where: is_nil(c.parent_id)
  end
end
