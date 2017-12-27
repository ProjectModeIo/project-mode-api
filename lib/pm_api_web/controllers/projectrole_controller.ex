require IEx
defmodule PmApiWeb.ProjectroleController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectrole
  # alias PmApi.Projectmode.Project
  alias PmApi.Projectmode.Role

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    projectroles = Projectmode.list_projectroles()
    render(conn, "index.json", projectroles: projectroles)
  end

  def create(conn, params) do
    # project can only update project if they are project creator
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        project = Projectmode.get_project!(params["project_id"])
        if project |> Projectmode.verify_project_owner(current_user) do
          {:ok, %Role{}=role} = Projectmode.find_or_create_role_by(%{type: params["type"]})
          with {:ok, %Projectrole{} = projectrole } <- Projectmode.create_projectrole(%{project_id: project.id, role_id: role.id}) do
            conn
            |> put_status(:created)
            |> render("show.json", projectrole: projectrole)
          end
        else
          conn
          |> render("error.json")
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
