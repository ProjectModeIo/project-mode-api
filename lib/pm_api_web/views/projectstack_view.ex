defmodule PmApiWeb.ProjectstackView do
  use PmApiWeb, :view
  alias PmApiWeb.ProjectstackView

  def render("index.json", %{projectstacks: projectstacks}) do
    %{data: render_many(projectstacks, ProjectstackView, "projectstack.json")}
  end

  def render("show.json", %{projectstack: projectstack}) do
    %{data: render_one(projectstack, ProjectstackView, "projectstack.json")}
  end

  def render("projectstack.json", %{projectstack: projectstack}) do
    %{id: projectstack.id}
  end
end
