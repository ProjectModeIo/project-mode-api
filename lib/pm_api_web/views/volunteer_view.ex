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
      account: render_one(volunteer.user.account, PmApiWeb.AccountView, "account.json"),
      project: render_one(volunteer.project, PmApiWeb.ProjectView, "project.json"),
      user: %{
        id: volunteer.user.id,
        username: volunteer.user.username,
        skills: render_many(volunteer.user.skills, PmApiWeb.SkillView, "skill.json")
      }
    }
  end

  def render("volunteer_user.json", %{volunteer: volunteer }) do
    %{id: volunteer.id,
      user_id: volunteer.user_id,
      project_id: volunteer.project_id,
      username: volunteer.user.username,
      user: %{
        id: volunteer.user.id,
        username: volunteer.user.username,
        skills: render_many(volunteer.user.skills, PmApiWeb.SkillView, "skill.json")
      },
      account: render_one(volunteer.user.account, PmApiWeb.AccountView, "account.json"),
    }
  end

  def render("volunteer_project.json", %{volunteer: volunteer}) do
    %{id: volunteer.id,
      user_id: volunteer.user_id,
      project_id: volunteer.project_id,
      project: render_one(volunteer.project, PmApiWeb.ProjectView, "project.json")
    }
  end
end
