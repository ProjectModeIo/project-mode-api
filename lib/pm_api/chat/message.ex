defmodule PmApi.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Chat.Message


  schema "messages" do
    field :text, :string
    belongs_to :channel, PmApi.Projectmode.Channel
    belongs_to :team, PmApi.Projectmode.Team
    belongs_to :user, PmApi.Projectmode.User

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:text, :user_id, :team_id, :channel_id])
    |> validate_required([:text, :user_id])
  end
end
