defmodule PmApiWeb.ProjectskillView do
  use PmApiWeb, :view
  alias PmApiWeb.ProjectskillView

  def render("index.json", %{projectskills: projectskills}) do
    %{data: render_many(projectskills, ProjectskillView, "projectskill.json")}
  end

  def render("show.json", %{projectskill: projectskill}) do
    %{data: render_one(projectskill, ProjectskillView, "projectskill.json")}
  end

  def render("projectskill.json", %{projectskill: projectskill}) do
    # projectskill = projectskill |> PmApi.Repo.preload([:skill])
    %{
      id: projectskill.id,
      name: projectskill.skill.name
    }
  end
end
