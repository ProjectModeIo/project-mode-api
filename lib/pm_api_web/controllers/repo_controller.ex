defmodule PmApiWeb.RepoController do
  use PmApiWeb, :controller

  alias PmApi.Github
  alias PmApi.Github.Repo

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    repos = Github.list_repos()
    render(conn, "index.json", repos: repos)
  end

  def create(conn, %{"repo" => repo_params}) do
    with {:ok, %Repo{} = repo} <- Github.create_repo(repo_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", repo_path(conn, :show, repo))
      |> render("show.json", repo: repo)
    end
  end

  def show(conn, %{"id" => id}) do
    repo = Github.get_repo!(id)
    render(conn, "show.json", repo: repo)
  end

  def update(conn, %{"id" => id, "repo" => repo_params}) do
    repo = Github.get_repo!(id)

    with {:ok, %Repo{} = repo} <- Github.update_repo(repo, repo_params) do
      render(conn, "show.json", repo: repo)
    end
  end

  def delete(conn, %{"id" => id}) do
    repo = Github.get_repo!(id)
    with {:ok, %Repo{}} <- Github.delete_repo(repo) do
      send_resp(conn, :no_content, "")
    end
  end
end
