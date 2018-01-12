defmodule PmApiWeb.TeamController do
  use PmApiWeb, :controller

  alias PmApi.Network
  alias PmApi.Network.Team

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    teams = Network.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Network.create_team(team_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Network.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Network.get_team!(id)

    with {:ok, %Team{} = team} <- Network.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Network.get_team!(id)
    with {:ok, %Team{}} <- Network.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
