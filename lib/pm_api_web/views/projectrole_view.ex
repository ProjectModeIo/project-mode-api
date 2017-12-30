defmodule PmApiWeb.ProjectroleView do
  use PmApiWeb, :view
  alias PmApiWeb.ProjectroleView

  def render("index.json", %{projectroles: projectroles}) do
    %{data: render_many(projectroles, ProjectroleView, "projectrole.json")}
  end

  def render("show.json", %{projectrole: projectrole}) do
    %{data: render_one(projectrole, ProjectroleView, "projectrole.json")}
  end

  def render("projectrole.json", %{projectrole: projectrole}) do
    # projectrole = projectrole |> PmApi.Repo.preload([:role])
    %{
      id: projectrole.id,
      name: projectrole.role.name
    }
  end
end
