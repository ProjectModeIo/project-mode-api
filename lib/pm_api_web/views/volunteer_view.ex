defmodule PmApiWeb.VolunteerView do
  use PmApiWeb, :view
  alias PmApiWeb.VolunteerView

  def render("index.json", %{volunteers: volunteers}) do
    %{data: render_many(volunteers, VolunteerView, "volunteer.json")}
  end

  def render("show.json", %{volunteer: volunteer}) do
    %{data: render_one(volunteer, VolunteerView, "volunteer.json")}
  end

  def render("volunteer.json", %{volunteer: volunteer}) do
    %{
      id: volunteer.id,
      user: %{
        id: volunteer.user.id,
        username: volunteer.user.username,
        skills: render_many(volunteer.user.skills, PmApiWeb.SkillView, "skill.json")
      }
    }
  end
end
