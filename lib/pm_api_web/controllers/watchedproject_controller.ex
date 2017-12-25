defmodule PmApiWeb.WatchedprojectController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Watchedproject

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    watchedprojects = Projectmode.list_watchedprojects()
    render(conn, "index.json", watchedprojects: watchedprojects)
  end

  def create(conn, %{"watchedproject" => watchedproject_params}) do
    with {:ok, %Watchedproject{} = watchedproject} <- Projectmode.create_watchedproject(watchedproject_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", watchedproject_path(conn, :show, watchedproject))
      |> render("show.json", watchedproject: watchedproject)
    end
  end

  def show(conn, %{"id" => id}) do
    watchedproject = Projectmode.get_watchedproject!(id)
    render(conn, "show.json", watchedproject: watchedproject)
  end

  def update(conn, %{"id" => id, "watchedproject" => watchedproject_params}) do
    watchedproject = Projectmode.get_watchedproject!(id)

    with {:ok, %Watchedproject{} = watchedproject} <- Projectmode.update_watchedproject(watchedproject, watchedproject_params) do
      render(conn, "show.json", watchedproject: watchedproject)
    end
  end

  def delete(conn, %{"id" => id}) do
    watchedproject = Projectmode.get_watchedproject!(id)
    with {:ok, %Watchedproject{}} <- Projectmode.delete_watchedproject(watchedproject) do
      send_resp(conn, :no_content, "")
    end
  end
end
