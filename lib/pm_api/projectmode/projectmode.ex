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
    |> project_preloads()
    # |> Repo.preload([
    #   :user,
    #   watchedprojects: [ :user ],
    #   projectroles: [:role],
    #   projectskills: [:skill],
    #   projectinterests: [:interest],
    #   comments: [:user]])
  end

  def list_projects(query) do
    query
    |> Repo.all()
    |> project_preloads()
    # |> Repo.preload([
    #   :user,
    #   watchedprojects: [ :user ],
    #   projectroles: [:role],
    #   projectskills: [:skill],
    #   projectinterests: [:interest],
    #   comments: [:user]])
  end

  def get_project!(id) do
    project = Repo.get!(Project, id)
    |> Repo.preload([:user])
  end

  def get_project_by(params) do
    case Repo.get_by(Project, params) do
      %Project{} = project -> {:ok, project}
      _ -> {:error, :not_found}
    end
  end

  def get_project_by_slug(username, slug) do
    query = from p in Project,
      join: u in assoc(p, :user),
      where: p.slug == ^slug and u.username == ^username

    case Repo.one(query) |> Repo.preload([:user]) do
      %Project{} = project ->
        {:ok, project}
      _ ->
        {:error, :not_found}
    end
    #
    # project = Repo.get_by(Project, %{slug: slug})
    # |> Repo.preload([:user])
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

  def create_or_update_watchedproject(params_obj) do
    # IEx.pry
    case Repo.get_by(Watchedproject, %{project_id: params_obj["project_id"],user_id: params_obj["user_id"]}) do
      %Watchedproject{} = watchedproject ->
        update_watchedproject(watchedproject, params_obj)
      _ ->
        create_watchedproject(params_obj)
    end
  end

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

  def get_channel_by_slug(slug) do
    name = slug |> String.replace("-"," ")
    channel = Repo.get_by(Channel, %{name: name})
  end

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

  # PRELOADS
  def user_preloads(%User{} = user) do
    user |> Repo.preload([
      :account,
      watchedprojects: [
        project: [
          :user,
          watchedprojects: [ :user ],
          volunteers: [ user: [:skills] ],
          projectroles: [:role],
          projectskills: [:skill],
          projectinterests: [:interest],
          comments: [:user]
        ]
      ],
      projects: [
        :user,
        watchedprojects: [ :user ],
        volunteers: [ user: [:skills] ],
        projectroles: [:role],
        projectskills: [:skill],
        projectinterests: [:interest],
        comments: [:user]
      ],
      userroles: [:role],
      userinterests: [:interest],
      userskills: [:skill]
      ])
  end

  def project_preloads(query) do
    query |> Repo.preload([
      :user,
      watchedprojects: [:user],
      volunteers: [ user: [:skills] ],
      projectroles: [:role],
      projectskills: [:skill],
      projectinterests: [:interest],
      comments: [:user]
    ])
  end

  def channel_preloads(query) do
    query |> Repo.preload([
      role: [
        :users,
        projects: [
          :user,
          watchedprojects: [ :user ],
          volunteers: [ user: [:skills] ],
          projectroles: [:role],
          projectskills: [:skill],
          projectinterests: [:interest],
          comments: [:user],
        ]
      ],
      skill: [
        :users,
        projects: [
          :user,
          watchedprojects: [ :user ],
          volunteers: [ user: [:skills] ],
          projectroles: [:role],
          projectskills: [:skill],
          projectinterests: [:interest],
          comments: [:user]
        ]
      ],
      interest: [
        :users,
        projects: [
          :user,
          watchedprojects: [ :user ],
          volunteers: [ user: [:skills] ],
          projectroles: [:role],
          projectskills: [:skill],
          projectinterests: [:interest],
          comments: [:user]
        ]
      ],
    ])
  end

  def comment_preloads(%Comment{} = comment) do
    comment |> Repo.preload([:user])
  end

  alias PmApi.Chat.Notification
  #create notifications
  def create_notification(%Project{} = project, current_user) do
    # notifiy project's owner
  end

  def create_notification(%PmApi.Network.Volunteer{} = volunteer, current_user) do
    volunteer = volunteer |> Repo.preload([project: [:user]])
    create_notification(%{user_id: volunteer.project.user.id,
      message: volunteer.project.user.username <> " has volunteered for " <> volunteer.project.title,
      link: volunteer.project.slug
    }, current_user)
  end

  def create_notification(%Comment{} = comment, current_user) do
    # notifiy comment's parent user, if no parent, notify project owner
    comment = comment |> Repo.preload([:user, parent: [:user], project: [:user]])
    case {comment.parent, comment.project} do
      {%Comment{} = parent, _} ->
        create_notification(%{
          user_id: parent.user.id,
          message: comment.user.username <> " replied to our comment.",
          link: "something"
        }, current_user)
      {_, %Project{} = project} ->
        create_notification(%{
          user_id: project.user.id,
          message: comment.user.username <> " commented on " <> project.title,
          link: project.slug
        }, current_user)
    end
  end

  def create_notification(%{user_id: user_id, message: message, link: link}, current_user) do
    if user_id !== current_user.id do
      PmApi.Chat.create_notification(%{user_id: user_id, message: message, link: link})
    end
  end

  def delete_notifications(%User{} = user) do
    from(n in Notification, where: n.user_id == ^user.id) |> Repo.delete_all
  end
end
