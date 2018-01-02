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
    }
  end
end
