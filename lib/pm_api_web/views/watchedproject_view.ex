defmodule PmApiWeb.WatchedprojectView do
  use PmApiWeb, :view
  alias PmApiWeb.WatchedprojectView

  def render("index.json", %{watchedprojects: watchedprojects}) do
    %{data: render_many(watchedprojects, WatchedprojectView, "watchedproject.json")}
  end

  def render("show.json", %{watchedproject: watchedproject}) do
    %{data: render_one(watchedproject, WatchedprojectView, "watchedproject.json")}
  end

  def render("watchedproject.json", %{watchedproject: watchedproject}) do
    %{id: watchedproject.id,
      interestlevel: watchedproject.interestlevel,
      user_id: watchedproject.user_id,
      project_id: watchedproject.project_id
    }
  end

  def render("watchedproject_user.json", %{watchedproject: watchedproject}) do
    %{id: watchedproject.id,
      interestlevel: watchedproject.interestlevel,
      user_id: watchedproject.user_id,
      project_id: watchedproject.project_id,
      username: watchedproject.user.username
    }
  end

  def render("watchedproject_project.json", %{watchedproject: watchedproject}) do
    %{id: watchedproject.id,
      interestlevel: watchedproject.interestlevel,
      user_id: watchedproject.user_id,
      project_id: watchedproject.project_id,
      project: render_one(watchedproject.project, PmApiWeb.ProjectView, "project.json")
    }
  end
end
