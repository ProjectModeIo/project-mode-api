defmodule PmApi.Projectmode.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Comment


  schema "comments" do
    field :body, :string
    field :parent_id, :id
    field :commenter_id, :id
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
