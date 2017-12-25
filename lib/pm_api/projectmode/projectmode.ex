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
    |> Repo.preload([:userroles, :userskills, :userinterests])
    # Repo.all from user in User,
    #   left_join: r in assoc(user, :roles),
    #   left_join: s in assoc(user, :skills),
    #   preload: [roles: r, skills: s]
    # Repo.all(User)
  end

  def get_user!(id) do
    user = Repo.get!(User, id)
    # |> Repo.preload([:roles, :skills])
    |> Repo.preload([:userroles, :userskills, :userinterests])
  end

  def get_user_by(paramsObj) do
    user = Repo.get_by(User, paramsObj)
    |> Repo.preload([:roles, :skills])
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

  def get_project!(id), do: Repo.get!(Project, id)

  def create_project(attrs \\ %{}) do
    %Project{}
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

  def list_userroles do
    userroles = Repo.all(Userrole)
    |> Repo.preload([:role])
  end

  def get_userrole!(id), do: Repo.get!(Userrole, id)

  def create_userrole(attrs \\ %{}) do
    %Userrole{}
    |> Userrole.changeset(attrs)
    |> Repo.insert()
  end

  def update_userrole(%Userrole{} = userrole, attrs) do
    userrole
    |> Userrole.changeset(attrs)
    |> Repo.update()
  end

  def delete_userrole(%Userrole{} = userrole) do
    Repo.delete(userrole)
  end

  def change_userrole(%Userrole{} = userrole) do
    Userrole.changeset(userrole, %{})
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

  def list_userskills do
    users = Repo.all(Userskill)
    |> Repo.preload([:skill])
  end

  def get_userskill!(id), do: Repo.get!(Userskill, id)

  def create_userskill(attrs \\ %{}) do
    %Userskill{}
    |> Userskill.changeset(attrs)
    |> Repo.insert()
  end

  def update_userskill(%Userskill{} = userskill, attrs) do
    userskill
    |> Userskill.changeset(attrs)
    |> Repo.update()
  end

  def delete_userskill(%Userskill{} = userskill) do
    Repo.delete(userskill)
  end

  def change_userskill(%Userskill{} = userskill) do
    Userskill.changeset(userskill, %{})
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

  def list_userinterests do
    userinterests = Repo.all(Userinterest)
    |> Repo.preload([:interest])
  end

  def get_userinterest!(id), do: Repo.get!(Userinterest, id)

  def create_userinterest(attrs \\ %{}) do
    %Userinterest{}
    |> Userinterest.changeset(attrs)
    |> Repo.insert()
  end

  def update_userinterest(%Userinterest{} = userinterest, attrs) do
    userinterest
    |> Userinterest.changeset(attrs)
    |> Repo.update()
  end

  def delete_userinterest(%Userinterest{} = userinterest) do
    Repo.delete(userinterest)
  end

  def change_userinterest(%Userinterest{} = userinterest) do
    Userinterest.changeset(userinterest, %{})
  end

  alias PmApi.Projectmode.Projectstack

  def list_projectstacks do
    Repo.all(Projectstack)
  end

  def get_projectstack!(id), do: Repo.get!(Projectstack, id)

  def create_projectstack(attrs \\ %{}) do
    %Projectstack{}
    |> Projectstack.changeset(attrs)
    |> Repo.insert()
  end

  def update_projectstack(%Projectstack{} = projectstack, attrs) do
    projectstack
    |> Projectstack.changeset(attrs)
    |> Repo.update()
  end

  def delete_projectstack(%Projectstack{} = projectstack) do
    Repo.delete(projectstack)
  end

  def change_projectstack(%Projectstack{} = projectstack) do
    Projectstack.changeset(projectstack, %{})
  end

  alias PmApi.Projectmode.Projectcategory

  def list_projectcategories do
    Repo.all(Projectcategory)
  end

  def get_projectcategory!(id), do: Repo.get!(Projectcategory, id)

  def create_projectcategory(attrs \\ %{}) do
    %Projectcategory{}
    |> Projectcategory.changeset(attrs)
    |> Repo.insert()
  end

  def update_projectcategory(%Projectcategory{} = projectcategory, attrs) do
    projectcategory
    |> Projectcategory.changeset(attrs)
    |> Repo.update()
  end

  def delete_projectcategory(%Projectcategory{} = projectcategory) do
    Repo.delete(projectcategory)
  end

  def change_projectcategory(%Projectcategory{} = projectcategory) do
    Projectcategory.changeset(projectcategory, %{})
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
end
