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
    project = project|> PmApi.Repo.preload([:user, :projectroles])
    %{
      id: project.id,
      title: project.title,
      description: project.description,
      created_by: project.user.username,
      slug: project.slug,
      roles: render_many(project.projectroles, PmApiWeb.ProjectroleView, "projectrole.json"),
    }
  end
end
