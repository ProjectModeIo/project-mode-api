require IEx
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
    field :contact_info, :string
    has_one :account, PmApi.Github.Account
    has_many :userroles, PmApi.Projectmode.Userrole
    has_many :userskills, PmApi.Projectmode.Userskill
    has_many :userinterests, PmApi.Projectmode.Userinterest

    has_many :projects, PmApi.Projectmode.Project
    has_many :comments, PmApi.Projectmode.Comment
    has_many :watchedprojects, PmApi.Projectmode.Watchedproject

    has_many :notifications, PmApi.Chat.Notification

    many_to_many :teams, PmApi.Network.Team, join_through: PmApi.Network.Teammember
    many_to_many :roles, PmApi.Projectmode.Role, join_through: PmApi.Projectmode.Userrole
    many_to_many :skills, PmApi.Projectmode.Skill, join_through: PmApi.Projectmode.Userskill
    many_to_many :interests, PmApi.Projectmode.Interest, join_through: PmApi.Projectmode.Userinterest

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :firstname, :lastname, :tagline])
    |> validate_required([:email])
    |> validate_username(attrs)
    |> unique_constraint(:email)
  end

  def validate_username(struct, params) do
    struct
    |> cast(params, [:username])
    |> validate_format(:username, ~r/^[a-zA-Z0-9-_]+$/)
    |> validate_exclusion(:username, ['profile','edit','new','delete','dashboard','admin','superadmin'])
    |> validate_length(:username, min: 4, max: 25)
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
