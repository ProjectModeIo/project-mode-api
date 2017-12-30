defmodule PmApi.Projectmode.Channel do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Channel


  schema "channels" do
    field :name, :string
    has_many :messages, PmApi.Chat.Message
    has_one :role, PmApi.Projectmode.Role
    has_one :skill, PmApi.Projectmode.Skill
    has_one :interest, PmApi.Projectmode.Interest

    timestamps()
  end

  @doc false
  def changeset(%Channel{} = channel, attrs) do
    channel
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
