defmodule PmApiWeb.RoleView do
  use PmApiWeb, :view
  alias PmApiWeb.RoleView

  def render("index.json", %{roles: roles}) do
    %{data: render_many(roles, RoleView, "role.json")}
  end

  def render("show.json", %{role: role}) do
    %{data: render_one(role, RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{id: role.id,
      name: role.name}
  end

  def render("role_projonly.json", %{role: role}) do
    %{projects: render_many(role.projects, PmApiWeb.ProjectView, "project.json")}
  end
end
