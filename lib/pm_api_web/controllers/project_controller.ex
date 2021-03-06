require IEx
defmodule PmApiWeb.ProjectController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Project

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do

    projects = Projectmode.list_projects()

    render(conn, "index.json", projects: projects |> PmApi.Projectmode.project_preloads())
  end

  def create(conn, %{"project" => project_params}) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        project_params = Map.put(project_params, "user_id", current_user.id)
        with {:ok, %Project{} = project} <- Projectmode.create_project(project_params) do
          conn
          |> put_status(:created)
          |> render("show.json", project: project |> PmApi.Projectmode.project_preloads())
        end
      _ ->
      conn
      |> render("error.json")
    end
  end

  def show(conn, %{"id" => id}) do
    # IEx.pry
    project = Projectmode.get_project!(id)
    render(conn, "show.json", project: project |> PmApi.Projectmode.project_preloads())
  end

  def showslug(conn, %{"slug" => slug, "username" => username}) do
    with {:ok, %Project{} = project} <- Projectmode.get_project_by_slug(username, slug) do
      render(conn, "show.json", project: project |> PmApi.Projectmode.project_preloads())
    end
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    # IEx.pry
    project = Projectmode.get_project!(id)

    with {:ok, %Project{} = project} <- Projectmode.update_project(project, project_params) do
      render(conn, "show.json", project: project |> PmApi.Projectmode.project_preloads())
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Projectmode.get_project!(id)
    with {:ok, %Project{}} <- Projectmode.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
