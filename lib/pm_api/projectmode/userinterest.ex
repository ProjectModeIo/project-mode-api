defmodule PmApi.Projectmode.Userinterest do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.Userinterest


  schema "userinterests" do
    # field :user_id, :id
    # field :interest_id, :id
    belongs_to :user, PmApi.Projectmode.User
    belongs_to :interest, PmApi.Projectmode.Interest

    timestamps()
  end

  @doc false
  def changeset(%Userinterest{} = userinterest, attrs) do
    userinterest
    |> cast(attrs, [:user_id, :interest_id])
    |> validate_required([:user_id, :interest_id])
    |> unique_constraint(:user_id_interest_id)
  end
end
