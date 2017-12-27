defmodule PmApiWeb.ProjectcategoryView do
  use PmApiWeb, :view
  alias PmApiWeb.ProjectcategoryView

  def render("index.json", %{projectcategories: projectcategories}) do
    %{data: render_many(projectcategories, ProjectcategoryView, "projectcategory.json")}
  end

  def render("show.json", %{projectcategory: projectcategory}) do
    %{data: render_one(projectcategory, ProjectcategoryView, "projectcategory.json")}
  end

  def render("projectcategory.json", %{projectcategory: projectcategory}) do
    projectcategory = projectcategory |> PmApi.Repo.preload([:interest])
    %{
      id: projectcategory.id,
      name: projectcategory.interest.name
    }
  end
end
