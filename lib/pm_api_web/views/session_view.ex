defmodule PmApiWeb.SessionView do
  use PmApiWeb, :view
  alias PmApi.Projectmode
  alias PmApi.Projectmode.Project
  alias PmApi.Repo

  def render("show.json", %{user: user, jwt: jwt}) do
    %{
      data: render_one(user, PmApiWeb.UserView, "user.json"),
      feed: render_one(user, PmApiWeb.UserView, "feed.json"),
      meta: %{token: jwt}
    }
  end

  def render("error.json", _) do
    %{error: "Invalid email or password"}
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("forbidden.json", %{error: error}) do
    %{error: error}
  end
end
