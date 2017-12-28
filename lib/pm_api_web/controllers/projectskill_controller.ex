defmodule PmApiWeb.ProjectskillController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectskill
  alias PmApi.Projectmode.Skill

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    projectskills = Projectmode.list_projectskills()
    render(conn, "index.json", projectskills: projectskills)
  end

  def create(conn, %{"project_id" => project_id, "name" => name}) do
    case PmApi.AccessHandler.verify_resource_owner(conn, %{ project_id: project_id }) do
      {:ok, project} ->
        {:ok, %Skill{}=skill} = Projectmode.find_or_create_skill_by(%{name: name})
        with {:ok, %Projectskill{} = projectskill } <- Projectmode.create_projectskill(%{project_id: project_id, skill_id: skill.id}) do
          conn
          |> put_status(:created)
          |> render("show.json", projectskill: projectskill)
        end
      _ ->
        conn
        |> render("error.json")
    end
  end

  def show(conn, %{"id" => id}) do
    projectskill = Projectmode.get_projectskill!(id)
    render(conn, "show.json", projectskill: projectskill)
  end

  def update(conn, %{"id" => id, "projectskill" => projectskill_params}) do
    projectskill = Projectmode.get_projectskill!(id)

    with {:ok, %Projectskill{} = projectskill} <- Projectmode.update_projectskill(projectskill, projectskill_params) do
      render(conn, "show.json", projectskill: projectskill)
    end
  end

  def delete(conn, %{"id" => id}) do
    projectskill = Projectmode.get_projectskill!(id)
    with {:ok, %Projectskill{}} <- Projectmode.delete_projectskill(projectskill) do
      send_resp(conn, :no_content, "")
    end
  end
end
