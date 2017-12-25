defmodule PmApiWeb.TeamprojectController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Teamproject

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    teamprojects = Projectmode.list_teamprojects()
    render(conn, "index.json", teamprojects: teamprojects)
  end

  def create(conn, %{"teamproject" => teamproject_params}) do
    with {:ok, %Teamproject{} = teamproject} <- Projectmode.create_teamproject(teamproject_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", teamproject_path(conn, :show, teamproject))
      |> render("show.json", teamproject: teamproject)
    end
  end

  def show(conn, %{"id" => id}) do
    teamproject = Projectmode.get_teamproject!(id)
    render(conn, "show.json", teamproject: teamproject)
  end

  def update(conn, %{"id" => id, "teamproject" => teamproject_params}) do
    teamproject = Projectmode.get_teamproject!(id)

    with {:ok, %Teamproject{} = teamproject} <- Projectmode.update_teamproject(teamproject, teamproject_params) do
      render(conn, "show.json", teamproject: teamproject)
    end
  end

  def delete(conn, %{"id" => id}) do
    teamproject = Projectmode.get_teamproject!(id)
    with {:ok, %Teamproject{}} <- Projectmode.delete_teamproject(teamproject) do
      send_resp(conn, :no_content, "")
    end
  end
end
