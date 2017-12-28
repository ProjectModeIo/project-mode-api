defmodule PmApiWeb.ProjectinterestView do
  use PmApiWeb, :view
  alias PmApiWeb.ProjectinterestView

  def render("index.json", %{projectinterests: projectinterests}) do
    %{data: render_many(projectinterests, ProjectinterestView, "projectinterest.json")}
  end

  def render("show.json", %{projectinterest: projectinterest}) do
    %{data: render_one(projectinterest, ProjectinterestView, "projectinterest.json")}
  end

  def render("projectinterest.json", %{projectinterest: projectinterest}) do
    projectinterest = projectinterest |> PmApi.Repo.preload([:interest])
    %{
      id: projectinterest.id,
      name: projectinterest.interest.name
    }
  end
end
