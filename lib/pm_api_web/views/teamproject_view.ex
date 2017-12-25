defmodule PmApiWeb.TeamprojectView do
  use PmApiWeb, :view
  alias PmApiWeb.TeamprojectView

  def render("index.json", %{teamprojects: teamprojects}) do
    %{data: render_many(teamprojects, TeamprojectView, "teamproject.json")}
  end

  def render("show.json", %{teamproject: teamproject}) do
    %{data: render_one(teamproject, TeamprojectView, "teamproject.json")}
  end

  def render("teamproject.json", %{teamproject: teamproject}) do
    %{id: teamproject.id}
  end
end
