require IEx
defmodule PmApiWeb.UserView do
  use PmApiWeb, :view
  alias PmApiWeb.UserView
  alias PmApi.Projectmode
  alias PmApi.Projectmode.Project
  alias PmApi.Repo
  import Ecto.Query

  # def render("index.json", %{users: users}) do
  #   %{data: render_many(users, UserView, "user.json")}
  # end
  #
  def render("validated.json", _params) do
    %{
      status: "ok"
    }
  end

  def render("notvalidated.json", _params) do
    %{
      status: "already exists"
    }
  end

  def render("profile.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      firstname: user.firstname,
      lastname: user.lastname,
      tagline: user.tagline,
      created_projects: render_many(user.projects, PmApiWeb.ProjectView, "project.json"),
      account: render_one(user.account, PmApiWeb.AccountView, "account.json"),
      roles: render_many(user.userroles, PmApiWeb.UserroleView, "userrole.json"),
      skills: render_many(user.userskills, PmApiWeb.UserskillView, "userskill.json"),
      interests: render_many(user.userinterests, PmApiWeb.UserinterestView, "userinterest.json")
    }
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("watcher.json", %{user: user}) do
    %{

    }
  end

  def render("user_simple.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username
    }
  end

  def render("user.json", %{user: user}) do
    # IEx.pry
    # user = user |> PmApi.Repo.preload([:projects, :userroles, :userinterests, :userskills, :account])
    # IEx.pry
    %{id: user.id,
      username: user.username,
      email: user.email,
      firstname: user.firstname,
      lastname: user.lastname,
      tagline: user.tagline,
      account: render_one(user.account, PmApiWeb.AccountView, "account.json"),
      watched_projects: render_many(user.watchedprojects, PmApiWeb.WatchedprojectView, "watchedproject_project.json"),
      volunteer_projects: render_many(user.volunteers, PmApiWeb.VolunteerView, "volunteer_project.json"),
      created_projects: render_many(user.projects, PmApiWeb.ProjectView, "project.json"),
      github_account_info: render_one(user.account, PmApiWeb.AccountView, "account.json"),
      roles: render_many(user.userroles, PmApiWeb.UserroleView, "userrole.json"),
      skills: render_many(user.userskills, PmApiWeb.UserskillView, "userskill.json"),
      interests: render_many(user.userinterests, PmApiWeb.UserinterestView, "userinterest.json")
    }
  end

  def render("feed.json", %{user: user}) do
    projects_role_related = PmApi.Projectmode.Project
    |> distinct(true)
    |> Project.filter_by({:role_match, user})
    |> Projectmode.list_projects()

    projects_interest_related = PmApi.Projectmode.Project
    |> distinct(true)
    |> Project.filter_by({:interest_match, user})
    |> Projectmode.list_projects()

    projects_skill_related = PmApi.Projectmode.Project
    |> distinct(true)
    |> Project.filter_by({:skill_match, user})
    |> Projectmode.list_projects()

    projects_recommended = PmApi.Projectmode.Project
    |> distinct(true)
    |> Project.filter_by({:skill_match, user})
    |> Project.filter_by({:interest_match, user})
    |> Projectmode.list_projects()

    %{
      projects_role_related: render_many(projects_role_related, PmApiWeb.ProjectView, "project.json"),
      projects_interest_related: render_many(projects_interest_related, PmApiWeb.ProjectView, "project.json"),
      projects_skill_related: render_many(projects_skill_related, PmApiWeb.ProjectView, "project.json"),
      projects_recommended: render_many(projects_recommended, PmApiWeb.ProjectView, "project.json")
    }
  end

  def render("channels.json", %{user: user}) do
  end
end
