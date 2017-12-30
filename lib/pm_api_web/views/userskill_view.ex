defmodule PmApiWeb.UserskillView do
  use PmApiWeb, :view
  alias PmApiWeb.UserskillView

  def render("index.json", %{userskills: userskills}) do
    %{data: render_many(userskills, UserskillView, "userskill.json")}
  end

  def render("show.json", %{userskill: userskill}) do
    %{data: render_one(userskill, UserskillView, "userskill.json")}
  end

  def render("userskill.json", %{userskill: userskill}) do
    # userskill = userskill |> PmApi.Repo.preload([:skill])
    %{
      id: userskill.id,
      name: userskill.skill.name
      # skills: render_one(userskill.skill, PmApiWeb.SkillView, "skill.json")
  }
  end

  def render("deleted.json", %{old_id: old_id, user: user}) do
    %{
      id: old_id,
      feed: render_one(user, PmApiWeb.UserView, "feed.json")
    }
  end
end
