defmodule PmApi.Chat.Notification do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Chat.Notification


  schema "notifications" do
    field :link, :string
    field :message, :string
    field :read_at, :naive_datetime
    field :seen, :boolean, default: false

    belongs_to :user, PmApi.Projectmode.User

    timestamps()
  end

  @doc false
  def changeset(%Notification{} = notification, attrs) do
    notification
    |> cast(attrs, [:message, :seen, :read_at, :link, :user_id])
    |> validate_required([:message, :user_id])
  end
end
