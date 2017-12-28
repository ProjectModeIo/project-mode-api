defmodule PmApiWeb.RepoView do
  use PmApiWeb, :view
  alias PmApiWeb.RepoView

  def render("index.json", %{repos: repos}) do
    %{data: render_many(repos, RepoView, "repo.json")}
  end

  def render("show.json", %{repo: repo}) do
    %{data: render_one(repo, RepoView, "repo.json")}
  end

  def render("repo.json", %{repo: repo}) do
    %{id: repo.id,
      commits_json: repo.commits_json,
      totalcommits: repo.totalcommits}
  end
end
