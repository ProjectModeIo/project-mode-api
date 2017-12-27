defmodule PmApiWeb.UserinterestView do
  use PmApiWeb, :view
  alias PmApiWeb.UserinterestView

  def render("index.json", %{userinterests: userinterests}) do
    %{data: render_many(userinterests, UserinterestView, "userinterest.json")}
  end

  def render("show.json", %{userinterest: userinterest, user: user}) do
    %{
      data: render_one(userinterest, UserinterestView, "userinterest.json"),
      feed: render_one(user, PmApiWeb.UserView, "feed.json")
    }
  end

  def render("userinterest.json", %{userinterest: userinterest}) do
    userinterest = userinterest |> PmApi.Repo.preload([:interest])
    %{
      id: userinterest.id,
      name: userinterest.interest.name
    }
  end

  def render("deleted.json", %{old_id: old_id, user: user}) do
    %{
      id: old_id,
      feed: render_one(user, PmApiWeb.UserView, "feed.json")
    }
  end
end
