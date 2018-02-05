defmodule PmApiWeb.SkillView do
  use PmApiWeb, :view
  alias PmApiWeb.SkillView

  def render("index.json", %{skills: skills}) do
    %{data: render_many(skills, SkillView, "skill.json")}
  end

  def render("show.json", %{skill: skill}) do
    %{data: render_one(skill, SkillView, "skill.json")}
  end

  def render("skill.json", %{skill: skill}) do
    %{
      id: skill.id,
      name: skill.name
    }
  end

  def render("skill_connections.json", %{skill: skill}) do
    %{
      projects: render_many(skill.projects, PmApiWeb.ProjectView, "project.json"),
      users: render_many(skill.users, PmApiWeb.UserView, "user_simple.json")
    }
  end
end
