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
    project = project|> PmApi.Repo.preload([:user, :projectroles, :projectstacks, :projectcategories, :comments])
    %{
      id: project.id,
      title: project.title,
      description: project.description,
      created_by: project.user.username,
      inserted_at: project.inserted_at,
      updated_at: project.updated_at,
      slug: project.slug,
      roles: render_many(project.projectroles, PmApiWeb.ProjectroleView, "projectrole.json"),
      skills: render_many(project.projectstacks, PmApiWeb.ProjectstackView, "projectstack.json"),
      interests: render_many(project.projectcategories, PmApiWeb.ProjectcategoryView, "projectcategory.json"),
      comments: render_many(project.comments, PmApiWeb.CommentView, "comment.json")
    }
  end

end
