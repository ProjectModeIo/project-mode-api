defmodule PmApi.Projectmode.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmApi.Projectmode.User


  schema "users" do
    field :email, :string
    field :username, :string
    field :firstname, :string
    field :lastname, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :tagline, :string
    has_many :userroles, PmApi.Projectmode.Userrole
    has_many :userskills, PmApi.Projectmode.Userskill
    has_many :userinterests, PmApi.Projectmode.Userinterest

    has_many :projects, PmApi.Projectmode.Project
    has_many :comments, PmApi.Projectmode.Comment
    # many_to_many :roles, PmApi.Projectmode.Role, join_through: "userroles"
    # many_to_many :skills, PmApi.Projectmode.Skill, join_through: "userskills"

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :firstname, :lastname, :tagline, :username])
    |> validate_required([:email, :firstname, :lastname, :username])
    |> validate_format(:username, ~r/^[a-zA-Z0-9-_]+$/)
    |> validate_exclusion(:username, ~w(admin superadmin project projects))
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
