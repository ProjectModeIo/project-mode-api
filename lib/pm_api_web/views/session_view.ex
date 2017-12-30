defmodule PmApiWeb.SessionView do
  use PmApiWeb, :view
  alias PmApi.Projectmode
  alias PmApi.Projectmode.Project
  alias PmApi.Repo

  def render("show.json", %{user: user, jwt: jwt}) do
    #corresponds to setUser in react app
    %{
      data: render_one(user, PmApiWeb.UserView, "user.json"),
      feed: render_one(user, PmApiWeb.UserView, "feed.json"),
      channels: %{
        subscribedChannels: []
      },
      meta: %{token: jwt}
    }
  end

  def render("load.json", _) do
    #corresponds to loadAllThings in react app
    projects_all = Projectmode.list_projects
    channels_all = Projectmode.Channel |> Repo.all()

    %{
      feed: %{
        projects_all: render_many(projects_all, PmApiWeb.ProjectView, "project.json")
      },
      channels: %{
        allChannels: render_many(channels_all, PmApiWeb.ChannelView, "channel.json")
      }
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
