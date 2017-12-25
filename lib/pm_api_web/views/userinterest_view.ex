defmodule PmApiWeb.UserinterestView do
  use PmApiWeb, :view
  alias PmApiWeb.UserinterestView

  def render("index.json", %{userinterests: userinterests}) do
    %{data: render_many(userinterests, UserinterestView, "userinterest.json")}
  end

  def render("show.json", %{userinterest: userinterest}) do
    %{data: render_one(userinterest, UserinterestView, "userinterest.json")}
  end

  def render("userinterest.json", %{userinterest: userinterest}) do
    userinterest = userinterest |> PmApi.Repo.preload([:interest])
    %{
      id: userinterest.id,
      name: userinterest.interest.name
    }
  end
end
