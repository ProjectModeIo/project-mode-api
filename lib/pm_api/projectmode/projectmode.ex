require IEx
defmodule PmApi.Projectmode do
  @moduledoc """
  The Projectmode context.

  iex> list_teams()
    [%Team{}, ...]

  iex> get_team!(123)
    ok:   %Team{}
    err:  ** (Ecto.NoResultsError)

  iex> create_team(%{field: value})
    ok:   {:ok, %Team{}}
    err:  {:error, %Ecto.Changeset{}}

  iex> update_team(team, %{field: new_value})
    ok:   {:ok, %Team{}}
    err:  {:error, %Ecto.Changeset{}}

  iex> delete_team(team)
    ok:   {:ok, %Team{}}
    err:  {:error, %Ecto.Changeset{}}

  iex> change_team(team)
    %Ecto.Changeset{source: %Team{}}
  """

  import Ecto.Query, warn: false
  alias PmApi.Repo
  alias PmApi.Projectmode
  alias PmApi.Projectmode.User

  def list_users do
    users = Repo.all(User)
    # |> Repo.preload([:userroles, :userskills, :userinterests])
  end

  def get_user!(id) do
    user = Repo.get!(User, id)
    # |> Repo.preload([:roles, :skills])
    # |> Repo.preload([:userroles, :userskills, :userinterests])
  end

  def get_user_by(paramsObj) do
    user = Repo.get_by(User, paramsObj)
    # |> Repo.preload([:userroles, :userskills, :userinterests])
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias PmApi.Projectmode.Project

  def list_projects do
    Repo.all(Project)
  end

  def get_project!(id) do
    project = Repo.get!(Project, id)
    |> Repo.preload([:user])
  end

  def get_project_by_slug(slug) do
    project = Repo.get_by(Project, %{slug: slug})
    |> Repo.preload([:user])
  end

  def verify_project_owner(%Project{} = project, %User{} = user) do
    to_string(project.user.id) == to_string(user.id)
  end

  def create_project(attrs \\ %{}) do
    project = %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  def change_project(%Project{} = project) do
    Project.changeset(project, %{})
  end

  alias PmApi.Projectmode.Team

  def list_teams do
    Repo.all(Team)
  end

  def get_team!(id), do: Repo.get!(Team, id)

  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  def change_team(%Team{} = team) do
    Team.changeset(team, %{})
  end

  alias PmApi.Projectmode.Teammember

  def list_teammembers do
    Repo.all(Teammember)
  end

  def get_teammember!(id), do: Repo.get!(Teammember, id)

  def create_teammember(attrs \\ %{}) do
    %Teammember{}
    |> Teammember.changeset(attrs)
    |> Repo.insert()
  end

  def update_teammember(%Teammember{} = teammember, attrs) do
    teammember
    |> Teammember.changeset(attrs)
    |> Repo.update()
  end

  def delete_teammember(%Teammember{} = teammember) do
    Repo.delete(teammember)
  end

  def change_teammember(%Teammember{} = teammember) do
    Teammember.changeset(teammember, %{})
  end

  alias PmApi.Projectmode.Teamproject

  def list_teamprojects do
    Repo.all(Teamproject)
  end

  def get_teamproject!(id), do: Repo.get!(Teamproject, id)

  def create_teamproject(attrs \\ %{}) do
    %Teamproject{}
    |> Teamproject.changeset(attrs)
    |> Repo.insert()
  end

  def update_teamproject(%Teamproject{} = teamproject, attrs) do
    teamproject
    |> Teamproject.changeset(attrs)
    |> Repo.update()
  end

  def delete_teamproject(%Teamproject{} = teamproject) do
    Repo.delete(teamproject)
  end

  def change_teamproject(%Teamproject{} = teamproject) do
    Teamproject.changeset(teamproject, %{})
  end

  alias PmApi.Projectmode.Role

  def find_or_create_role_by(params_obj) do
    case Repo.get_by(Role, params_obj) do
      %Role{} = role -> {:ok, role}
      _ -> create_role(params_obj)
    end
  end

  def list_roles do
    Repo.all(Role)
  end

  def get_role!(id), do: Repo.get!(Role, id)

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  def change_role(%Role{} = role) do
    Role.changeset(role, %{})
  end

  alias PmApi.Projectmode.Userrole

  def get_userrole!(id), do: Repo.get!(Userrole, id)

  def create_userrole(attrs \\ %{}) do
    %Userrole{}
    |> Userrole.changeset(attrs)
    |> Repo.insert()
  end

  def delete_userrole(%Userrole{} = userrole) do
    Repo.delete(userrole)
  end

  alias PmApi.Projectmode.Skill

  def find_or_create_skill_by(params_obj) do
    case Repo.get_by(Skill, params_obj) do
      %Skill{} = skill -> {:ok, skill}
      _ -> create_skill(params_obj)
    end
  end

  def list_skills do
    Repo.all(Skill)
  end

  def get_skill!(id), do: Repo.get!(Skill, id)

  def create_skill(attrs \\ %{}) do
    %Skill{}
    |> Skill.changeset(attrs)
    |> Repo.insert()
  end

  def update_skill(%Skill{} = skill, attrs) do
    skill
    |> Skill.changeset(attrs)
    |> Repo.update()
  end

  def delete_skill(%Skill{} = skill) do
    Repo.delete(skill)
  end

  def change_skill(%Skill{} = skill) do
    Skill.changeset(skill, %{})
  end

  alias PmApi.Projectmode.Projectrole

  def list_projectroles do
    Repo.all(Projectrole)
  end

  def get_projectrole!(id), do: Repo.get!(Projectrole, id)

  def create_projectrole(attrs \\ %{}) do
    %Projectrole{}
    |> Projectrole.changeset(attrs)
    |> Repo.insert()
  end

  def update_projectrole(%Projectrole{} = projectrole, attrs) do
    projectrole
    |> Projectrole.changeset(attrs)
    |> Repo.update()
  end

  def delete_projectrole(%Projectrole{} = projectrole) do
    Repo.delete(projectrole)
  end

  def change_projectrole(%Projectrole{} = projectrole) do
    Projectrole.changeset(projectrole, %{})
  end

  alias PmApi.Projectmode.Userskill

  def get_userskill!(id), do: Repo.get!(Userskill, id)

  def create_userskill(attrs \\ %{}) do
    %Userskill{}
    |> Userskill.changeset(attrs)
    |> Repo.insert()
  end

  def delete_userskill(%Userskill{} = userskill) do
    Repo.delete(userskill)
  end

  alias PmApi.Projectmode.Interest

  def find_or_create_interest_by(params_obj) do
    case Repo.get_by(Interest, params_obj) do
      %Interest{} = interest -> {:ok, interest}
      _ -> create_interest(params_obj)
    end
  end

  def list_interests do
    Repo.all(Interest)
  end

  def get_interest!(id), do: Repo.get!(Interest, id)

  def create_interest(attrs \\ %{}) do
    %Interest{}
    |> Interest.changeset(attrs)
    |> Repo.insert()
  end

  def update_interest(%Interest{} = interest, attrs) do
    interest
    |> Interest.changeset(attrs)
    |> Repo.update()
  end

  def delete_interest(%Interest{} = interest) do
    Repo.delete(interest)
  end

  def change_interest(%Interest{} = interest) do
    Interest.changeset(interest, %{})
  end

  alias PmApi.Projectmode.Userinterest

  def get_userinterest!(id), do: Repo.get!(Userinterest, id)

  def create_userinterest(attrs \\ %{}) do
    %Userinterest{}
    |> Userinterest.changeset(attrs)
    |> Repo.insert()
  end

  def delete_userinterest(%Userinterest{} = userinterest) do
    Repo.delete(userinterest)
  end

  alias PmApi.Projectmode.Projectskill

  def list_projectskills do
    Repo.all(Projectskill)
  end

  def get_projectskill!(id), do: Repo.get!(Projectskill, id)

  def create_projectskill(attrs \\ %{}) do
    %Projectskill{}
    |> Projectskill.changeset(attrs)
    |> Repo.insert()
  end

  def update_projectskill(%Projectskill{} = projectskill, attrs) do
    projectskill
    |> Projectskill.changeset(attrs)
    |> Repo.update()
  end

  def delete_projectskill(%Projectskill{} = projectskill) do
    Repo.delete(projectskill)
  end

  def change_projectskill(%Projectskill{} = projectskill) do
    Projectskill.changeset(projectskill, %{})
  end

  alias PmApi.Projectmode.Projectinterest

  def list_projectinterests do
    Repo.all(Projectinterest)
  end

  def get_projectinterest!(id), do: Repo.get!(Projectinterest, id)

  def create_projectinterest(attrs \\ %{}) do
    %Projectinterest{}
    |> Projectinterest.changeset(attrs)
    |> Repo.insert()
  end

  def update_projectinterest(%Projectinterest{} = projectinterest, attrs) do
    projectinterest
    |> Projectinterest.changeset(attrs)
    |> Repo.update()
  end

  def delete_projectinterest(%Projectinterest{} = projectinterest) do
    Repo.delete(projectinterest)
  end

  def change_projectinterest(%Projectinterest{} = projectinterest) do
    Projectinterest.changeset(projectinterest, %{})
  end

  alias PmApi.Projectmode.Watchedproject

  def list_watchedprojects do
    Repo.all(Watchedproject)
  end

  def get_watchedproject!(id), do: Repo.get!(Watchedproject, id)

  def create_watchedproject(attrs \\ %{}) do
    %Watchedproject{}
    |> Watchedproject.changeset(attrs)
    |> Repo.insert()
  end

  def update_watchedproject(%Watchedproject{} = watchedproject, attrs) do
    watchedproject
    |> Watchedproject.changeset(attrs)
    |> Repo.update()
  end

  def delete_watchedproject(%Watchedproject{} = watchedproject) do
    Repo.delete(watchedproject)
  end

  def change_watchedproject(%Watchedproject{} = watchedproject) do
    Watchedproject.changeset(watchedproject, %{})
  end

  alias PmApi.Projectmode.Comment

  def list_comments do
    Repo.all(Comment)
  end

  def get_comment!(id), do: Repo.get!(Comment, id)

  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end

  # channels ?
  def list_channels do
    
  end

  alias PmApi.Projectmode.Channel

  @doc """
  Returns the list of channels.

  ## Examples

      iex> list_channels()
      [%Channel{}, ...]

  """
  def list_channels do
    Repo.all(Channel)
  end

  @doc """
  Gets a single channel.

  Raises `Ecto.NoResultsError` if the Channel does not exist.

  ## Examples

      iex> get_channel!(123)
      %Channel{}

      iex> get_channel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_channel!(id), do: Repo.get!(Channel, id)

  @doc """
  Creates a channel.

  ## Examples

      iex> create_channel(%{field: value})
      {:ok, %Channel{}}

      iex> create_channel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_channel(attrs \\ %{}) do
    %Channel{}
    |> Channel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a channel.

  ## Examples

      iex> update_channel(channel, %{field: new_value})
      {:ok, %Channel{}}

      iex> update_channel(channel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_channel(%Channel{} = channel, attrs) do
    channel
    |> Channel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Channel.

  ## Examples

      iex> delete_channel(channel)
      {:ok, %Channel{}}

      iex> delete_channel(channel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_channel(%Channel{} = channel) do
    Repo.delete(channel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking channel changes.

  ## Examples

      iex> change_channel(channel)
      %Ecto.Changeset{source: %Channel{}}

  """
  def change_channel(%Channel{} = channel) do
    Channel.changeset(channel, %{})
  end
end
