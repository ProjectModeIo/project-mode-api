require IEx
defmodule PmApiWeb.ProjectroleController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectrole
  alias PmApi.Projectmode.Role

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    projectroles = Projectmode.list_projectroles()
    render(conn, "index.json", projectroles: projectroles)
  end

  def create(conn, %{"project_id" => project_id, "name" => name}) do
    # project can only update project if they are project creator
    case PmApi.AccessHandler.verify_resource_owner(conn, %{ project_id: project_id }) do
      {:ok, project} ->
        {:ok, %Role{}=role} = Projectmode.find_or_create_role_by(%{name: name})
        with {:ok, %Projectrole{} = projectrole } <- Projectmode.create_projectrole(%{project_id: project_id, role_id: role.id}) do
          conn
          |> put_status(:created)
          |> render("show.json", projectrole: projectrole)
        end
      _ ->
        conn
        |> render("error.json")
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
