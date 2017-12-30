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
    %{id: skill.id,
      name: skill.name}
  end

  def render("skill_projonly.json", %{skill: skill}) do
    %{projects: render_many(skill.projects, PmApiWeb.ProjectView, "name_only.json")}
  end
end
