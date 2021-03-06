require IEx
defmodule PmApiWeb.ProjectView do
  use PmApiWeb, :view
  alias PmApiWeb.ProjectView

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    # comment_query = from(c in Comments, where: is_nil(parent_id))
    # project = project|> PmApi.Repo.preload([:user, :projectroles, :projectskills, :projectinterests, :comments])
    %{
      id: project.id,
      title: project.title,
      status: project.status,
      description: project.description,
      created_by: project.user.username,
      inserted_at: project.inserted_at,
      updated_at: project.updated_at,
      slug: project.slug,
      user: %{id: project.user.id},
      github_repo: project.github_repo,
      watchedprojects: render_many(project.watchedprojects, PmApiWeb.WatchedprojectView, "watchedproject_user.json"),
      volunteers: render_many(project.volunteers, PmApiWeb.VolunteerView, "volunteer_user.json"),
      roles: render_many(project.projectroles, PmApiWeb.ProjectroleView, "projectrole.json"),
      skills: render_many(project.projectskills, PmApiWeb.ProjectskillView, "projectskill.json"),
      interests: render_many(project.projectinterests, PmApiWeb.ProjectinterestView, "projectinterest.json"),
      comments: render_many(project.comments, PmApiWeb.CommentView, "comment.json")
    }
  end

  def render("name_only.json", %{project: project}) do
    # comment_query = from(c in Comments, where: is_nil(parent_id))
    # project = project|> PmApi.Repo.preload([:user, :projectroles, :projectskills, :projectinterests, :comments])
    %{
      id: project.id,
      title: project.title,
      status: project.status,
      description: project.description,
      created_by: project.user.username,
      inserted_at: project.inserted_at,
      updated_at: project.updated_at,
      slug: project.slug,
    }
  end

end
