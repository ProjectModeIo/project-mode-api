defmodule PmApiWeb.ProjectroleController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectrole

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    projectroles = Projectmode.list_projectroles()
    render(conn, "index.json", projectroles: projectroles)
  end

  def create(conn, %{"projectrole" => projectrole_params}) do
    with {:ok, %Projectrole{} = projectrole} <- Projectmode.create_projectrole(projectrole_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", projectrole_path(conn, :show, projectrole))
      |> render("show.json", projectrole: projectrole)
    end
  end

  def show(conn, %{"id" => id}) do
    projectrole = Projectmode.get_projectrole!(id)
    render(conn, "show.json", projectrole: projectrole)
  end

  def update(conn, %{"id" => id, "projectrole" => projectrole_params}) do
    projectrole = Projectmode.get_projectrole!(id)

    with {:ok, %Projectrole{} = projectrole} <- Projectmode.update_projectrole(projectrole, projectrole_params) do
      render(conn, "show.json", projectrole: projectrole)
    end
  end

  def delete(conn, %{"id" => id}) do
    projectrole = Projectmode.get_projectrole!(id)
    with {:ok, %Projectrole{}} <- Projectmode.delete_projectrole(projectrole) do
      send_resp(conn, :no_content, "")
    end
  end
end
