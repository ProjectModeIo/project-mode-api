defmodule PmApi.ProjectmodeTest do
  use PmApi.DataCase

  alias PmApi.Projectmode

  describe "users" do
    alias PmApi.Projectmode.User

    @valid_attrs %{email: "some email", firstname: "some firstname", lastname: "some lastname", password: "some password", tagline: "some tagline"}
    @update_attrs %{email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname", password: "some updated password", tagline: "some updated tagline"}
    @invalid_attrs %{email: nil, firstname: nil, lastname: nil, password: nil, tagline: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Projectmode.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Projectmode.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Projectmode.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.password == "some password"
      assert user.tagline == "some tagline"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Projectmode.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.password == "some updated password"
      assert user.tagline == "some updated tagline"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_user(user, @invalid_attrs)
      assert user == Projectmode.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Projectmode.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_user(user)
    end
  end

  describe "projects" do
    alias PmApi.Projectmode.Project

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Projectmode.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projectmode.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Projectmode.create_project(@valid_attrs)
      assert project.description == "some description"
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, project} = Projectmode.update_project(project, @update_attrs)
      assert %Project{} = project
      assert project.description == "some updated description"
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_project(project, @invalid_attrs)
      assert project == Projectmode.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projectmode.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_project(project)
    end
  end

  describe "teams" do
    alias PmApi.Projectmode.Team

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Projectmode.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Projectmode.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = Projectmode.create_team(@valid_attrs)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, team} = Projectmode.update_team(team, @update_attrs)
      assert %Team{} = team
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_team(team, @invalid_attrs)
      assert team == Projectmode.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Projectmode.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_team(team)
    end
  end

  describe "teammembers" do
    alias PmApi.Projectmode.Teammember

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def teammember_fixture(attrs \\ %{}) do
      {:ok, teammember} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_teammember()

      teammember
    end

    test "list_teammembers/0 returns all teammembers" do
      teammember = teammember_fixture()
      assert Projectmode.list_teammembers() == [teammember]
    end

    test "get_teammember!/1 returns the teammember with given id" do
      teammember = teammember_fixture()
      assert Projectmode.get_teammember!(teammember.id) == teammember
    end

    test "create_teammember/1 with valid data creates a teammember" do
      assert {:ok, %Teammember{} = teammember} = Projectmode.create_teammember(@valid_attrs)
    end

    test "create_teammember/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_teammember(@invalid_attrs)
    end

    test "update_teammember/2 with valid data updates the teammember" do
      teammember = teammember_fixture()
      assert {:ok, teammember} = Projectmode.update_teammember(teammember, @update_attrs)
      assert %Teammember{} = teammember
    end

    test "update_teammember/2 with invalid data returns error changeset" do
      teammember = teammember_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_teammember(teammember, @invalid_attrs)
      assert teammember == Projectmode.get_teammember!(teammember.id)
    end

    test "delete_teammember/1 deletes the teammember" do
      teammember = teammember_fixture()
      assert {:ok, %Teammember{}} = Projectmode.delete_teammember(teammember)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_teammember!(teammember.id) end
    end

    test "change_teammember/1 returns a teammember changeset" do
      teammember = teammember_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_teammember(teammember)
    end
  end

  describe "teamprojects" do
    alias PmApi.Projectmode.Teamproject

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def teamproject_fixture(attrs \\ %{}) do
      {:ok, teamproject} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_teamproject()

      teamproject
    end

    test "list_teamprojects/0 returns all teamprojects" do
      teamproject = teamproject_fixture()
      assert Projectmode.list_teamprojects() == [teamproject]
    end

    test "get_teamproject!/1 returns the teamproject with given id" do
      teamproject = teamproject_fixture()
      assert Projectmode.get_teamproject!(teamproject.id) == teamproject
    end

    test "create_teamproject/1 with valid data creates a teamproject" do
      assert {:ok, %Teamproject{} = teamproject} = Projectmode.create_teamproject(@valid_attrs)
    end

    test "create_teamproject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_teamproject(@invalid_attrs)
    end

    test "update_teamproject/2 with valid data updates the teamproject" do
      teamproject = teamproject_fixture()
      assert {:ok, teamproject} = Projectmode.update_teamproject(teamproject, @update_attrs)
      assert %Teamproject{} = teamproject
    end

    test "update_teamproject/2 with invalid data returns error changeset" do
      teamproject = teamproject_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_teamproject(teamproject, @invalid_attrs)
      assert teamproject == Projectmode.get_teamproject!(teamproject.id)
    end

    test "delete_teamproject/1 deletes the teamproject" do
      teamproject = teamproject_fixture()
      assert {:ok, %Teamproject{}} = Projectmode.delete_teamproject(teamproject)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_teamproject!(teamproject.id) end
    end

    test "change_teamproject/1 returns a teamproject changeset" do
      teamproject = teamproject_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_teamproject(teamproject)
    end
  end

  describe "roles" do
    alias PmApi.Projectmode.Role

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Projectmode.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Projectmode.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Projectmode.create_role(@valid_attrs)
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, role} = Projectmode.update_role(role, @update_attrs)
      assert %Role{} = role
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_role(role, @invalid_attrs)
      assert role == Projectmode.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Projectmode.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_role(role)
    end
  end

  describe "userroles" do
    alias PmApi.Projectmode.Userrole

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def userrole_fixture(attrs \\ %{}) do
      {:ok, userrole} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_userrole()

      userrole
    end

    test "list_userroles/0 returns all userroles" do
      userrole = userrole_fixture()
      assert Projectmode.list_userroles() == [userrole]
    end

    test "get_userrole!/1 returns the userrole with given id" do
      userrole = userrole_fixture()
      assert Projectmode.get_userrole!(userrole.id) == userrole
    end

    test "create_userrole/1 with valid data creates a userrole" do
      assert {:ok, %Userrole{} = userrole} = Projectmode.create_userrole(@valid_attrs)
    end

    test "create_userrole/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_userrole(@invalid_attrs)
    end

    test "update_userrole/2 with valid data updates the userrole" do
      userrole = userrole_fixture()
      assert {:ok, userrole} = Projectmode.update_userrole(userrole, @update_attrs)
      assert %Userrole{} = userrole
    end

    test "update_userrole/2 with invalid data returns error changeset" do
      userrole = userrole_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_userrole(userrole, @invalid_attrs)
      assert userrole == Projectmode.get_userrole!(userrole.id)
    end

    test "delete_userrole/1 deletes the userrole" do
      userrole = userrole_fixture()
      assert {:ok, %Userrole{}} = Projectmode.delete_userrole(userrole)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_userrole!(userrole.id) end
    end

    test "change_userrole/1 returns a userrole changeset" do
      userrole = userrole_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_userrole(userrole)
    end
  end

  describe "skills" do
    alias PmApi.Projectmode.Skills

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def skills_fixture(attrs \\ %{}) do
      {:ok, skills} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_skills()

      skills
    end

    test "list_skills/0 returns all skills" do
      skills = skills_fixture()
      assert Projectmode.list_skills() == [skills]
    end

    test "get_skills!/1 returns the skills with given id" do
      skills = skills_fixture()
      assert Projectmode.get_skills!(skills.id) == skills
    end

    test "create_skills/1 with valid data creates a skills" do
      assert {:ok, %Skills{} = skills} = Projectmode.create_skills(@valid_attrs)
      assert skills.name == "some name"
    end

    test "create_skills/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_skills(@invalid_attrs)
    end

    test "update_skills/2 with valid data updates the skills" do
      skills = skills_fixture()
      assert {:ok, skills} = Projectmode.update_skills(skills, @update_attrs)
      assert %Skills{} = skills
      assert skills.name == "some updated name"
    end

    test "update_skills/2 with invalid data returns error changeset" do
      skills = skills_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_skills(skills, @invalid_attrs)
      assert skills == Projectmode.get_skills!(skills.id)
    end

    test "delete_skills/1 deletes the skills" do
      skills = skills_fixture()
      assert {:ok, %Skills{}} = Projectmode.delete_skills(skills)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_skills!(skills.id) end
    end

    test "change_skills/1 returns a skills changeset" do
      skills = skills_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_skills(skills)
    end
  end

  describe "projectroles" do
    alias PmApi.Projectmode.Projectrole

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def projectrole_fixture(attrs \\ %{}) do
      {:ok, projectrole} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_projectrole()

      projectrole
    end

    test "list_projectroles/0 returns all projectroles" do
      projectrole = projectrole_fixture()
      assert Projectmode.list_projectroles() == [projectrole]
    end

    test "get_projectrole!/1 returns the projectrole with given id" do
      projectrole = projectrole_fixture()
      assert Projectmode.get_projectrole!(projectrole.id) == projectrole
    end

    test "create_projectrole/1 with valid data creates a projectrole" do
      assert {:ok, %Projectrole{} = projectrole} = Projectmode.create_projectrole(@valid_attrs)
    end

    test "create_projectrole/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_projectrole(@invalid_attrs)
    end

    test "update_projectrole/2 with valid data updates the projectrole" do
      projectrole = projectrole_fixture()
      assert {:ok, projectrole} = Projectmode.update_projectrole(projectrole, @update_attrs)
      assert %Projectrole{} = projectrole
    end

    test "update_projectrole/2 with invalid data returns error changeset" do
      projectrole = projectrole_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_projectrole(projectrole, @invalid_attrs)
      assert projectrole == Projectmode.get_projectrole!(projectrole.id)
    end

    test "delete_projectrole/1 deletes the projectrole" do
      projectrole = projectrole_fixture()
      assert {:ok, %Projectrole{}} = Projectmode.delete_projectrole(projectrole)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_projectrole!(projectrole.id) end
    end

    test "change_projectrole/1 returns a projectrole changeset" do
      projectrole = projectrole_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_projectrole(projectrole)
    end
  end

  describe "userskills" do
    alias PmApi.Projectmode.Userskill

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def userskill_fixture(attrs \\ %{}) do
      {:ok, userskill} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_userskill()

      userskill
    end

    test "list_userskills/0 returns all userskills" do
      userskill = userskill_fixture()
      assert Projectmode.list_userskills() == [userskill]
    end

    test "get_userskill!/1 returns the userskill with given id" do
      userskill = userskill_fixture()
      assert Projectmode.get_userskill!(userskill.id) == userskill
    end

    test "create_userskill/1 with valid data creates a userskill" do
      assert {:ok, %Userskill{} = userskill} = Projectmode.create_userskill(@valid_attrs)
    end

    test "create_userskill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_userskill(@invalid_attrs)
    end

    test "update_userskill/2 with valid data updates the userskill" do
      userskill = userskill_fixture()
      assert {:ok, userskill} = Projectmode.update_userskill(userskill, @update_attrs)
      assert %Userskill{} = userskill
    end

    test "update_userskill/2 with invalid data returns error changeset" do
      userskill = userskill_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_userskill(userskill, @invalid_attrs)
      assert userskill == Projectmode.get_userskill!(userskill.id)
    end

    test "delete_userskill/1 deletes the userskill" do
      userskill = userskill_fixture()
      assert {:ok, %Userskill{}} = Projectmode.delete_userskill(userskill)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_userskill!(userskill.id) end
    end

    test "change_userskill/1 returns a userskill changeset" do
      userskill = userskill_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_userskill(userskill)
    end
  end

  describe "interests" do
    alias PmApi.Projectmode.Interest

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def interest_fixture(attrs \\ %{}) do
      {:ok, interest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_interest()

      interest
    end

    test "list_interests/0 returns all interests" do
      interest = interest_fixture()
      assert Projectmode.list_interests() == [interest]
    end

    test "get_interest!/1 returns the interest with given id" do
      interest = interest_fixture()
      assert Projectmode.get_interest!(interest.id) == interest
    end

    test "create_interest/1 with valid data creates a interest" do
      assert {:ok, %Interest{} = interest} = Projectmode.create_interest(@valid_attrs)
      assert interest.name == "some name"
    end

    test "create_interest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_interest(@invalid_attrs)
    end

    test "update_interest/2 with valid data updates the interest" do
      interest = interest_fixture()
      assert {:ok, interest} = Projectmode.update_interest(interest, @update_attrs)
      assert %Interest{} = interest
      assert interest.name == "some updated name"
    end

    test "update_interest/2 with invalid data returns error changeset" do
      interest = interest_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_interest(interest, @invalid_attrs)
      assert interest == Projectmode.get_interest!(interest.id)
    end

    test "delete_interest/1 deletes the interest" do
      interest = interest_fixture()
      assert {:ok, %Interest{}} = Projectmode.delete_interest(interest)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_interest!(interest.id) end
    end

    test "change_interest/1 returns a interest changeset" do
      interest = interest_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_interest(interest)
    end
  end

  describe "userinterests" do
    alias PmApi.Projectmode.Userinterest

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def userinterest_fixture(attrs \\ %{}) do
      {:ok, userinterest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_userinterest()

      userinterest
    end

    test "list_userinterests/0 returns all userinterests" do
      userinterest = userinterest_fixture()
      assert Projectmode.list_userinterests() == [userinterest]
    end

    test "get_userinterest!/1 returns the userinterest with given id" do
      userinterest = userinterest_fixture()
      assert Projectmode.get_userinterest!(userinterest.id) == userinterest
    end

    test "create_userinterest/1 with valid data creates a userinterest" do
      assert {:ok, %Userinterest{} = userinterest} = Projectmode.create_userinterest(@valid_attrs)
    end

    test "create_userinterest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_userinterest(@invalid_attrs)
    end

    test "update_userinterest/2 with valid data updates the userinterest" do
      userinterest = userinterest_fixture()
      assert {:ok, userinterest} = Projectmode.update_userinterest(userinterest, @update_attrs)
      assert %Userinterest{} = userinterest
    end

    test "update_userinterest/2 with invalid data returns error changeset" do
      userinterest = userinterest_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_userinterest(userinterest, @invalid_attrs)
      assert userinterest == Projectmode.get_userinterest!(userinterest.id)
    end

    test "delete_userinterest/1 deletes the userinterest" do
      userinterest = userinterest_fixture()
      assert {:ok, %Userinterest{}} = Projectmode.delete_userinterest(userinterest)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_userinterest!(userinterest.id) end
    end

    test "change_userinterest/1 returns a userinterest changeset" do
      userinterest = userinterest_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_userinterest(userinterest)
    end
  end

  describe "projectstacks" do
    alias PmApi.Projectmode.Projectstack

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def projectstack_fixture(attrs \\ %{}) do
      {:ok, projectstack} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_projectstack()

      projectstack
    end

    test "list_projectstacks/0 returns all projectstacks" do
      projectstack = projectstack_fixture()
      assert Projectmode.list_projectstacks() == [projectstack]
    end

    test "get_projectstack!/1 returns the projectstack with given id" do
      projectstack = projectstack_fixture()
      assert Projectmode.get_projectstack!(projectstack.id) == projectstack
    end

    test "create_projectstack/1 with valid data creates a projectstack" do
      assert {:ok, %Projectstack{} = projectstack} = Projectmode.create_projectstack(@valid_attrs)
    end

    test "create_projectstack/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_projectstack(@invalid_attrs)
    end

    test "update_projectstack/2 with valid data updates the projectstack" do
      projectstack = projectstack_fixture()
      assert {:ok, projectstack} = Projectmode.update_projectstack(projectstack, @update_attrs)
      assert %Projectstack{} = projectstack
    end

    test "update_projectstack/2 with invalid data returns error changeset" do
      projectstack = projectstack_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_projectstack(projectstack, @invalid_attrs)
      assert projectstack == Projectmode.get_projectstack!(projectstack.id)
    end

    test "delete_projectstack/1 deletes the projectstack" do
      projectstack = projectstack_fixture()
      assert {:ok, %Projectstack{}} = Projectmode.delete_projectstack(projectstack)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_projectstack!(projectstack.id) end
    end

    test "change_projectstack/1 returns a projectstack changeset" do
      projectstack = projectstack_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_projectstack(projectstack)
    end
  end

  describe "projectinterests" do
    alias PmApi.Projectmode.Projectinterest

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def projectinterest_fixture(attrs \\ %{}) do
      {:ok, projectinterest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_projectinterest()

      projectinterest
    end

    test "list_projectinterests/0 returns all projectinterests" do
      projectinterest = projectinterest_fixture()
      assert Projectmode.list_projectinterests() == [projectinterest]
    end

    test "get_projectinterest!/1 returns the projectinterest with given id" do
      projectinterest = projectinterest_fixture()
      assert Projectmode.get_projectinterest!(projectinterest.id) == projectinterest
    end

    test "create_projectinterest/1 with valid data creates a projectinterest" do
      assert {:ok, %Projectinterest{} = projectinterest} = Projectmode.create_projectinterest(@valid_attrs)
    end

    test "create_projectinterest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_projectinterest(@invalid_attrs)
    end

    test "update_projectinterest/2 with valid data updates the projectinterest" do
      projectinterest = projectinterest_fixture()
      assert {:ok, projectinterest} = Projectmode.update_projectinterest(projectinterest, @update_attrs)
      assert %Projectinterest{} = projectinterest
    end

    test "update_projectinterest/2 with invalid data returns error changeset" do
      projectinterest = projectinterest_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_projectinterest(projectinterest, @invalid_attrs)
      assert projectinterest == Projectmode.get_projectinterest!(projectinterest.id)
    end

    test "delete_projectinterest/1 deletes the projectinterest" do
      projectinterest = projectinterest_fixture()
      assert {:ok, %Projectinterest{}} = Projectmode.delete_projectinterest(projectinterest)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_projectinterest!(projectinterest.id) end
    end

    test "change_projectinterest/1 returns a projectinterest changeset" do
      projectinterest = projectinterest_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_projectinterest(projectinterest)
    end
  end

  describe "watchedprojects" do
    alias PmApi.Projectmode.Watchedproject

    @valid_attrs %{interestlevel: 42}
    @update_attrs %{interestlevel: 43}
    @invalid_attrs %{interestlevel: nil}

    def watchedproject_fixture(attrs \\ %{}) do
      {:ok, watchedproject} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_watchedproject()

      watchedproject
    end

    test "list_watchedprojects/0 returns all watchedprojects" do
      watchedproject = watchedproject_fixture()
      assert Projectmode.list_watchedprojects() == [watchedproject]
    end

    test "get_watchedproject!/1 returns the watchedproject with given id" do
      watchedproject = watchedproject_fixture()
      assert Projectmode.get_watchedproject!(watchedproject.id) == watchedproject
    end

    test "create_watchedproject/1 with valid data creates a watchedproject" do
      assert {:ok, %Watchedproject{} = watchedproject} = Projectmode.create_watchedproject(@valid_attrs)
      assert watchedproject.interestlevel == 42
    end

    test "create_watchedproject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_watchedproject(@invalid_attrs)
    end

    test "update_watchedproject/2 with valid data updates the watchedproject" do
      watchedproject = watchedproject_fixture()
      assert {:ok, watchedproject} = Projectmode.update_watchedproject(watchedproject, @update_attrs)
      assert %Watchedproject{} = watchedproject
      assert watchedproject.interestlevel == 43
    end

    test "update_watchedproject/2 with invalid data returns error changeset" do
      watchedproject = watchedproject_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_watchedproject(watchedproject, @invalid_attrs)
      assert watchedproject == Projectmode.get_watchedproject!(watchedproject.id)
    end

    test "delete_watchedproject/1 deletes the watchedproject" do
      watchedproject = watchedproject_fixture()
      assert {:ok, %Watchedproject{}} = Projectmode.delete_watchedproject(watchedproject)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_watchedproject!(watchedproject.id) end
    end

    test "change_watchedproject/1 returns a watchedproject changeset" do
      watchedproject = watchedproject_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_watchedproject(watchedproject)
    end
  end

  describe "users" do
    alias PmApi.Projectmode.User

    @valid_attrs %{email: "some email", firstname: "some firstname", lastname: "some lastname", password_hash: "some password_hash", tagline: "some tagline"}
    @update_attrs %{email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname", password_hash: "some updated password_hash", tagline: "some updated tagline"}
    @invalid_attrs %{email: nil, firstname: nil, lastname: nil, password_hash: nil, tagline: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Projectmode.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Projectmode.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Projectmode.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.password_hash == "some password_hash"
      assert user.tagline == "some tagline"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Projectmode.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.password_hash == "some updated password_hash"
      assert user.tagline == "some updated tagline"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_user(user, @invalid_attrs)
      assert user == Projectmode.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Projectmode.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_user(user)
    end
  end

  describe "comments" do
    alias PmApi.Projectmode.Comment

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Projectmode.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Projectmode.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Projectmode.create_comment(@valid_attrs)
      assert comment.body == "some body"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Projectmode.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.body == "some updated body"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_comment(comment, @invalid_attrs)
      assert comment == Projectmode.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Projectmode.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_comment(comment)
    end
  end

  describe "channels" do
    alias PmApi.Projectmode.Channel

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def channel_fixture(attrs \\ %{}) do
      {:ok, channel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projectmode.create_channel()

      channel
    end

    test "list_channels/0 returns all channels" do
      channel = channel_fixture()
      assert Projectmode.list_channels() == [channel]
    end

    test "get_channel!/1 returns the channel with given id" do
      channel = channel_fixture()
      assert Projectmode.get_channel!(channel.id) == channel
    end

    test "create_channel/1 with valid data creates a channel" do
      assert {:ok, %Channel{} = channel} = Projectmode.create_channel(@valid_attrs)
      assert channel.name == "some name"
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projectmode.create_channel(@invalid_attrs)
    end

    test "update_channel/2 with valid data updates the channel" do
      channel = channel_fixture()
      assert {:ok, channel} = Projectmode.update_channel(channel, @update_attrs)
      assert %Channel{} = channel
      assert channel.name == "some updated name"
    end

    test "update_channel/2 with invalid data returns error changeset" do
      channel = channel_fixture()
      assert {:error, %Ecto.Changeset{}} = Projectmode.update_channel(channel, @invalid_attrs)
      assert channel == Projectmode.get_channel!(channel.id)
    end

    test "delete_channel/1 deletes the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{}} = Projectmode.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Projectmode.get_channel!(channel.id) end
    end

    test "change_channel/1 returns a channel changeset" do
      channel = channel_fixture()
      assert %Ecto.Changeset{} = Projectmode.change_channel(channel)
    end
  end
end
